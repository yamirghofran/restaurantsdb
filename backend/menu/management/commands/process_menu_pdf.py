from django.core.management.base import BaseCommand
from menu.etl.extractors.pdf_extractor import PDFExtractor
from menu.etl.transformers.openai_transformer import OpenAITransformer
from menu.etl.loaders.menu_loader import MenuLoader, MenuLoadError
from menu.etl.validators.menu_validator import MenuValidationError
from menu.models import ProcessingLog, Restaurant
from django.utils import timezone
import logging
import glob
import os
from base64 import b64encode
import asyncio
from django.db import transaction
from asgiref.sync import sync_to_async

logger = logging.getLogger(__name__)

class Command(BaseCommand):
    help = 'Process one or more menu PDF files or images and load them into the database'

    def add_arguments(self, parser):
        parser.add_argument('file_path', type=str, help='Path to PDF/image file or directory containing files')
        parser.add_argument('--restaurant-id', type=int, help='Restaurant ID (optional)', required=False)
        parser.add_argument('--restaurant-name', type=str, help='Restaurant name (required if restaurant-id not provided)', required=False)
        parser.add_argument('--recursive', action='store_true', help='Recursively process files in subdirectories')

    def handle(self, *args, **options):
        file_path = options['file_path']
        restaurant_id = options.get('restaurant_id')
        restaurant_name = options.get('restaurant_name')

        if not restaurant_id and not restaurant_name:
            self.stdout.write(self.style.ERROR('Either restaurant-id or restaurant-name must be provided'))
            return

        # Get or create restaurant if name is provided
        if not restaurant_id:
            restaurant, created = Restaurant.objects.get_or_create(
                name=restaurant_name,
                defaults={'is_active': True}
            )
            restaurant_id = restaurant.id
            if created:
                self.stdout.write(self.style.SUCCESS(f'Created new restaurant: {restaurant_name} (ID: {restaurant_id})'))
            else:
                self.stdout.write(self.style.SUCCESS(f'Using existing restaurant: {restaurant_name} (ID: {restaurant_id})'))
        
        # Handle directory of files
        if os.path.isdir(file_path):
            pattern = '**/*.[pj][dnp][fg]*' if options['recursive'] else '*.[pj][dnp][fg]*'
            files = glob.glob(os.path.join(file_path, pattern), recursive=options['recursive'])
        else:
            files = [file_path]
            
        if not files:
            self.stdout.write(self.style.WARNING('No PDF or image files found'))
            return

        for file in files:
            asyncio.run(self.process_single_file(file, restaurant_id))

    async def process_single_file(self, file_path: str, restaurant_id: int):
        log = None  # Initialize log to None
        try:
            self.stdout.write(f"Processing {file_path}...")
            
            # Determine file type and extract content
            file_ext = os.path.splitext(file_path)[1].lower()
            transformer = OpenAITransformer()
            
            if file_ext == '.pdf':
                # Extract text from PDF
                extractor = PDFExtractor()
                text = extractor.extract(file_path)
                if not text.strip():
                    raise ValueError("Extracted text is empty")
                data = transformer.transform(text)
            elif file_ext in ['.jpg', '.jpeg', '.png']:
                # Process image directly with OpenAI
                with open(file_path, 'rb') as image_file:
                    image_data = image_file.read()
                    data = await transformer.transform_image(image_data)  # Await the async call
            else:
                raise ValueError(f"Unsupported file type: {file_ext}")
            
            # Load
            loader = MenuLoader(restaurant_id)
            version = await sync_to_async(loader.load)(data)
            
            # Log successful processing
            log = await sync_to_async(ProcessingLog.objects.create)(
                version=version,
                process_type='upload',
                status='completed',
                start_time=timezone.now(),
                end_time=timezone.now()
            )
            
            self.stdout.write(self.style.SUCCESS(
                f'Successfully processed {file_path}. Version ID: {version.id}'
            ))
            
        except MenuValidationError as e:
            self.stdout.write(self.style.ERROR(
                f'Validation error processing {file_path}: {e.message}'
            ))
            if hasattr(e, 'details'):
                self.stdout.write(self.style.ERROR(f'Details: {e.details}'))
            if log:
                log.status = 'failed'
                log.error_message = str(e)
            
        except MenuLoadError as e:
            self.stdout.write(self.style.ERROR(
                f'Database error processing {file_path}: {str(e)}'
            ))
            if log:
                log.status = 'failed'
                log.error_message = str(e)
            
        except Exception as e:
            self.stdout.write(self.style.ERROR(
                f'Unexpected error processing {file_path}: {str(e)}'
            ))
            if log:
                log.status = 'failed'
                log.error_message = str(e)
            
        finally:
            if log:
                log.end_time = timezone.now()
                await sync_to_async(log.save)()