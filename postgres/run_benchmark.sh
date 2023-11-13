#!/bin/bash

set -e

# Create TPC-H tables, load data, and do a trial run to see that TPC-H works.
echo "Setting up TPC-H..."
java -jar /benchbase/benchbase.jar -b tpch -c config/init_tpch_config.xml -d /results --create=true --load=true --execute=true
echo "\n\n\n\n"

# Run surprise benchmark with unknown queries.
echo "Running SURPRISE BENCHMARK..."
java -jar /benchbase/benchbase.jar -b templated -c config/surprise_tpch_config.xml -d /results --create=false --load=false --execute=true
