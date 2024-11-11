from ..transformers.base import BaseExtractor
import PyPDF2
import io

class PDFExtractor(BaseExtractor):
    def extract(self, source_path: str) -> str:
        with open(source_path, 'rb') as file:
            reader = PyPDF2.PdfReader(file)
            text = ""
            for page in reader.pages:
                text += page.extract_text()
            return text 