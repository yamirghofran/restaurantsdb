from .base import BaseLoader
from menu.models import MenuVersion, MenuSection, MenuItem, ProcessingLog
from django.db import transaction
from django.utils import timezone
from typing import Dict
import logging

logger = logging.getLogger(__name__)

class MenuLoadError(Exception):
    pass

class MenuLoader(BaseLoader):
    def __init__(self, restaurant_id: int):
        self.restaurant_id = restaurant_id

    @transaction.atomic
    def load(self, data: Dict) -> MenuVersion:
        try:
            # Create new menu version
            version = MenuVersion.objects.create(
                restaurant_id=self.restaurant_id,
                version_number=self._get_next_version_number(),
                source_type='upload',
                effective_date=timezone.now().date()
            )

            # Create sections and items
            for section_idx, section_data in enumerate(data['sections']):
                section = MenuSection.objects.create(
                    version=version,
                    name=section_data['name'],
                    display_order=section_idx
                )
                
                for item_idx, item_data in enumerate(section_data['items']):
                    MenuItem.objects.create(
                        section=section,
                        name=item_data['name'],
                        description=item_data.get('description', ''),
                        price=item_data['price'],
                        display_order=item_idx
                    )
            
            # Log successful processing
            ProcessingLog.objects.create(
                version=version,
                process_type='upload',
                status='completed',
                start_time=timezone.now(),
                end_time=timezone.now(),
                metadata={'sections_count': len(data['sections'])}
            )
            
            return version

        except Exception as e:
            logger.error(f"Failed to load menu data: {str(e)}")
            # Create failure log
            ProcessingLog.objects.create(
                version=version if 'version' in locals() else None,
                process_type='upload',
                status='failed',
                start_time=timezone.now(),
                end_time=timezone.now(),
                error_message=str(e)
            )
            raise MenuLoadError(f"Failed to load menu: {str(e)}")

    def _get_next_version_number(self) -> int:
        latest = MenuVersion.objects.filter(restaurant_id=self.restaurant_id).order_by('-version_number').first()
        return (latest.version_number + 1) if latest else 1