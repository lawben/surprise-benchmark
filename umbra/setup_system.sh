#!/bin/bash

set -e

mkdir -p /umbra-db

echo "Starting Umbra server for configuration"
/umbra/bin/server /umbra-db/umbra.db --createdb --address=0.0.0.0 & #> /umbra.log
sleep 1

cat <<EOT >> /tmp/umbra_setup.sql
create user umbra superuser;
alter user umbra with password 'password';
create database umbra;
EOT

echo "Configuring Umbra via psql"
psql -h /tmp -U postgres -f /tmp/umbra_setup.sql &
sleep 1

