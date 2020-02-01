#!/bin/bash

set -euo pipefail

BASEPATH=$(dirname "$0")

# base linux
bash $BASEPATH/base-linux/clean.sh

docker container prune -f
docker image prune -a -f
