#!/bin/bash

set -e

export DOTMONETDBFILE=/benchbase/scripts/.monetdb

mclient -p 50000 -h localhost -d monetdb -e /benchbase/scripts/setup_database.sql
