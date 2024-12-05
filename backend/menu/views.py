from rest_framework import viewsets, filters, status
from rest_framework.decorators import action
from rest_framework.response import Response
from django_filters.rest_framework import DjangoFilterBackend
from .models import (
    Restaurant,
    MenuVersion,
    MenuSection,
    MenuItem,
    DietaryRestriction,
    MenuStatistics
)
from .serializers import (
    RestaurantSerializer,
    RestaurantListSerializer,
    MenuVersionSerializer,
    MenuSectionSerializer,
    MenuItemSerializer,
    DietaryRestrictionSerializer,
    MenuStatisticsSerializer,
    MenuItemSearchSerializer
)
from rest_framework.parsers import MultiPartParser, FormParser
from django.core.management import call_command
from django.core.files.storage import default_storage
import os
from django_filters import FilterSet, NumberFilter, ModelMultipleChoiceFilter

class RestaurantViewSet(viewsets.ModelViewSet):
    """
    ViewSet for managing restaurant data.
    Supports CRUD operations, filtering by cuisine type and active status,
    and searching by name, address and cuisine type.
    """
    queryset = Restaurant.objects.all()
    filter_backends = [DjangoFilterBackend, filters.SearchFilter]
    filterset_fields = ['cuisine_type', 'is_active']
    search_fields = ['name', 'address', 'cuisine_type']

    def get_serializer_class(self):
        if self.action == 'list':
            return RestaurantListSerializer
        return RestaurantSerializer

    @action(detail=True, methods=['get'])
    def menu_versions(self, request, pk=None):
        """
        Get all menu versions for a specific restaurant.
        Returns serialized menu version data including sections and items.
        """
        restaurant = self.get_object()
        versions = MenuVersion.objects.filter(restaurant=restaurant)
        serializer = MenuVersionSerializer(versions, many=True)
        return Response(serializer.data)
    
    @action(detail=False, methods=['get'])
    def unified_search(self, request):
        """
        Search across restaurants and menu items.
        Returns matching restaurants and menu items in a combined response.
        
        Query params:
            q: Search query string
        """
        query = request.query_params.get('q', '')
        if not query:
            return Response([])
            
        restaurants = Restaurant.search(query)
        menu_items = MenuItem.search(query)

        response = {
            'restaurants': RestaurantListSerializer(restaurants, many=True).data,
            'menu_items': MenuItemSearchSerializer(menu_items, many=True).data
        }
            
        return Response(response)

    def retrieve(self, request, *args, **kwargs):
        instance = self.get_object()
        # Get the current menu version
        current_menu = MenuVersion.objects.filter(
            restaurant=instance,
            is_current=True
        ).first()
        
        # Use the detailed serializer
        serializer = self.get_serializer(instance)
        data = serializer.data
        
        # Add current menu data if it exists
        if current_menu:
            data['current_menu'] = MenuVersionSerializer(current_menu).data
            
        return Response(data)

    @action(detail=True, methods=['get'])
    def full_details(self, request, pk=None):
        """
        Get complete restaurant details including:
        - Current menu with all sections and items
        - All menu versions with current version marked
        - Restaurant metadata
        """
        restaurant = self.get_object()
        
        # Get current menu version
        current_menu = MenuVersion.objects.filter(
            restaurant=restaurant,
            is_current=True
        ).first()
        
        # Get all menu versions and mark the current one
        menu_versions = MenuVersion.objects.filter(restaurant=restaurant)
        versions_data = []
        for version in menu_versions:
            version_data = MenuVersionSerializer(version).data
            version_data['is_current'] = version.id == current_menu.id if current_menu else False
            versions_data.append(version_data)
        
        # If there's a current menu, get its sections and items
        menu_data = None
        if current_menu:
            sections = MenuSection.objects.filter(version=current_menu).order_by('display_order')
            sections_data = []
            
            for section in sections:
                items = MenuItem.objects.filter(section=section).order_by('display_order')
                sections_data.append({
                    **MenuSectionSerializer(section).data,
                    'items': MenuItemSerializer(items, many=True).data
                })
            
            menu_data = {
                **MenuVersionSerializer(current_menu).data,
                'sections': sections_data
            }
        
        response_data = {
            **self.get_serializer(restaurant).data,
            'current_menu': menu_data,
            'all_versions': versions_data
        }
        
        return Response(response_data)

    @action(detail=False, methods=['post'], parser_classes=[MultiPartParser, FormParser])
    def process_menu(self, request):
        """
        Process uploaded menu file (PDF or HTML) and create menu data.
        
        Request params:
            file: Menu file to process
            
        Returns:
            200: Success response
            400: Invalid file format
            500: Processing error
        """
        menu_file = request.FILES.get('file')
        if not menu_file:
            return Response(
                {'error': 'No file provided'}, 
                status=status.HTTP_400_BAD_REQUEST
            )

        # Check file extension
        ext = os.path.splitext(menu_file.name)[1].lower()
        if ext not in ['.pdf', '.html']:
            return Response(
                {'error': 'Invalid file format. Only PDF and HTML files are supported'},
                status=status.HTTP_400_BAD_REQUEST
            )

        try:
            # Save file temporarily
            file_path = default_storage.save(f'temp_menus/{menu_file.name}', menu_file)
            
            # Process the file
            call_command('process', file=default_storage.path(file_path))
            
            # Cleanup
            default_storage.delete(file_path)
            
            return Response({'status': 'success'})

        except Exception as e:
            return Response(
                {'error': str(e)}, 
                status=status.HTTP_500_INTERNAL_SERVER_ERROR
            )

class MenuVersionViewSet(viewsets.ModelViewSet):
    """
    ViewSet for managing menu versions.
    Supports CRUD operations and filtering by restaurant, current status and source type.
    """
    queryset = MenuVersion.objects.all()
    serializer_class = MenuVersionSerializer
    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['restaurant', 'is_current', 'source_type']

    @action(detail=False, methods=['post'])
    def set_current(self, request):
        """
        Set a menu version as current for a restaurant.
        Unsets current flag on all other versions for that restaurant.
        
        Request body:
            restaurant_id: ID of restaurant
            version_id: ID of version to set as current
        """
        restaurant_id = request.data.get('restaurant_id')
        version_id = request.data.get('version_id')
        
        try:
            # Set all versions for this restaurant to not current
            MenuVersion.objects.filter(restaurant_id=restaurant_id).update(is_current=False)
            # Set the specified version as current
            version = MenuVersion.objects.get(id=version_id, restaurant_id=restaurant_id)
            version.is_current = True
            version.save()
            return Response({'status': 'success'})
        except MenuVersion.DoesNotExist:
            return Response(
                {'error': 'Version not found'},
                status=status.HTTP_404_NOT_FOUND
            )

class MenuSectionViewSet(viewsets.ModelViewSet):
    """
    ViewSet for managing menu sections.
    Supports CRUD operations and filtering by menu version.
    Returns sections ordered by display_order.
    """
    queryset = MenuSection.objects.all()
    serializer_class = MenuSectionSerializer
    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['version']

    def get_queryset(self):
        queryset = MenuSection.objects.all()
        version_id = self.request.query_params.get('version', None)
        if version_id:
            queryset = queryset.filter(version_id=version_id)
        return queryset.order_by('display_order')

class MenuItemFilter(FilterSet):
    """
    Filter for menu items supporting:
    - Multiple dietary restrictions (AND filter)
    - Section, availability and spice level filtering
    """
    dietary_restrictions = ModelMultipleChoiceFilter(
        queryset=DietaryRestriction.objects.all(),
        method='filter_dietary_restrictions'
    )

    def filter_dietary_restrictions(self, queryset, name, value):
        if value:
            for restriction in value:
                queryset = queryset.filter(dietary_restrictions=restriction)
        return queryset

    class Meta:
        model = MenuItem
        fields = ['section', 'is_available', 'spice_level', 'dietary_restrictions']

class MenuItemViewSet(viewsets.ModelViewSet):
    """
    ViewSet for managing menu items.
    Supports CRUD operations, filtering by section/availability/spice level/dietary restrictions,
    and searching by name and description.
    """
    queryset = MenuItem.objects.all()
    serializer_class = MenuItemSerializer
    filter_backends = [DjangoFilterBackend, filters.SearchFilter]
    filterset_class = MenuItemFilter
    search_fields = ['name', 'description']

class DietaryRestrictionViewSet(viewsets.ModelViewSet):
    queryset = DietaryRestriction.objects.all()
    serializer_class = DietaryRestrictionSerializer
    filter_backends = [filters.SearchFilter]
    search_fields = ['name']

class MenuStatisticsFilter(FilterSet):
    """
    Filter for menu statistics supporting:
    - Min/max total items
    - Min/max average price
    """
    min_items = NumberFilter(field_name='total_items', lookup_expr='gte')
    max_items = NumberFilter(field_name='total_items', lookup_expr='lte')
    min_price = NumberFilter(field_name='avg_price', lookup_expr='gte')
    max_price = NumberFilter(field_name='avg_price', lookup_expr='lte')

    class Meta:
        model = MenuStatistics
        fields = ['min_items', 'max_items', 'min_price', 'max_price']

class MenuStatisticsViewSet(viewsets.ReadOnlyModelViewSet):
    """
    Read-only ViewSet for menu statistics.
    Provides aggregated stats per restaurant including total items and average prices.
    """
    queryset = MenuStatistics.objects.all()
    serializer_class = MenuStatisticsSerializer
    filter_backends = [DjangoFilterBackend]
    filterset_class = MenuStatisticsFilter

