#!/usr/bin/env bash
#Oneline for full directory name see: https://stackoverflow.com/questions/59895/getting-the-source-directory-of-a-bash-script-from-within
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
set -e
docker build "$DIR/../" -t wikibase/elasticsearch:5.6.14-extra -t wikibase/elasticsearch:latest

if [ "$SHOULD_DOCKER_PUSH" = true ]; then
    docker push wikibase/elasticsearch:5.6.14-extra
fi
