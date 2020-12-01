#!/usr/bin/python3
"""
API Endpoints for Mini_chat
"""
from django.contrib.auth.models import Group
from django.shortcuts import render
from django.utils import timezone
from django.http import FileResponse
from .models import Room, Message, User
from rest_framework import viewsets, status
from rest_framework import permissions
from datetime import datetime
from rest_framework.decorators import api_view
from drf_yasg import openapi
from drf_yasg.utils import swagger_auto_schema
from drf_yasg.inspectors import SwaggerAutoSchema
from rest_framework.authtoken.models import Token
from .serializers import UserSerializer, GroupSerializer, MessageSerializer, RoomSerializer
from rest_framework.response import Response
import logging
import pytz
import base64
import json
import os
import uuid

# Define a logger instance for debugging
logger = logging.getLogger(__name__)

class HtmlSchema(SwaggerAutoSchema):
    def get_produces(self):
        return ['text/html']

class ImageSchema(SwaggerAutoSchema):
    def get_produces(self):
        return ['image/png']

@swagger_auto_schema(
    auto_schema=HtmlSchema,
    method='get',
    responses={
        200: openapi.Response(
            description='Login view to access the Dashboard',
            produces=['text/html'],
            format='html'
        )
    }
)
@api_view(['GET'])
def login(request):
    """
    Return the Login HTML view
    """
    return render(request, 'login.html', {'api_url': os.environ['API_URL']})

@swagger_auto_schema(
    auto_schema=HtmlSchema,
    method='get',
    responses={
        200: openapi.Response(
            description='Register HTML view',
            produces=['text/html'],
            format='html'
        )
    }
)
@swagger_auto_schema(
    method='post',
    request_body=openapi.Schema(
        type=openapi.TYPE_OBJECT,
        properties={
            'username': openapi.Schema(
                type=openapi.TYPE_STRING,
                description='User email'
            ),
            'password': openapi.Schema(
                type=openapi.TYPE_STRING,
                description='user password'
            )
        }
    ),
    responses={
        200: openapi.Response(
            description='Register a new user to db',
            schema=openapi.Schema(
                'user_info',
                type=openapi.TYPE_OBJECT,
                properties={
                    'token': openapi.Schema(
                        type=openapi.TYPE_STRING,
                        description='registered user token'
                    ),
                    'username': openapi.Schema(
                        type=openapi.TYPE_STRING,
                        description='registered user name'
                    ),
                    'id': openapi.Schema(
                        type=openapi.TYPE_STRING,
                        description='registered user id'
                    )
                }
            )
        )
    }
)
@api_view(['GET', 'POST'])
def register(request):
    """
    GET: return the register HTML view
    POST: Register a new user storing 'username' and 'password' values from request body
    """
    if request.method == 'GET':
        return render(request, 'register.html', {'api_url': os.environ['API_URL']})
    elif request.method == 'POST':
        user = User()
        tim = datetime.now()
        final_tim = timezone.make_aware(tim, timezone=pytz.timezone('UTC'))
        user.last_login = final_tim
        user.username = request.data['username'].split('@')[0]
        user.email = request.data['username']
        user.password = request.data['password']
        user.save()
        token, created = Token.objects.get_or_create(user=user)
        token.save()
        return Response(data={
            'token': token.key,
            'id': user.id,
            'username': user.username
        })
@swagger_auto_schema(
    method='post',
    request_body=openapi.Schema(
        type=openapi.TYPE_OBJECT,
        properties={
            'username': openapi.Schema(
                type=openapi.TYPE_STRING,
                description='User email'
            ),
            'password': openapi.Schema(
                type=openapi.TYPE_STRING,
                description='user password'
            )
        }
    ),
    responses={
        200: openapi.Response(
            'Auth user data',
            openapi.Schema(
                type=openapi.TYPE_OBJECT,
                properties={
                    'username': openapi.Schema(
                        type=openapi.TYPE_STRING,
                        description='registered username'
                    ),
                    'id': openapi.Schema(
                        type=openapi.TYPE_STRING,
                        description='registered user id'
                    ),
                    'token': openapi.Schema(
                        type=openapi.TYPE_STRING,
                        description='generated token'
                    ),
                }
            )
        )
    },
)
@api_view(['POST'])
def get_token(request):
    """
    Generates a unique token and return the user info 'id', and 'username
    """
    try:
        user = User.objects.get(email=request.data['username'])
    except User.DoesNotExist as e:
        return Response(data={
            'error': 'User is not registered'
        }, status=status.HTTP_404_NOT_FOUND)
    if not (user.check_password(request.data['password'])):
        if user.password != request.data['password']:
            return Response(data={
                    'error': 'Unauthorized'
            }, status=status.HTTP_401_UNAUTHORIZED)
    try:
        token, created = Token.objects.get_or_create(user=user)
    except Exception as e:
            return Response(data={
                'error': 'Error retrieving token'
            }, status=status.HTTP_401_UNAUTHORIZED)
    tim = datetime.now()
    final_tim = timezone.make_aware(tim, timezone=pytz.timezone('UTC'))
    user.last_login = final_tim
    user.save()
    token.save()
    return Response(data={
        'token': token.key,
        'id': token.user_id,
        'username': user.username
    })

@swagger_auto_schema(
    auto_schema=HtmlSchema,
    method='get',
    manual_parameters=[
        openapi.Parameter(
            'Authorization', in_=openapi.IN_HEADER, description='Token ', type=openapi.TYPE_STRING
        )
    ],
    responses={
        200: openapi.Response(
            description='Dashboard html to admin rooms',
            produces=['text/html'],
            format='html'
        )
    }
)
@api_view(['GET'])
def dashboard(request):
    """
    Return the dashboard view, to control the rooms and messages
    """
    try:
        token = request.headers['Authorization'].split(' ')[1]
        tok = Token.objects.get(key=token)
    except Exception as e:
        return Response(data={
            'error': 'No authorized'
        }, status=status.HTTP_401_UNAUTHORIZED)
        pass
    rooms = Room.objects.all()
    rooms_obj = []
    for room in rooms:
        rooms_obj.append({
            'id': room.id,
            'name': room.name
        })
        {'api_url': os.environ['API_URL']}
    return render(
        request,
        'dashboard.html',
        {
            'rooms': rooms_obj,
            'user': 'admin',
            'api_url': os.environ['API_URL']
        })


@swagger_auto_schema(
    method='get',
    manual_parameters=[
        openapi.Parameter(
            'Authorization', in_=openapi.IN_HEADER, description='Token ', type=openapi.TYPE_STRING
        )
    ],
    responses={
        200: openapi.Response(
            description='Rooms list',
            schema=openapi.Schema(
                type=openapi.TYPE_OBJECT,
                properties={
                    'rooms': openapi.Schema(
                        type=openapi.TYPE_ARRAY,
                        items=openapi.Items(
                            type=openapi.TYPE_OBJECT,
                            properties={
                                'name': openapi.Schema(type=openapi.TYPE_STRING),
                                'id': openapi.Schema(type=openapi.TYPE_INTEGER),
                            }
                        )
                    )
                }
            )
        )
    }
)
@swagger_auto_schema(
    method='post',
    manual_parameters=[
        openapi.Parameter(
            'Authorization', in_=openapi.IN_HEADER, description='Token ', type=openapi.TYPE_STRING
        )
    ],
    responses={
        200: openapi.Response(
            description='Rooms create one',
            schema=openapi.Schema(
                type=openapi.TYPE_OBJECT,
                properties={
                    'name': openapi.Schema(type=openapi.TYPE_STRING),
                    'id': openapi.Schema(type=openapi.TYPE_INTEGER),
                }
            )
        )
    }
)
@swagger_auto_schema(
    method='put',
    manual_parameters=[
        openapi.Parameter(
            'Authorization', in_=openapi.IN_HEADER, description='Token ', type=openapi.TYPE_STRING
        )
    ],
    request_body=openapi.Schema(
        type=openapi.TYPE_OBJECT,
        properties={
            'name': openapi.Schema(type=openapi.TYPE_STRING)
        }
    ),
    responses={
        200: openapi.Response(
            description='Update room name',
            schema=openapi.Schema(
                type=openapi.TYPE_OBJECT,
                properties={
                    'success': openapi.Schema(type=openapi.TYPE_BOOLEAN)
                }
            )
        )
    }
)
@api_view(['GET', 'POST', 'PUT'])
def rooms(request):
    """
    CRUD for rooms
    """
    try:
        token = request.headers['Authorization'].split(' ')[1]
        tok = Token.objects.get(key=token)
    except Exception as e:
        return Response(data={
                'error': 'Error retrieving token'
        }, status=status.HTTP_401_UNAUTHORIZED)
    if request.method == 'POST':
        room = Room()
        # room.admin = User.objects.get(id=tok.user_id)
        room.name = 'new room'
        room.save()
        return Response(data={
            'id': room.id,
            'name': room.name
        })
    elif request.method == 'GET':
        rooms = Room.objects.all().values()
        roms = []
        for room in rooms:
            roms.append({
                'id': room['id'],
                'name': room['name']
            })
        return Response(data={
            'rooms': roms
        })
    elif request.method == 'PUT':
        room = Room.objects.get(id=request.data['id'])
        room.name = request.data['name']
        room.save()
        return Response(data={
            'success': True
        })

@swagger_auto_schema(
    method='delete',
    manual_parameters=[
        openapi.Parameter(
            'Authorization', in_=openapi.IN_HEADER, description='Token ', type=openapi.TYPE_STRING
        )
    ],
    responses={
        200: openapi.Response(
            'Room deleted status',
            openapi.Schema(
                type=openapi.TYPE_OBJECT,
                properties={
                    'success': openapi.Schema(
                        type=openapi.TYPE_BOOLEAN,
                        description='delete status'
                    )
                }
            )
        )
    }
)
@api_view(['DELETE'])
def rooms_delete(request, *args, **kwargs):
    """
    Deletes a room
    """
    # logger.error('entra aqui')
    try:
        token = request.headers['Authorization'].split(' ')[1]
        tok = Token.objects.get(key=token)
    except Exception as e:
        return Response(data={
                'error': 'Error retrieving token'
        }, status=status.HTTP_401_UNAUTHORIZED)
    # logger.error('entra aqui')
    room = Room.objects.get(id=kwargs['roomId'])
    # logger.error(str(room))
    room.delete()
    return Response(data={
        'success': True
    })

@swagger_auto_schema(
    method='get',
    manual_parameters=[
        openapi.Parameter(
            'Authorization', in_=openapi.IN_HEADER, description='Token ', type=openapi.TYPE_STRING
        )
    ],
    responses={
        200: openapi.Response(
            description='registered Users list',
            schema=openapi.Schema(
                type=openapi.TYPE_OBJECT,
                properties={
                    'users': openapi.Schema(
                        type=openapi.TYPE_ARRAY,
                        items=openapi.Items(
                            type=openapi.TYPE_OBJECT,
                            properties={
                                'username': openapi.Schema(type=openapi.TYPE_STRING),
                                'id': openapi.Schema(type=openapi.TYPE_INTEGER),
                                'last_login': openapi.Schema(type=openapi.TYPE_STRING),
                            }
                        )
                    )
                }
            )
        )
    }
)
@api_view(['GET'])
def rooms_users(request, *args, **kwargs):
    """
    Get all Users registered to the chat
    """
    try:
        token = request.headers['Authorization'].split(' ')[1]
        tok = Token.objects.get(key=token)
    except Exception as e:
        return Response(data={
                'error': 'Error retrieving token'
        }, status=status.HTTP_401_UNAUTHORIZED)
    user_instance = User.objects.get(id=tok.user_id)
    users = User.objects.all().order_by('-last_login')
    uss = []
    for user in users.values():
        if user['last_login']:
            uss.append({
                'username': user['username'],
                'last_login': user['last_login'],
                'id': user['id']
            })
    return Response(data={
        'users': uss
    })


@swagger_auto_schema(
    method='get',
    manual_parameters=[
        openapi.Parameter(
            'Authorization', in_=openapi.IN_HEADER, description='Token ', type=openapi.TYPE_STRING
        )
    ],
    responses={
        200: openapi.Response(
            description='sent messages list',
            schema=openapi.Schema(
                type=openapi.TYPE_OBJECT,
                properties={
                    'messages': openapi.Schema(
                        type=openapi.TYPE_ARRAY,
                        items=openapi.Items(
                            type=openapi.TYPE_OBJECT,
                            properties={
                                'content': openapi.Schema(type=openapi.TYPE_STRING),
                                'created_at': openapi.Schema(type=openapi.TYPE_STRING),
                                'user': openapi.Schema(type=openapi.TYPE_STRING),
                                'user_id': openapi.Schema(type=openapi.TYPE_INTEGER),
                                'id': openapi.Schema(type=openapi.TYPE_INTEGER),
                                'media': openapi.Schema(type=openapi.TYPE_BOOLEAN),
                            }
                        )
                    )
                }
            )
        )
    }
)
@api_view(['GET'])
def messages_get(request, *args, **kwargs):
    """
    Return messages filtered by room
    """
    try:
        token = request.headers['Authorization'].split(' ')[1]
        tok = Token.objects.get(key=token)
    except Exception as e:
        return Response(data={
                'error': 'Error retrieving token'
        }, status=status.HTTP_401_UNAUTHORIZED)
    if request.method == 'GET':
        try:
            room = Room.objects.get(id=kwargs['roomId'])
            messages = Message.objects.all().filter(room=room.id).order_by('created_at')
            mess = []
            for m in messages.values():
                created = m['created_at']
                mess.append({
                    'created_at': created.astimezone().isoformat(),
                    'content': m['content'],
                    'user': User.objects.get(id=m['user_id']).username,
                    'user_id': m['user_id'],
                    'id': m['id'],
                    'media': m['media']
                })
            return Response(
                data={
                    'messages': mess,
                    'id': tok.user_id
                },
                status=status.HTTP_200_OK
            )
        except Exception as e:
            print(e)
            return Response(data={
                'error': 'not found'
            }, status=status.HTTP_404_NOT_FOUND)


@swagger_auto_schema(
    method='post',
    manual_parameters=[
        openapi.Parameter(
            'Authorization', in_=openapi.IN_HEADER, description='Token ', type=openapi.TYPE_STRING
        )
    ],
    request_body=openapi.Schema(
        type=openapi.TYPE_OBJECT,
        properties={
            'content': openapi.Schema(
                type=openapi.TYPE_STRING,
                description='client message content'
            )
        }
    ),
    responses={
        200: openapi.Response(
            'Message sent status',
            openapi.Schema(
                type=openapi.TYPE_OBJECT,
                properties={
                    'success': openapi.Schema(
                        type=openapi.TYPE_BOOLEAN,
                        description='sent state'
                    )
                }
            )
        )
    }
)
@api_view(['POST'])
def messages_post(request, *args, **kwargs):
    """
    Return messages or store them by Room id
    POST: receives 'content' string
    """
    try:
        token = request.headers['Authorization'].split(' ')[1]
        tok = Token.objects.get(key=token)
    except Exception as e:
        return Response(data={
                'error': 'Error retrieving token'
        }, status=status.HTTP_401_UNAUTHORIZED)
    room = Room.objects.get(id=kwargs['roomId'])
    user_instance = User.objects.get(id=tok.user_id)
    message = Message()
    message.content = request.data['content']
    message.user = user_instance
    message.room = room
    tim = datetime.now()
    final_tim = timezone.make_aware(tim, timezone=pytz.timezone('UTC'))
    message.created_at = final_tim
    message.save()
    return Response(data={
        'id': message.id
    })

@swagger_auto_schema(
    method='delete',
    manual_parameters=[
        openapi.Parameter(
            'Authorization', in_=openapi.IN_HEADER, description='Token ', type=openapi.TYPE_STRING
        )
    ],
    responses={
        200: openapi.Response(
            'Message deleted status',
            openapi.Schema(
                type=openapi.TYPE_OBJECT,
                properties={
                    'success': openapi.Schema(
                        type=openapi.TYPE_BOOLEAN,
                        description='delete status'
                    )
                }
            )
        )
    }
)
@api_view(['DELETE'])
def messages_del(request, *args, **kwargs):
    """
    Deletes a message, and remove if attached any media file from localdevice
    """
    try:
        token = request.headers['Authorization'].split(' ')[1]
        tok = Token.objects.get(key=token)
    except Exception as e:
        return Response(data={
                'error': 'Error retrieving token'
        }, status=status.HTTP_401_UNAUTHORIZED)
    user_instance = User.objects.get(id=tok.user_id)
    message_id = kwargs['messId']
    message_instance = Message.objects.get(id=message_id)
    if message_instance.user_id == user_instance.id:
        if message_instance.media:
            try:
                os.remove(f'{os.getcwd()}/mini_chat/static/media/{message_instance.media_src}')
            except Exception as e:
                pass
        message_instance.delete()
        return Response(data={
            'success': True
        })
    else:
        return Response(data={
            'success': False
        }, status=status.HTTP_401_UNAUTHORIZED)

@swagger_auto_schema(
    method='post',
    manual_parameters=[
        openapi.Parameter(
            'Authorization', in_=openapi.IN_HEADER, description='Token ', type=openapi.TYPE_STRING
        )
    ],
    request_body=openapi.Schema(
        type=openapi.TYPE_OBJECT,
        properties={
            'data': openapi.Schema(
                type=openapi.TYPE_STRING,
                description='base64 String'
            ),
            'type': openapi.Schema(
                type=openapi.TYPE_STRING,
                description='to manage storage paths, options: profile, message'
            )
        }
    ),
    responses={
        200: openapi.Response(
            'Media upload status',
            openapi.Schema(
                type=openapi.TYPE_OBJECT,
                properties={
                    'success': openapi.Schema(
                        type=openapi.TYPE_BOOLEAN,
                        description='upload state'
                    )
                }
            )
        )
    }
)
@api_view(['POST'])
def media_post(request):
    """
    POST: Receives a b64 string and decode it to bytes into a file to static folder
    """
    try:
        token = request.headers['Authorization'].split(' ')[1]
        tok = Token.objects.get(key=token)
    except Exception as e:
        return Response(data={
                'error': 'Error retrieving token'
        }, status=status.HTTP_401_UNAUTHORIZED)
    user_instance = User.objects.get(id=tok.user_id)
    if request.data['type'] == 'message':
        message = Message()
        message.media = True
        message.content = ''
        message.user = user_instance
        tim = datetime.now()
        final_tim = timezone.make_aware(tim, timezone=pytz.timezone('UTC'))
        message.created_at = final_tim
        room = Room.objects.get(id=request.data['roomId'])
        message.room = room
        file_name = f'{uuid.uuid4()}.png'
        message.media_src = file_name
        message.save()
    else:
        file_name = f'{uuid.uuid4()}_profile.png'
        if user_instance.profile and user_instance.profile != '':
            os.remove(f'{os.getcwd()}/mini_chat/static/media/{user_instance.profile}')
        user_instance.profile = file_name
        user_instance.save()
    path = f'{os.getcwd()}/mini_chat/static/media'
    with open(f'{path}/{file_name}', 'wb') as imgfile:
        b64_bytes = request.data['data'].encode('ascii')
        mess_bytes = base64.b64decode(b64_bytes)
        imgfile.write(mess_bytes)
        # logger.error(f'image saved in {path}/{file_name}')
    return Response(data={
        'success': True
    })


@swagger_auto_schema(
    auto_schema=ImageSchema,
    method='get',
    manual_parameters=[
        openapi.Parameter(
            'Authorization', in_=openapi.IN_HEADER, description='Token ', type=openapi.TYPE_STRING
        ),
        openapi.Parameter(
            'type', in_=openapi.IN_QUERY, description='type of media to get, profile or message', type=openapi.TYPE_STRING
        )
    ],
    responses={
        200: openapi.Response(
            'Media upload status'
        )
    }
)
@api_view(['GET'])
def media_get(request, *args, **kwargs):
    """
    Send the image
    """
    try:
        token = request.headers['Authorization'].split(' ')[1]
        tok = Token.objects.get(key=token)
    except Exception as e:
        return Response(data={
                'error': 'Error retrieving token'
        }, status=status.HTTP_401_UNAUTHORIZED)
    kind = request.query_params.get('type')
    if kind == 'message':
        message = Message.objects.get(id=kwargs['media_id'])
        filename = message.media_src
    elif kind == 'profile':
        if 'media_id' in kwargs and kwargs['media_id'] != 0:
            user = User.objects.get(id=kwargs['media_id'])
        else:
            user = User.objects.get(id=tok.user_id)
        filename = user.profile
    try:
        img = open(f'{os.getcwd()}/mini_chat/static/media/{filename}', 'rb')
    except Exception as e:
        logger.error(f'file not found: {os.getcwd()}/mini_chat/static/media/{filename}')
        logger.error(str(e))
        return Response(data={
            'success': False
        }, status=status.HTTP_404_NOT_FOUND)
    return FileResponse(img)
