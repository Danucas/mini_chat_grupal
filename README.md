### mini_chat_grupal
Mini chat to connect with work teams and talk about projects.

[Demo](http://13.59.57.0/) -> Web Client

[API](http://13.59.57.0/api) -> Aplication interface, to manage DB

[Admin](http://13.59.57.0/api/login) -> To manage the Rooms

### Install and run the services

Requirements:
Install docker and docker-compose if you don't have it,
tested on Ubuntu 18.04.

- Docker
- docker-compose

```
# To start the services from scratch RUN

$ sudo docker-compose up --build

# If you want to use a sql dump file dump file
# use the utility at the root of the project 'run_from_dump.sh'

$ ./run_from_dump.sh dumpfile.sql
-----------------------------------------------------------
-- Start creating services from dump file 'dumpfile.sql' --
-----------------------------------------------------------
```

The services should be running at [localhost:3000](http://localhost:300) for the frontend service and [localhost:8000](http://localhost:8000) for the backend service.

### Screenshots




