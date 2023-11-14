#!/bin/bash

set -e

# Call postgres docker entrypoint to setup everything.
# This is a bit of a hack, because the docker-entrypoint script never terminates,
# but we do not want to duplicate the logic for starting up everything. As this
# is run locally, we just sleep for a few seconds. Benchbase will crash if
# PostgreSQL is not running yet.
MDB_DB_ADMIN_PASS=password entrypoint.sh &
sleep 3
