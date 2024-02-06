#!/bin/bash

set -e

# Annoying way to get path because OSX does not have `realpath`
SCRIPT_DIR=$( cd "$(dirname "$0")" ; pwd -P )
source $SCRIPT_DIR/common.sh $@

cd $ROOT_DIR

echo "Running benchmarks on all systems"
for system in $SYSTEMS
do
    echo "Benchmarking system: $system"
    docker run \
	    --rm \
            -v $ROOT_DIR/results/$system:/results \
            -v $ROOT_DIR/data/tpch_data:/benchbase/tpch_data:ro \
            -v $ROOT_DIR/data/surprise_tpch_queries.xml:/benchbase/config/surprise_tpch_queries.xml:ro \
            -v $ROOT_DIR/scripts/run_benchmark.sh:/scripts/run_benchmark.sh:ro \
            --ulimit memlock=1073741824 \
            --cap-add=sys_nice \
            surprise-benchmark-$system
done

