from abc import ABC, abstractmethod

class BaseExtractor(ABC):
    @abstractmethod
    def extract(self, source_path: str) -> str:
        """Extract text content from source"""
        pass 