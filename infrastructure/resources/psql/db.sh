#
# Copyright (c) 2023 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
#
# This program and the accompanying materials are made available under the
# terms of the Apache License, Version 2.0 which is available at
# https://www.apache.org/licenses/LICENSE-2.0
#
# SPDX-License-Identifier: Apache-2.0
#
# Contributors:
#       Bayerische Motoren Werke Aktiengesellschaft (BMW AG) - initial API and implementation
#
#

set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE DATABASE rawdata;
    CREATE DATABASE rul;
    CREATE USER rawdata_user WITH ENCRYPTED PASSWORD '$SACRED';
    GRANT ALL PRIVILEGES ON DATABASE rawdata TO rawdata_user;
    CREATE DATABASE $POSTGRES_DB_NAME_MIW;
    CREATE USER $POSTGRES_USERNAME_MIW WITH ENCRYPTED PASSWORD '$SACRED';
    GRANT ALL PRIVILEGES ON DATABASE $POSTGRES_DB_NAME_MIW TO $POSTGRES_USERNAME_MIW;
    \c $POSTGRES_DB_NAME_MIW
    GRANT ALL ON SCHEMA public TO $POSTGRES_USERNAME_MIW;
EOSQL

psql --username "$POSTGRES_USER" --dbname "rawdata" </tmp/data/20230126_rawdata_db_dump.sql

