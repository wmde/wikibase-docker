#!/usr/bin/env bash
#Oneline for full directory name see: https://stackoverflow.com/questions/59895/getting-the-source-directory-of-a-bash-script-from-within
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
docker build "$DIR/../" -t wikibase/wikibase:1.29 -t wikibase/wikibase:legacy

if [ "$BRANCH" == "master" ]
    then docker push wikibase/wikibase:1.29 && docker push wikibase/wikibase:legacy
fi
