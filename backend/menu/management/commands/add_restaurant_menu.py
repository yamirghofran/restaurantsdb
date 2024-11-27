import json
from django.core.management.base import BaseCommand
from django.db import transaction
from django.utils import timezone
from menu.models import Restaurant, MenuVersion, MenuSection, MenuItem, DietaryRestriction, ProcessingLog

class Command(BaseCommand):
    help = 'Adds a restaurant menu from a JSON file'

    def add_arguments(self, parser):
        parser.add_argument('json_file', type=str, help='Path to the JSON file')

    def handle(self, *args, **options):
        json_file = options['json_file']

        with open(json_file) as f:
            data = json.load(f)

        with transaction.atomic():
            restaurant_data = data['restaurant']
            restaurant = Restaurant.objects.create(
                name=restaurant_data['name'],
                address=restaurant_data['address'],
                phone=restaurant_data['phone'],
                website=restaurant_data['website'],
                cuisine_type=restaurant_data['cuisine_type']
            )

            menu_version_data = data['menu_version']
            menu_version = MenuVersion.objects.create(
                restaurant=restaurant,
                version_number=menu_version_data['version_number'],
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
                for section_data in data['sections']:
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
