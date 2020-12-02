#!/usr/bin/env bash

docker-compose -f docker-compose.prod.yml up --build -d db
sleep 5
while ! nc -z -v -w5 0.0.0.0 5432; do		
    sleep 3
done
docker cp ./dump.sql minichatgrupal_db_1:/home/dump.back.sql
docker exec -it minichatgrupal_db_1 bash -c "dropdb -U mini_chat_dev mini_chat_dev_db"
docker exec -it minichatgrupal_db_1 bash -c "createdb -U mini_chat_dev mini_chat_dev_db"
docker exec -it minichatgrupal_db_1 bash -c "pg_restore -U mini_chat_dev -d mini_chat_dev_db /home/dump.back.sql"
docker-compose down
docker-compose -f docker-compose.prod.yml down
docker-compose -f docker-compose.prod.yml up --build -d
