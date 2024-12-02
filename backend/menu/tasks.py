from celery import shared_task
from django.conf import settings
from django.core.management import call_command
from django.core.files.storage import default_storage
from django.db import transaction
from django.utils import timezone
from menu.models import Restaurant, MenuVersion, MenuSection, MenuItem, DietaryRestriction, ProcessingLog
import asyncio
from pyzerox import zerox
import os
import json
from openai import OpenAI
client = OpenAI(api_key=os.environ.get("OPENAI_API_KEY"))

@shared_task
def process_menu_task(file_path):
    """Process uploaded menu files using Celery"""
    try:
        # Create a processing log entry
        processing_log = ProcessingLog.objects.create(
            process_type='upload',
            status='started',
            start_time=timezone.now(),
            celery_task_id=process_menu_task.request.id
        )
        
        # Execute the processing
        from menu.management.commands.process import Command
        command = Command()
        command.handle(file=file_path)
        
        # Update processing log
        processing_log.status = 'completed'
        processing_log.end_time = timezone.now()
        processing_log.save()
        
        # Cleanup
        default_storage.delete(file_path)
        
        return {'status': 'success'}
        
    except Exception as e:
        if 'processing_log' in locals():
            processing_log.status = 'failed'
            processing_log.end_time = timezone.now()
            processing_log.error_message = str(e)
            processing_log.save()
            
        # Cleanup on error
        default_storage.delete(file_path)
        return {'status': 'error', 'message': str(e)}
