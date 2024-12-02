from django.core.management.base import BaseCommand, CommandError
from django.core.management import call_command
from menu.tasks import process_menu_task

class Command(BaseCommand):
    help = 'Process menu PDFs using Celery'

    def add_arguments(self, parser):
        parser.add_argument('--file', type=str, help='Path to menu file')

    def handle(self, *args, **options):
        self.stdout.write("Starting task...")
        file_path = options.get('file')
        if not file_path:
            raise CommandError("File path is required")
        # Process the file directly
        call_command('process', file=file_path)
        self.stdout.write(self.style.SUCCESS(f"Processing completed"))
