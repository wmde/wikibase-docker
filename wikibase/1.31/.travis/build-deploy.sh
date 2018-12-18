#!/usr/bin/env bash
#Oneline for full directory name see: https://stackoverflow.com/questions/59895/getting-the-source-directory-of-a-bash-script-from-within
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
set -e
docker build --pull "$DIR/../base" -t wikibase/wikibase:1.31 -t wikibase/wikibase:1.31-base -t wikibase/wikibase:latest -t wikibase/wikibase:latest-base
docker build --pull "$DIR/../bundle" -t wikibase/wikibase:1.31-bundle -t wikibase/wikibase:latest-bundle

if [ "$SHOULD_DOCKER_PUSH" = true ]; then
    docker push wikibase/wikibase:1.31
    docker push wikibase/wikibase:latest
    docker push wikibase/wikibase:1.31-base
    docker push wikibase/wikibase:latest-base
    docker push wikibase/wikibase:1.31-bundle
    docker push wikibase/wikibase:latest-bundle
fi
