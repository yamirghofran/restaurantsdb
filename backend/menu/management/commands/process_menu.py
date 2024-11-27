from django.core.management.base import BaseCommand
from django.conf import settings
from pyzerox import zerox
import os
import json
import asyncio


model = "gpt-4o-mini" ## openai model


## placeholder for additional model kwargs which might be required for some models
kwargs = {}

## system prompt to use for the vision model
custom_system_prompt = None

class Command(BaseCommand):
    help = 'Process PDF menus using Zerox'

    async def process_pdfs(self):
        self.stdout.write("Starting PDF processing...")
        
        pdf_dir = os.path.join(settings.BASE_DIR, "pdfs")
        output_dir = os.path.join(settings.BASE_DIR, "output_test")
        
        self.stdout.write(f"PDF directory: {pdf_dir}")
        self.stdout.write(f"Output directory: {output_dir}")
        
        os.makedirs(output_dir, exist_ok=True)
        results = []
        
        pdf_files = [f for f in os.listdir(pdf_dir) if f.endswith(".pdf")]
        self.stdout.write(f"Found {len(pdf_files)} PDF files to process")
        
        for filename in pdf_files:
            self.stdout.write(f"Processing {filename}...")
            file_path = os.path.join(pdf_dir, filename)
            try:
                result = await zerox(
                    file_path=file_path,
                    model=model,
                    output_dir=output_dir,
                    custom_system_prompt=custom_system_prompt,
                    select_pages=None,
                    **kwargs
                )
                results.append(result)
                self.stdout.write(f"Successfully processed {filename}")
            except Exception as e:
                self.stdout.write(self.style.ERROR(f"Error processing {filename}: {str(e)}"))
                
        self.stdout.write(f"Completed processing {len(results)} files successfully")
        return results

    def handle(self, *args, **options):
        self.stdout.write("Starting command execution...")
        try:
            results = asyncio.run(self.process_pdfs())
            self.stdout.write(self.style.SUCCESS("Command completed successfully"))
            self.stdout.write(str(results))
        except Exception as e:
            self.stdout.write(self.style.ERROR(f"Command failed: {str(e)}"))
