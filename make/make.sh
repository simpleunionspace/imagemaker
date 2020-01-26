#!/bin/bash

set -euo pipefail

BASEPATH=$(dirname "$0")

# base linux
bash $BASEPATH/base-linux/make.sh
