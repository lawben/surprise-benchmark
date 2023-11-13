#!/bin/bash

set -e

# Call postgres docker entrypoint to setup everything.
# This is a bit of a hack, because the docker-entrypoint script never terminates,
# but we do not want to duplicate the logic for starting up everything. As this
# is run locally, we just sleep for a few seconds. Benchbase will crash if
# PostgreSQL is not running yet.
su postgres -c 'POSTGRES_PASSWORD=password docker-entrypoint.sh -d postgres &' &> /postgres.log
sleep 5
