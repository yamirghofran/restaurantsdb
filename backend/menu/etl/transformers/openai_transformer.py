from .base import BaseTransformer
from ..validators.menu_validator import MenuValidator, MenuValidationError
from openai import OpenAI
from typing import Dict
import json
import os
import logging

logger = logging.getLogger(__name__)

class OpenAITransformer(BaseTransformer):
    def __init__(self):
        api_key = os.getenv('OPENAI_API_KEY')
        if not api_key:
            raise ValueError("OPENAI_API_KEY environment variable is not set")
        self.client = OpenAI(api_key=api_key)
        self.validator = MenuValidator()
        
    def transform(self, text: str) -> Dict:
        prompt = """
        Extract menu information from the following text and format it as JSON.
        Follow these rules strictly:
        1. Group items into logical sections
        2. Include ALL prices found in the text
        3. Preserve item descriptions exactly as written
        4. Convert all prices to decimal numbers (e.g., "12.99" not "$12.99")
        5. Ensure every item has a name and price
        6. If a price range is given, use the lower price
        
        Required JSON format:
        {
            "sections": [
                {
                    "name": "section name",
                    "items": [
                        {
                            "name": "item name",
                            "description": "full item description",
                            "price": 12.99
                        }
                    ]
                }
            ]
        }
        
        Text to process:
        """
        
        try:
            response = self.client.chat.completions.create(
                model="gpt-4-turbo-preview",
                messages=[
                    {
                        "role": "system",
                        "content": "You are a precise menu information extractor. Extract all menu items, prices, and descriptions exactly as written. Format prices as decimal numbers without currency symbols."
                    },
                    {
                        "role": "user",
                        "content": prompt + text
                    }
                ],
                temperature=0.3,  # Lower temperature for more consistent output
                max_tokens=4000
            )
            
            # Extract the response text
            response_text = response.choices[0].message.content
            
            try:
                # Parse JSON response
                menu_data = json.loads(response_text)
                
                # Validate the data structure
                validated_data = self.validator.validate_menu_data(menu_data)
                
                return validated_data
                
            except json.JSONDecodeError as e:
                logger.error(f"Failed to parse OpenAI response as JSON: {response_text}")
                raise ValueError(f"OpenAI returned invalid JSON: {str(e)}")
                
            except MenuValidationError as e:
                logger.error(f"Menu validation failed: {str(e)}")
                raise
                
        except Exception as e:
            logger.error(f"OpenAI API error: {str(e)}")
            raise 