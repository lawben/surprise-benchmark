#!/bin/bash

set -e

# Annoying way to get path because OSX does not have `realpath`
SCRIPT_DIR=$( cd "$(dirname "$0")" ; pwd -P )
source $SCRIPT_DIR/common.sh $@

if [[ -z "${NO_CACHE}" ]]; then
    echo "Building using cache"
    NO_CACHE=""
else
    echo "Building from scratch"
    NO_CACHE="--no-cache"
fi

echo "Building all docker images"
for system in $SYSTEMS
do
    echo "Building image for system: $system"
    SYSTEM_DIR=$ROOT_DIR/$system
    [ ! -d "$SYSTEM_DIR" ] && >&2 echo "No directory exists for system: '$SYSTEM_DIR'!" && exit 1
    cd "$SYSTEM_DIR"
    docker build $NO_CACHE -t surprise-benchmark-${system} .
done
