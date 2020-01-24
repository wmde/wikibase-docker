#!/usr/bin/env bash
#Oneline for full directory name see: https://stackoverflow.com/questions/59895/getting-the-source-directory-of-a-bash-script-from-within
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
set -e
docker build "$DIR/../base" -t wikibase/wikibase:1.33 -t wikibase/wikibase:1.33-base -t wikibase/wikibase:legacy -t wikibase/wikibase:legacy-base
docker build "$DIR/../bundle" -t wikibase/wikibase:1.33-bundle -t wikibase/wikibase:legacy-bundle

if [ "$SHOULD_DOCKER_PUSH" = true ]; then
    docker push wikibase/wikibase:1.33
    docker push wikibase/wikibase:legacy
    docker push wikibase/wikibase:1.33-base
    docker push wikibase/wikibase:legacy-base
    docker push wikibase/wikibase:1.33-bundle
    docker push wikibase/wikibase:legacy-bundle
fi
