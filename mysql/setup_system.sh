#!/bin/bash

set -e

# Call MySQL docker entrypoint to setup everything.
# This is a bit of a hack, because the docker-entrypoint script never terminates,
# but we do not want to duplicate the logic for starting up everything. As this
# is run locally, we just sleep for a few seconds. Benchbase will crash if
# MySQL is not running yet.
su mysql -c 'MYSQL_ROOT_PASSWORD=password MYSQL_DATABASE=benchbase MYSQL_USER=mysql MYSQL_PASSWORD=password docker-entrypoint.sh mysqld &' #&> /mysql.log
sleep 15
