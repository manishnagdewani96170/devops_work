FROM python:3.6.1-alpine

# install system package
RUN apk add --update --no-cache \
    python \
    python-dev \
    build-base \
    linux-headers \
    pcre-dev \
    py-pip \
    curl \
    openssl \
    nginx \
    rsyslog \
    build-base \
    postgresql \
    postgresql-dev \
    libpq

RUN pip install uwsgi

COPY . /app

RUN pip install -r /app/requirements.txt

#WORKDIR /app

#EXPOSE 8000

CMD ["uwsgi", "--ini", "/uwsgi.ini"]


