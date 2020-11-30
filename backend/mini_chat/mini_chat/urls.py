"""mini_chat URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path, include
from rest_framework import routers
from rest_framework.authtoken import views as auth_views
from api import views

router = routers.DefaultRouter()
# router.register(r'users', views.users)# views.UserViewSet)
# router.register(r'groups', views.GroupViewSet)
# router.register(r'messages', views.MessageViewSet)
# router.register(r'rooms', views.RoomViewSet)

urlpatterns = [
    path('admin/', admin.site.urls),
    path('api-token-auth/', views.get_token),
    path('', include(router.urls)),
    path('users', views.users),
    path('login/', views.login, name='login'),
    path('register/', views.register, name='register'),
    path('dashboard', views.dashboard, name='dashboard'),
    path('rooms', views.rooms, name='rooms'),
    path('rooms/<int:roomId>/', views.rooms_delete, name='rooms_delete'),
    path('rooms/<int:id>/users', views.rooms_users, name='rooms_users'),
    path('rooms/<int:roomId>/messages/all/', views.messages_get, name='rooms_messages'),
    path('rooms/<int:roomId>/messages/', views.messages_post, name='rooms_messages'),
    path('messages/<int:messId>/', views.messages_del, name='rooms_messages_delete'),
    path('media/', views.media_post, name='rooms_media_upload'),
    path('media/<int:media_id>', views.media_get, name='rooms_media_get')
]
