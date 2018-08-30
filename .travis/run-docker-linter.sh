#!/bin/bash
set -eu

echo "now linting: $1"
docker run --rm -i hadolint/hadolint:v1.3.0 hadolint --ignore DL3006 - < "$1"
echo "-------"
