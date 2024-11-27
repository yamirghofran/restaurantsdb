from django.core.management.base import BaseCommand
from menu.models import (
    Restaurant, MenuVersion, MenuSection, DietaryRestriction,
    MenuItem, ProcessingLog, MenuStatistics, SearchIndex
)

class Command(BaseCommand):
    help = 'Delete all data from menu-related models'

    def handle(self, *args, **options):
        self.stdout.write("Starting data deletion...")

        # Delete in reverse order of dependencies
        self.stdout.write("Deleting SearchIndex entries...")
        SearchIndex.objects.all().delete()

        self.stdout.write("Deleting MenuStatistics entries...")
        MenuStatistics.objects.all().delete()

        self.stdout.write("Deleting ProcessingLog entries...")
        ProcessingLog.objects.all().delete()

        self.stdout.write("Deleting MenuItem entries...")
        MenuItem.objects.all().delete()

        self.stdout.write("Deleting DietaryRestriction entries...")
        DietaryRestriction.objects.all().delete()

        self.stdout.write("Deleting MenuSection entries...")
        MenuSection.objects.all().delete()

        self.stdout.write("Deleting MenuVersion entries...")
        MenuVersion.objects.all().delete()

        self.stdout.write("Deleting Restaurant entries...")
        Restaurant.objects.all().delete()

        self.stdout.write(self.style.SUCCESS("Successfully deleted all menu data"))
