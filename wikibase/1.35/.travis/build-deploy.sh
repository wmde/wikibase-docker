#!/usr/bin/env bash
#Oneline for full directory name see: https://stackoverflow.com/questions/59895/getting-the-source-directory-of-a-bash-script-from-within
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
set -e
docker build "$DIR/../base" -t wikibase/wikibase:1.35 -t wikibase/wikibase:1.35-base -t wikibase/wikibase:latest -t wikibase/wikibase:latest-base -t wikibase/wikibase:lts -t wikibase/wikibase:lts-base
docker build "$DIR/../bundle" -t wikibase/wikibase:1.35-bundle -t wikibase/wikibase:latest-bundle -t wikibase/wikibase:lts-bundle

if [ "$SHOULD_DOCKER_PUSH" = true ]; then
    docker push wikibase/wikibase:lts
    docker push wikibase/wikibase:1.35
    docker push wikibase/wikibase:latest
    docker push wikibase/wikibase:lts-base
    docker push wikibase/wikibase:1.35-base
    docker push wikibase/wikibase:lts-bundle
    docker push wikibase/wikibase:latest-base
    docker push wikibase/wikibase:1.35-bundle
    docker push wikibase/wikibase:latest-bundle
fi
