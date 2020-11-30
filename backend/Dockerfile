FROM python:3.8.1-slim-buster

# ENV PATH="/usr/pgsql-12/bin/:${PATH}"

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
		gcc \
		libpq-dev \
		python-dev \
        postgresql-client \
    && rm -rf /var/lib/apt/lists/*
RUN python -m pip install --upgrade pip

WORKDIR /usr/src/app
COPY requirements.txt ./
RUN pip install -r requirements.txt
COPY . .

EXPOSE 8000

# RUN python mini_chat/manage.py collectstatic --noinput
ENTRYPOINT [ "/usr/src/app/entrypoint.sh" ]
