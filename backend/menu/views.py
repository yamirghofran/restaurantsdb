from rest_framework import viewsets, filters, status
from rest_framework.decorators import action
from rest_framework.response import Response
from django_filters.rest_framework import DjangoFilterBackend
from .models import (
    Restaurant,
    MenuVersion,
    MenuSection,
    MenuItem,
    DietaryRestriction
)
from .serializers import (
    RestaurantSerializer,
    RestaurantListSerializer,
    MenuVersionSerializer,
    MenuSectionSerializer,
    MenuItemSerializer,
    DietaryRestrictionSerializer
)

class RestaurantViewSet(viewsets.ModelViewSet):
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
        restaurant = self.get_object()
        versions = MenuVersion.objects.filter(restaurant=restaurant)
        serializer = MenuVersionSerializer(versions, many=True)
        return Response(serializer.data)

class MenuVersionViewSet(viewsets.ModelViewSet):
    queryset = MenuVersion.objects.all()
    serializer_class = MenuVersionSerializer
    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['restaurant', 'is_current', 'source_type']

    @action(detail=False, methods=['post'])
    def set_current(self, request):
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

class MenuItemViewSet(viewsets.ModelViewSet):
    queryset = MenuItem.objects.all()
    serializer_class = MenuItemSerializer
    filter_backends = [DjangoFilterBackend, filters.SearchFilter]
    filterset_fields = ['section', 'is_available', 'spice_level']
    search_fields = ['name', 'description']

    def get_queryset(self):
        queryset = MenuItem.objects.all()
        section_id = self.request.query_params.get('section', None)
        if section_id:
            queryset = queryset.filter(section_id=section_id)
        return queryset.order_by('display_order')

class DietaryRestrictionViewSet(viewsets.ModelViewSet):
    queryset = DietaryRestriction.objects.all()
    serializer_class = DietaryRestrictionSerializer
    filter_backends = [filters.SearchFilter]
    search_fields = ['name']
