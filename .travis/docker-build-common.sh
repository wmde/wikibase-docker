#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
set -e
docker build "$DIR/../wikibase/common" -t wikibase/wikibase-common
