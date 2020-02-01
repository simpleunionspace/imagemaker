#!/bin/bash

set -euo pipefail

BASEPATH=$(dirname "$0")

docker build \
       --pull \
       --no-cache \
       --tag lifepainspace/base-linux:centos-$(date +%Y%m%d.%H%M) \
       --tag lifepainspace/base-linux:centos-latest \
       --tag lifepainspace/base-linux:latest \
       $BASEPATH/../../src/base-linux/
