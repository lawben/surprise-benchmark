#!/bin/bash

set -e

psql -U postgres -p 5432 -h localhost -1 -e -f /benchbase/scripts/setup_database.sql
