from rest_framework import serializers
from .models import (
    Restaurant,
    MenuVersion,
    MenuSection,
    DietaryRestriction,
    MenuItem,
    MenuStatistics,
)

class DietaryRestrictionSerializer(serializers.ModelSerializer):
    class Meta:
        model = DietaryRestriction
        fields = ['id', 'name', 'description', 'icon_url']

class MenuItemSerializer(serializers.ModelSerializer):
    dietary_restrictions = DietaryRestrictionSerializer(many=True, read_only=True)

    class Meta:
        model = MenuItem
        fields = [
            'id',
            'name',
            'description',
            'price',
            'currency',
            'calories',
            'spice_level',
            'is_available',
            'display_order',
            'dietary_restrictions',
            'created_at',
        ]

class MenuSectionSerializer(serializers.ModelSerializer):
    menu_items = MenuItemSerializer(many=True, read_only=True, source='menuitem_set')

    class Meta:
        model = MenuSection
        fields = [
            'id',
            'name',
            'description',
            'display_order',
            'created_at',
            'menu_items',
        ]

class MenuVersionSerializer(serializers.ModelSerializer):
    sections = MenuSectionSerializer(many=True, read_only=True, source='menusection_set')

    class Meta:
        model = MenuVersion
        fields = [
            'id',
            'version_number',
            'effective_date',
            'source_type',
            'source_url',
            'is_current',
            'created_at',
            'sections',
        ]

class MenuStatisticsSerializer(serializers.ModelSerializer):
    class Meta:
        model = MenuStatistics
        fields = [
            'total_items',
            'avg_price',
            'vegetarian_count',
            'vegan_count',
            'gluten_free_count',
            'last_updated',
        ]

class RestaurantSerializer(serializers.ModelSerializer):
    current_menu = serializers.SerializerMethodField()
    statistics = MenuStatisticsSerializer(source='menustatistics', read_only=True)

    class Meta:
        model = Restaurant
        fields = [
            'id',
            'name',
            'address',
            'phone',
            'website',
            'cuisine_type',
            'created_at',
            'updated_at',
            'is_active',
            'current_menu',
            'statistics',
        ]

    def get_current_menu(self, obj):
        current_version = MenuVersion.objects.filter(
            restaurant=obj,
            is_current=True
        ).first()
        
        if current_version:
            return MenuVersionSerializer(current_version).data
        return None

# Optional - for list views that don't need all the nested data
class RestaurantListSerializer(serializers.ModelSerializer):
    class Meta:
        model = Restaurant
        fields = [
            'id',
            'name',
            'cuisine_type',
            'address',
            'is_active',
        ] 