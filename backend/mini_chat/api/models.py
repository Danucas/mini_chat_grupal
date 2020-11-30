from django.contrib.auth.models import AbstractUser
from django.db import models

class User(AbstractUser):
    """
    User definition
    """
    username = models.CharField(max_length=300, unique=True)
    # password = models.CharField(max_length=40, null=False, default='')
    email = models.CharField(max_length=40)
    profile = models.CharField(max_length=300, null=True)
    last_sign_in = models.DateField(null=True)

class Room(models.Model):
    """
    Room definition
    """
    name = models.CharField(max_length=100)
    users = models.ManyToManyField(User,blank=True)

class Message(models.Model):
    """
    Message definition
    """
    content = models.CharField(max_length=300)
    media = models.BooleanField(null=False, default=False)
    media_src = models.CharField(max_length=200, null=True)
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    room = models.ForeignKey(Room, on_delete=models.CASCADE)
    created_at = models.DateTimeField(null=True)


