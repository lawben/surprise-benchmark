#!/bin/bash

set -e

# Annoying way to get path because OSX does not have `realpath`
SCRIPT_DIR=$( cd "$(dirname "$0")" ; pwd -P )

$SCRIPT_DIR/build.sh $@
$SCRIPT_DIR/run.sh $@

