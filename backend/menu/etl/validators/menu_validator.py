from typing import Dict, List, Any
from decimal import Decimal
import json

class MenuValidationError(Exception):
    def __init__(self, message: str, details: Dict = None):
        self.message = message
        self.details = details or {}
        super().__init__(self.message)

class MenuValidator:
    @staticmethod
    def validate_price(price: Any) -> Decimal:
        try:
            if isinstance(price, str):
                # Remove currency symbols and convert to float
                price = price.replace('$', '').replace('£', '').replace('€', '').strip()
            return Decimal(str(price))
        except (ValueError, TypeError, decimal.InvalidOperation):
            raise MenuValidationError(f"Invalid price format: {price}")

    @staticmethod
    def validate_section(section: Dict) -> Dict:
        if not isinstance(section, dict):
            raise MenuValidationError("Section must be a dictionary")
        
        required_fields = ['name', 'items']
        for field in required_fields:
            if field not in section:
                raise MenuValidationError(f"Missing required field '{field}' in section")
        
        if not isinstance(section['items'], list):
            raise MenuValidationError("Section items must be a list")
        
        return section

    @staticmethod
    def validate_item(item: Dict) -> Dict:
        if not isinstance(item, dict):
            raise MenuValidationError("Menu item must be a dictionary")
        
        required_fields = ['name', 'price']
        for field in required_fields:
            if field not in item:
                raise MenuValidationError(f"Missing required field '{field}' in menu item")
        
        # Validate and clean price
        item['price'] = MenuValidator.validate_price(item['price'])
        
        # Ensure description exists (even if empty)
        if 'description' not in item:
            item['description'] = ''
            
        return item

    @classmethod
    def validate_menu_data(cls, data: Dict) -> Dict:
        if not isinstance(data, dict):
            raise MenuValidationError("Menu data must be a dictionary")
        
        if 'sections' not in data:
            raise MenuValidationError("Menu data must contain 'sections'")
        
        if not isinstance(data['sections'], list):
            raise MenuValidationError("Sections must be a list")
        
        validated_sections = []
        for section in data['sections']:
            validated_section = cls.validate_section(section)
            validated_items = []
            
            for item in section['items']:
                try:
                    validated_items.append(cls.validate_item(item))
                except MenuValidationError as e:
                    # Add context about which item failed
                    raise MenuValidationError(
                        f"Validation failed for item in section '{section['name']}'",
                        {'item_error': str(e), 'item': item}
                    )
            
            validated_section['items'] = validated_items
            validated_sections.append(validated_section)
        
        return {'sections': validated_sections} 