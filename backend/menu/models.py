from django.db import models

# Create your models here.
class Restaurant(models.Model):
    name = models.CharField(max_length=255)
    address = models.TextField(null=True, blank=True)
    phone = models.CharField(max_length=50, null=True, blank=True)
    website = models.URLField(max_length=255, null=True, blank=True)
    cuisine_type = models.CharField(max_length=100, null=True, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    is_active = models.BooleanField(default=True)

    @classmethod
    def search(cls, query):
        return cls.objects.raw(
            """
            SELECT * FROM menu_restaurant 
            WHERE MATCH(name, address, cuisine_type) AGAINST (%s IN BOOLEAN MODE)
            """, 
            [query]
        )

    class Meta:
        indexes = [
            models.Index(fields=['name']),
            models.Index(fields=['cuisine_type']),
        ]

class MenuVersion(models.Model):
    SOURCE_CHOICES = [
        ('upload', 'Upload'),
        ('scrape', 'Scrape'),
        ('manual', 'Manual'),
    ]

    restaurant = models.ForeignKey(Restaurant, on_delete=models.CASCADE)
    version_number = models.IntegerField()
    effective_date = models.DateField()
    source_type = models.CharField(max_length=10, choices=SOURCE_CHOICES)
    source_url = models.TextField(null=True, blank=True)
    is_current = models.BooleanField(default=False)
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        unique_together = ['restaurant', 'version_number']
        indexes = [
            models.Index(fields=['effective_date']),
        ]

class MenuSection(models.Model):
    version = models.ForeignKey(MenuVersion, on_delete=models.CASCADE)
    name = models.CharField(max_length=100)
    description = models.TextField(null=True, blank=True)
    display_order = models.IntegerField()
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        indexes = [
            models.Index(fields=['version', 'display_order']),
        ]

class DietaryRestriction(models.Model):
    name = models.CharField(max_length=50, unique=True)
    description = models.TextField(null=True, blank=True)
    icon_url = models.URLField(max_length=255, null=True, blank=True)

class MenuItem(models.Model):
    section = models.ForeignKey(MenuSection, on_delete=models.CASCADE)
    name = models.CharField(max_length=255)
    description = models.TextField(null=True, blank=True)
    price = models.DecimalField(max_digits=10, decimal_places=2)
    currency = models.CharField(max_length=3, default='USD')
    calories = models.IntegerField(null=True, blank=True)
    spice_level = models.SmallIntegerField(null=True, blank=True)
    is_available = models.BooleanField(default=True)
    display_order = models.IntegerField()
    created_at = models.DateTimeField(auto_now_add=True)
    dietary_restrictions = models.ManyToManyField(DietaryRestriction)

    @classmethod
    def search(cls, query):
        return cls.objects.raw(
            """
            SELECT mi.*, r.id as restaurant_id, r.name as restaurant_name 
            FROM menu_menuitem mi
            JOIN menu_menusection ms ON mi.section_id = ms.id
            JOIN menu_menuversion mv ON ms.version_id = mv.id
            JOIN menu_restaurant r ON mv.restaurant_id = r.id
            WHERE MATCH(mi.name, mi.description) AGAINST (%s IN BOOLEAN MODE)
            """, 
            [query]
        )

    class Meta:
        indexes = [
            models.Index(fields=['section', 'display_order']),
            models.Index(fields=['name']),
            models.Index(fields=['price']),
        ]

class ProcessingLog(models.Model):
    PROCESS_CHOICES = [
        ('upload', 'Upload'),
        ('scrape', 'Scrape'),
        ('ai_processing', 'AI Processing'),
        ('validation', 'Validation'),
    ]
    
    STATUS_CHOICES = [
        ('started', 'Started'),
        ('completed', 'Completed'),
        ('failed', 'Failed'),
    ]

    version = models.ForeignKey(MenuVersion, on_delete=models.CASCADE)
    process_type = models.CharField(max_length=20, choices=PROCESS_CHOICES)
    status = models.CharField(max_length=10, choices=STATUS_CHOICES)
    start_time = models.DateTimeField()
    end_time = models.DateTimeField(null=True, blank=True)
    error_message = models.TextField(null=True, blank=True)
    metadata = models.JSONField(null=True, blank=True)

    class Meta:
        indexes = [
            models.Index(fields=['version', 'status']),
            models.Index(fields=['start_time']),
        ]

class MenuStatistics(models.Model):
    restaurant = models.OneToOneField(Restaurant, primary_key=True, on_delete=models.DO_NOTHING)
    total_items = models.IntegerField()
    avg_price = models.DecimalField(max_digits=10, decimal_places=2)
    last_updated = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'v_menu_statistics'

class SearchIndex(models.Model):
    ENTITY_CHOICES = [
        ('restaurant', 'Restaurant'),
        ('menu_item', 'Menu Item'),
        ('section', 'Section'),
    ]

    entity_type = models.CharField(max_length=20, choices=ENTITY_CHOICES)
    entity_id = models.PositiveIntegerField()
    content = models.TextField()
    last_updated = models.DateTimeField(auto_now=True)

    class Meta:
        unique_together = ['entity_type', 'entity_id']
        indexes = [
            models.Index(fields=['last_updated']),
        ]
