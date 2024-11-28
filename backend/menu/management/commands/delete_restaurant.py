from django.core.management.base import BaseCommand
from menu.models import Restaurant, MenuVersion, MenuSection, MenuItem, ProcessingLog, MenuStatistics, SearchIndex

class Command(BaseCommand):
    help = 'Delete a restaurant and all related data by ID'

    def add_arguments(self, parser):
        parser.add_argument('restaurant_id', type=int, help='ID of the restaurant to delete')

    def handle(self, *args, **options):
        restaurant_id = options['restaurant_id']
        
        try:
            restaurant = Restaurant.objects.get(id=restaurant_id)
            
            # Delete all menu items first
            MenuItem.objects.filter(section__version__restaurant=restaurant).delete()
            
            # Delete all sections
            MenuSection.objects.filter(version__restaurant=restaurant).delete()
            
            # Delete processing logs
            ProcessingLog.objects.filter(version__restaurant=restaurant).delete()
            
            # Delete search index entries for this restaurant
            SearchIndex.objects.filter(
                entity_type='restaurant',
                entity_id=restaurant.id
            ).delete()
            
            # Delete menu versions
            MenuVersion.objects.filter(restaurant=restaurant).delete()
            
            # Finally delete the restaurant
            restaurant.delete()
            
            self.stdout.write(
                self.style.SUCCESS(f'Successfully deleted restaurant {restaurant_id} and all related data')
            )
            
        except Restaurant.DoesNotExist:
            self.stdout.write(
                self.style.ERROR(f'Restaurant with id {restaurant_id} does not exist')
            )
