# pull from node
FROM node:14.11.0-stretch

# set working directory
WORKDIR /usr/src/app

# Copy the resources to container
COPY frontend /usr/src/app/frontend
COPY frontend/entrypoint.sh /usr/src/app/entrypoint.sh

# run the entrypoint
ENTRYPOINT [ "/usr/src/app/entrypoint.sh" ]
