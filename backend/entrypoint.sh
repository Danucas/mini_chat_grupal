#!/usr/bin/env bash

python3 mini_chat/manage.py makemigrations api
python3 mini_chat/manage.py migrate
python3 mini_chat/manage.py migrate sessions
python3 mini_chat/manage.py initadmin
python3 mini_chat/manage.py collectstatic --noinput
python3 mini_chat/manage.py generateschema --file openapi-schema.yml
python3 mini_chat/manage.py runserver 0.0.0.0:8000