#!/bin/bash

set -e

# Annoying way to get path because OSX does not have `realpath`
SCRIPT_DIR=$( cd "$(dirname "$0")" ; pwd -P )
ROOT_DIR=$(dirname "$SCRIPT_DIR")
echo "Project root dir: $ROOT_DIR"

ALL_SYSTEMS=(postgres mysql clickhouse monetdb)
SYSTEMS=$@
if [ $# -eq 0 ]
then
    echo "Using all systems"
    SYSTEMS=("${ALL_SYSTEMS[@]}")
fi
echo "Running benchmarks for systems: ("${SYSTEMS[@]}")"


export SURPRISE_COMMON=1
export ROOT_DIR
export SYSTEMS
