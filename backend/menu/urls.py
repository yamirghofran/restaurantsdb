from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import (
    RestaurantViewSet,
    MenuVersionViewSet,
    MenuSectionViewSet,
    MenuItemViewSet,
    DietaryRestrictionViewSet,
    MenuStatisticsViewSet
)

router = DefaultRouter()
router.register(r'restaurants', RestaurantViewSet)
router.register(r'menu-versions', MenuVersionViewSet)
router.register(r'menu-sections', MenuSectionViewSet)
router.register(r'menu-items', MenuItemViewSet)
router.register(r'dietary-restrictions', DietaryRestrictionViewSet)
router.register(r'statistics', MenuStatisticsViewSet)

urlpatterns = [
    path('', include(router.urls)),
] 