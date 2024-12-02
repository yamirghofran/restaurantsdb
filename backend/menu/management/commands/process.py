import json
from django.core.management.base import BaseCommand
from django.db import transaction
from django.utils import timezone
from menu.models import Restaurant, MenuVersion, MenuSection, MenuItem, DietaryRestriction, ProcessingLog
from django.conf import settings
from pyzerox import zerox
import os
import asyncio
from openai import OpenAI
client = OpenAI(api_key=os.environ.get("OPENAI_API_KEY"))

class Command(BaseCommand):
    help = 'Process menu data'

    def add_arguments(self, parser):
        parser.add_argument('--file', type=str, help='Path to menu file')

    async def process_pdf(self, file_path):
        output_dir = os.path.join(settings.BASE_DIR, "temp_output")
        os.makedirs(output_dir, exist_ok=True)
        
        result = await zerox(
            file_path=file_path,
            model="gpt-4o-mini",
            output_dir=output_dir,
            custom_system_prompt=None,
            select_pages=None
        )
        return "\n".join(page.content for page in result.pages)

    def handle(self, *args, **options):
        self.stdout.write('Processing menu data...')
        try:
            file_path = options['file']
            content = None
            
            if file_path.endswith('.pdf'):
                self.stdout.write('Processing PDF file...')
                content = asyncio.run(self.process_pdf(file_path))
            elif file_path.endswith('.html'):
                self.stdout.write('Processing HTML file...')
                with open(file_path, 'r') as f:
                    content = f.read()
            else:
                raise ValueError('Unsupported file format. Only PDF and HTML files are supported.')

            self.stdout.write('Converting to JSON schema...')
            response = client.chat.completions.create(
                model="gpt-4o",
                messages=[
                    {
                        "role": "system", 
                        "content": [{"type": "text", "text": "Return information from a restaurant menu in the specified json schema. Make sure to include every single piece of information, sections, menu items, etc. in the menu. Do not leave out any information."}]
                    },
                    {
                        "role": "user",
                        "content": content
                    }
                ],
                response_format={
                    "type": "json_schema",
                    "json_schema": {
                        "name": "menu_response",
                        "strict": True,
                        "schema": {
                            "type": "object",
                            "properties": {
                                "restaurant": {
                                    "type": "object",
                                    "properties": {
                                        "name": {"type": "string"},
                                        "address": {"type": "string"},
                                        "phone": {"type": "string"},
                                        "website": {"type": "string"},
                                        "cuisine_type": {"type": "string"}
                                    },
                                    "required": ["name", "address", "phone", "website", "cuisine_type"],
                                    "additionalProperties": False
                                },
                                "menu_version": {
                                    "type": "object", 
                                    "properties": {
                                        "version_number": {"type": "integer"},
                                        "effective_date": {"type": "string"},
                                        "source_type": {
                                            "type": "string",
                                            "enum": ["upload", "scrape", "manual"]
                                        },
                                        "source_url": {"type": "string"}
                                    },
                                    "required": ["version_number", "effective_date", "source_type", "source_url"],
                                    "additionalProperties": False
                                },
                                "sections": {
                                    "type": "array",
                                    "items": {
                                        "type": "object",
                                        "properties": {
                                            "name": {"type": "string"},
                                            "description": {"type": "string"},
                                            "display_order": {"type": "integer"},
                                            "menu_items": {
                                                "type": "array",
                                                "items": {
                                                    "type": "object",
                                                    "properties": {
                                                        "name": {"type": "string"},
                                                        "description": {"type": "string"},
                                                        "price": {"type": "number"},
                                                        "currency": {"type": "string"},
                                                        "calories": {"type": "integer"},
                                                        "spice_level": {"type": "integer"},
                                                        "is_available": {"type": "boolean"},
                                                        "display_order": {"type": "integer"},
                                                        "dietary_restrictions": {
                                                            "type": "array",
                                                            "items": {"type": "string"}
                                                        }
                                                    },
                                                    "required": ["name", "description", "price", "currency", "calories", "spice_level", "is_available", "display_order", "dietary_restrictions"],
                                                    "additionalProperties": False
                                                }
                                            }
                                        },
                                        "required": ["name", "description", "display_order", "menu_items"],
                                        "additionalProperties": False
                                    }
                                }
                            },
                            "required": ["restaurant", "menu_version", "sections"],
                            "additionalProperties": False
                        }
                    }
                },
                temperature=0.85,
                max_tokens=16383,
                top_p=1,
                frequency_penalty=0,
                presence_penalty=0
                )
            menu_json = json.loads(response.choices[0].message.content)
            
            with transaction.atomic():
                restaurant_data = menu_json['restaurant']
                restaurant, _ = Restaurant.objects.get_or_create(
                    name=restaurant_data['name'],
                    defaults={
                        'address': restaurant_data['address'],
                        'phone': restaurant_data['phone'][:50],
                        'website': restaurant_data['website'],
                        'cuisine_type': restaurant_data['cuisine_type'][:100]
                    }
                )

                # Set all previous versions to not current
                MenuVersion.objects.filter(restaurant=restaurant).update(is_current=False)

                # Get the latest version number for this restaurant
                latest_version = MenuVersion.objects.filter(restaurant=restaurant).order_by('-version_number').first()
                new_version_number = (latest_version.version_number + 1) if latest_version else 1

                # Create new version
                menu_version_data = menu_json['menu_version']
                menu_version = MenuVersion.objects.create(
                    restaurant=restaurant,
                    version_number=new_version_number,
                    effective_date=menu_version_data['effective_date'],
                    source_type=menu_version_data['source_type'],
                    source_url=menu_version_data['source_url'],
                    is_current=True
                )

                start_time = timezone.now()
                processing_log = ProcessingLog.objects.create(
                    version=menu_version,
                    process_type='upload',
                    status='started',
                    start_time=start_time
                )

                try:
                    for section_data in menu_json['sections']:
                        section = MenuSection.objects.create(
                            version=menu_version,
                            name=section_data['name'],
                            description=section_data['description'],
                            display_order=section_data['display_order']
                        )

                        for item_data in section_data['menu_items']:
                            item = MenuItem.objects.create(
                                section=section,
                                name=item_data['name'],
                                description=item_data['description'],
                                price=item_data['price'],
                                currency=item_data['currency'],
                                calories=item_data['calories'],
                                spice_level=item_data['spice_level'],
                                is_available=item_data['is_available'],
                                display_order=item_data['display_order']
                            )

                            for restriction_name in item_data['dietary_restrictions']:
                                restriction, _ = DietaryRestriction.objects.get_or_create(name=restriction_name)
                                item.dietary_restrictions.add(restriction)

                    processing_log.status = 'completed'
                    processing_log.end_time = timezone.now()
                    processing_log.save()

                    self.stdout.write(self.style.SUCCESS('Restaurant menu added successfully'))
                except Exception as e:
                    processing_log.status = 'failed'
                    processing_log.end_time = timezone.now()
                    processing_log.error_message = str(e)
                    processing_log.save()
                    raise
            
        except Exception as e:
            self.stdout.write(self.style.ERROR(f'Error processing menu data: {str(e)}'))
