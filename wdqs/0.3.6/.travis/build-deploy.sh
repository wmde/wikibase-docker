#!/usr/bin/env bash
#Oneline for full directory name see: https://stackoverflow.com/questions/59895/getting-the-source-directory-of-a-bash-script-from-within
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
set -e
docker build "$DIR/../" -t wikibase/wdqs:0.3.6

if [ "$SHOULD_DOCKER_PUSH" = true ]; then
    docker push wikibase/wdqs:0.3.6
fi
