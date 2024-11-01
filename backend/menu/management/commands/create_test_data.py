# apps/menu/management/commands/create_test_data.py

from django.core.management.base import BaseCommand
from menu.models import Restaurant, MenuVersion, MenuSection, MenuItem

class Command(BaseCommand):
    help = 'Creates test data for the menu app'

    def handle(self, *args, **kwargs):
        # Create a restaurant
        restaurant = Restaurant.objects.create(
            name="Test Restaurant",
            address="123 Test St",
            phone="123-456-7890",
            cuisine_type="American"
        )

        # Create a menu version
        menu_version = MenuVersion.objects.create(
            restaurant=restaurant,
            version_number=1,
            effective_date="2024-01-01",
            source_type="manual",
            is_current=True
        )

        # Create sections
        appetizers = MenuSection.objects.create(
            version=menu_version,
            name="Appetizers",
            display_order=1
        )

        # Create items
        MenuItem.objects.create(
            section=appetizers,
            name="Spring Rolls",
            description="Fresh spring rolls",
            price=9.99,
            display_order=1
        )

        self.stdout.write(self.style.SUCCESS('Successfully created test data'))