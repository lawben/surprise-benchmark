#!/bin/bash

set -e

# Annoying way to get path because OSX does not have `realpath`
SCRIPT_DIR=$( cd "$(dirname "$0")" ; pwd -P )
ROOT_DIR=$(dirname "$SCRIPT_DIR")
echo "Project root dir: $ROOT_DIR"

ALL_SYSTEMS=(postgres)
SYSTEMS=$@
if [ $# -eq 0 ]
then
    echo "Using all systems";
    SYSTEMS=$ALL_SYSTEMS;
fi
echo "Running benchmarks for systms: $SYSTEMS"

for system in $SYSTEMS
do
    SYSTEM_DIR=$ROOT_DIR/$system
    [ ! -d "$SYSTEM_DIR" ] && >&2 echo "No directory exists for system: '$SYSTEM_DIR'!" && exit 1
    cd "$SYSTEM_DIR"
    docker build -t surprise-benchmark-${system} .
    docker run --rm \
            -v $ROOT_DIR/results/$system:/results \
            -v $ROOT_DIR/data/surprise_tpch_queries.xml:/benchbase/config/surprise_tpch_queries.xml:ro \
            -v $ROOT_DIR/scripts/run_benchmark.sh:/scripts/run_benchmark.sh:ro \
            surprise-benchmark-$system
done
