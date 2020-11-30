from django.core.management.base import BaseCommand
from api.models import User

class Command(BaseCommand):
    """
    Creates the admin user
    """
    def handle(self, *args, **kwargs):
        user = User()
        user.__class__.objects.create_superuser('admin', 'admin@mail.com', 'admin')
        user.password = 'admin'
        user.save()
