#!/bin/bash

docker pull hadolint/hadolint:v1.3.0

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

find ./ -name Dockerfile -print0 | xargs -0 -L1 $DIR/run-docker-linter.sh
