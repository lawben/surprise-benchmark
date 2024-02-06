#!/bin/bash

set -e

# Create TPC-H tables and load data.
#echo "Setting up TPC-H..."
#java -jar /benchbase/benchbase.jar -b tpch -c config/init_tpch_config.xml -d /results --create=true --load=true --execute=false

#echo -e "\n\n\n\n"

echo -e "Setup database..."
bash /benchbase/scripts/setup_database.sh

echo -e "\n\n\n\n"

# Run to see that TPC-H works.
echo "Running standard TPC-H..."
if [ -f "config/run_tpch_config.xml" ]; then
    java -jar /benchbase/benchbase.jar -b templated -c config/run_tpch_config.xml -d /results --create=false --load=false --execute=true
else
    java -jar /benchbase/benchbase.jar -b tpch -c config/init_tpch_config.xml -d /results --create=false --load=false --execute=true
fi

echo -e "\n\n\n\n"

# Run surprise benchmark with unknown queries.
# echo "Running SURPRISE BENCHMARK..."
# java -jar /benchbase/benchbase.jar -b templated -c config/surprise_tpch_config.xml -d /results --create=false --load=false --execute=true
