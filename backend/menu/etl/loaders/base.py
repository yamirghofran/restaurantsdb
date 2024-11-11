from abc import ABC, abstractmethod

class BaseLoader(ABC):
    @abstractmethod
    def load(self, data):
        """Load data into the system"""
        pass
