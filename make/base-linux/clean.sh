#!/bin/bash

set -euo pipefail

BASEPATH=$(dirname "$0")

docker images -q lifepainspace/base-linux | xargs docker rmi -f
