# apps/menu/management/commands/create_test_data.py

from django.core.management.base import BaseCommand
from menu.models import Restaurant, MenuVersion, MenuSection, MenuItem, DietaryRestriction

class Command(BaseCommand):
    help = 'Creates test data for the menu app'

    def handle(self, *args, **kwargs):
        # Create dietary restrictions
        vegetarian, _ = DietaryRestriction.objects.get_or_create(name="Vegetarian")
        vegan, _ = DietaryRestriction.objects.get_or_create(name="Vegan")
        gluten_free, _ = DietaryRestriction.objects.get_or_create(name="Gluten Free")

        # Create a restaurant
        restaurant, _ = Restaurant.objects.get_or_create(
            name="The American Bistro",
            address="123 Main Street, Downtown",
            phone="(555) 123-4567",
            website="https://americanbistro.com",
            cuisine_type="American Contemporary"
        )

        # Create a menu version
        menu_version, _ = MenuVersion.objects.get_or_create(
            restaurant=restaurant,
            version_number=1,
            effective_date="2024-01-01",
            source_type="manual",
            is_current=True
        )

        # Create sections
        appetizers, _ = MenuSection.objects.get_or_create(
            version=menu_version,
            name="Starters",
            description="Perfect for sharing",
            display_order=1
        )

        mains, _ = MenuSection.objects.get_or_create(
            version=menu_version,
            name="Main Courses",
            description="Chef's signature dishes",
            display_order=2
        )

        sides, _ = MenuSection.objects.get_or_create(
            version=menu_version,
            name="Sides",
            display_order=3
        )

        desserts, _ = MenuSection.objects.get_or_create(
            version=menu_version,
            name="Desserts",
            description="Sweet endings",
            display_order=4
        )

        # Create appetizers
        bruschetta, _ = MenuItem.objects.get_or_create(
            section=appetizers,
            name="Tomato Bruschetta",
            description="Grilled sourdough topped with marinated tomatoes, fresh basil, and garlic",
            price=12.99,
            calories=320,
            display_order=1
        )
        bruschetta.dietary_restrictions.add(vegetarian)

        calamari, _ = MenuItem.objects.get_or_create(
            section=appetizers,
            name="Crispy Calamari",
            description="Lightly breaded squid served with lemon aioli and marinara sauce",
            price=15.99,
            calories=450,
            display_order=2
        )

        # Create mains
        steak, _ = MenuItem.objects.get_or_create(
            section=mains,
            name="Ribeye Steak",
            description="12oz prime ribeye with herb butter and red wine reduction",
            price=38.99,
            calories=850,
            spice_level=0,
            display_order=1
        )
        steak.dietary_restrictions.add(gluten_free)

        salmon, _ = MenuItem.objects.get_or_create(
            section=mains,
            name="Grilled Salmon",
            description="Fresh Atlantic salmon with lemon butter sauce",
            price=29.99,
            calories=620,
            display_order=2
        )
        salmon.dietary_restrictions.add(gluten_free)

        pasta, _ = MenuItem.objects.get_or_create(
            section=mains,
            name="Wild Mushroom Risotto",
            description="Creamy arborio rice with wild mushrooms and truffle oil",
            price=24.99,
            calories=780,
            display_order=3
        )
        pasta.dietary_restrictions.add(vegetarian)

        # Create sides
        fries, _ = MenuItem.objects.get_or_create(
            section=sides,
            name="Truffle Fries",
            description="Hand-cut fries with parmesan and truffle oil",
            price=8.99,
            calories=380,
            display_order=1
        )
        fries.dietary_restrictions.add(vegetarian)

        asparagus, _ = MenuItem.objects.get_or_create(
            section=sides,
            name="Grilled Asparagus",
            description="With lemon zest and olive oil",
            price=9.99,
            calories=120,
            display_order=2
        )
        asparagus.dietary_restrictions.add(vegan, gluten_free)

        # Create desserts
        chocolate, _ = MenuItem.objects.get_or_create(
            section=desserts,
            name="Molten Chocolate Cake",
            description="Warm chocolate cake with vanilla ice cream",
            price=11.99,
            calories=580,
            display_order=1
        )
        chocolate.dietary_restrictions.add(vegetarian)

        cheesecake, _ = MenuItem.objects.get_or_create(
            section=desserts,
            name="New York Cheesecake",
            description="Classic cheesecake with berry compote",
            price=10.99,
            calories=460,
            display_order=2
        )
        cheesecake.dietary_restrictions.add(vegetarian)

        self.stdout.write(self.style.SUCCESS('Successfully created test data'))