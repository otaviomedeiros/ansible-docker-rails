FROM postgres:9.5.3

MAINTAINER Dockerized Rails App

COPY setup-database.sh docker-entrypoint-initdb.d/setup-database.sh
RUN chmod +x docker-entrypoint-initdb.d/setup-database.sh
