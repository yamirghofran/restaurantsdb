from abc import ABC, abstractmethod

class BaseExtractor(ABC):
    @abstractmethod
    def extract(self, source_path: str) -> str:
        """Extract text content from source"""
        pass 

class BaseTransformer(ABC):
    @abstractmethod
    def transform(self, text: str) -> dict:
        """Transform extracted text into structured data"""
        pass 