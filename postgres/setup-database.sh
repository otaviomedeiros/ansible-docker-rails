#!/bin/bash
# dockerized rails app

set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
    CREATE USER railsappuser;
    CREATE DATABASE railsappdb_development;
    CREATE DATABASE railsappdb_test;
    GRANT ALL PRIVILEGES ON DATABASE railsappdb_development TO railsappuser;
    GRANT ALL PRIVILEGES ON DATABASE railsappdb_test TO railsappuser;
EOSQL
