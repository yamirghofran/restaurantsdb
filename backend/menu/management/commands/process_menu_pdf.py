from django.core.management.base import BaseCommand
from menu.etl.extractors.pdf_extractor import PDFExtractor
from menu.etl.transformers.openai_transformer import OpenAITransformer
from menu.etl.loaders.menu_loader import MenuLoader, MenuLoadError
from menu.etl.validators.menu_validator import MenuValidationError
from menu.models import ProcessingLog
from django.utils import timezone
import logging
import glob
import os

logger = logging.getLogger(__name__)

class Command(BaseCommand):
    help = 'Process one or more menu PDF files and load them into the database'

    def add_arguments(self, parser):
        parser.add_argument('pdf_path', type=str, help='Path to PDF file or directory containing PDFs')
        parser.add_argument('restaurant_id', type=int, help='Restaurant ID')
        parser.add_argument('--recursive', action='store_true', help='Recursively process PDFs in subdirectories')

    def handle(self, *args, **options):
        pdf_path = options['pdf_path']
        
        # Handle directory of PDFs
        if os.path.isdir(pdf_path):
            pattern = '**/*.pdf' if options['recursive'] else '*.pdf'
            pdf_files = glob.glob(os.path.join(pdf_path, pattern), recursive=options['recursive'])
        else:
            pdf_files = [pdf_path]
            
        if not pdf_files:
            self.stdout.write(self.style.WARNING('No PDF files found'))
            return

        for pdf_file in pdf_files:
            self.process_single_pdf(pdf_file, options['restaurant_id'])

    def process_single_pdf(self, pdf_path: str, restaurant_id: int):
        log = ProcessingLog.objects.create(
            process_type='upload',
            status='started',
            start_time=timezone.now()
        )
        
        try:
            self.stdout.write(f"Processing {pdf_path}...")
            
            # Extract
            extractor = PDFExtractor()
            text = extractor.extract(pdf_path)
            
            if not text.strip():
                raise ValueError("Extracted text is empty")
            
            # Transform
            transformer = OpenAITransformer()
            data = transformer.transform(text)
            
            # Load
            loader = MenuLoader(restaurant_id)
            version = loader.load(data)
            
            log.version = version
            log.status = 'completed'
            log.end_time = timezone.now()
            log.save()
            
            self.stdout.write(self.style.SUCCESS(
                f'Successfully processed {pdf_path}. Version ID: {version.id}'
            ))
            
        except MenuValidationError as e:
            self.stdout.write(self.style.ERROR(
                f'Validation error processing {pdf_path}: {e.message}'
            ))
            if hasattr(e, 'details'):
                self.stdout.write(self.style.ERROR(f'Details: {e.details}'))
            log.status = 'failed'
            log.error_message = str(e)
            
        except MenuLoadError as e:
            self.stdout.write(self.style.ERROR(
                f'Database error processing {pdf_path}: {str(e)}'
            ))
            log.status = 'failed'
            log.error_message = str(e)
            
        except Exception as e:
            self.stdout.write(self.style.ERROR(
                f'Unexpected error processing {pdf_path}: {str(e)}'
            ))
            log.status = 'failed'
            log.error_message = str(e)
            
        finally:
            log.end_time = timezone.now()
            log.save()