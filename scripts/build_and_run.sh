#!/bin/bash

set -e

# Annoying way to get path because OSX does not have `realpath`
SCRIPT_DIR=$( cd "$(dirname "$0")" ; pwd -P )
ROOT_DIR=$(dirname "$SCRIPT_DIR")
echo "Project root dir: $ROOT_DIR"

ALL_SYSTEMS=(postgres mysql)
SYSTEMS=$@
if [ $# -eq 0 ]
then
    echo "Using all systems";
    SYSTEMS=$ALL_SYSTEMS;
fi
echo "Running benchmarks for systems: ($SYSTEMS)"

if [[ -z "${NO_CACHE}" ]]; then
    echo "Builindg using cache"
    NO_CACHE=""
else
    echo "Building from scratch"
    NO_CACHE="--no-cache"
fi

echo "Building all docker images first"
for system in $SYSTEMS
do
    echo "Building image for system: $system"
    SYSTEM_DIR=$ROOT_DIR/$system
    [ ! -d "$SYSTEM_DIR" ] && >&2 echo "No directory exists for system: '$SYSTEM_DIR'!" && exit 1
    cd "$SYSTEM_DIR"
    docker build $NO_CACHE -t surprise-benchmark-${system} .
done

cd $ROOT_DIR

echo "Running benchmarks on all systems"
for system in $SYSTEMS
do
    echo "Benchmarking system: $system"
    docker run \
	    --rm \
            -v $ROOT_DIR/results/$system:/results \
            -v $ROOT_DIR/data/surprise_tpch_queries.xml:/benchbase/config/surprise_tpch_queries.xml:ro \
            -v $ROOT_DIR/scripts/run_benchmark.sh:/scripts/run_benchmark.sh:ro \
            --ulimit memlock=1073741824 \
            --cap-add=sys_nice \
            surprise-benchmark-$system
done
