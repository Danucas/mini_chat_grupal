#!/usr/bin/env bash

docker-compose up --build -d db
sleep 5
while ! nc -z -v -w5 0.0.0.0 5432; do
    sleep 3
done
docker cp ./dump.sql mini_chat_grupal_db_1:/home/dump.back.sql
docker exec -it mini_chat_grupal_db_1 bash -c "dropdb -U mini_chat_dev mini_chat_dev_db"
docker exec -it mini_chat_grupal_db_1 bash -c "createdb -U mini_chat_dev mini_chat_dev_db"
docker exec -it mini_chat_grupal_db_1 bash -c "pg_restore -U mini_chat_dev -d mini_chat_dev_db /home/dump.back.sql"
docker-compose down
docker-compose up --build