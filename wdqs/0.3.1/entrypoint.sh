#!/bin/bash
# This file is provided by the wikibase/wdqs docker image.

# Test if required environment variables have been set
REQUIRED_VARIABLES=(WIKIBASE_HOST WDQS_HOST WDQS_PORT)
for i in ${REQUIRED_VARIABLES[@]}; do
    eval THISSHOULDBESET=\$$i
    if [ -z "$THISSHOULDBESET" ]; then
    echo "$i is required but isn't set. You should pass it to docker. See: https://docs.docker.com/engine/reference/commandline/run/#set-environment-variables--e---env---env-file";
    exit 1;
    fi
done
export WIKIBASE_SCHEME="${WIKIBASE_SCHEME:-http}"
export WIKIBASE_CONCEPT_URI="${WIKIBASE_CONCEPT_URI:-${WIKIBASE_SCHEME}://${WIKIBASE_HOST}}"
set -eu

export BLAZEGRAPH_OPTS="-DwikibaseHost=${WIKIBASE_HOST} -DwikibaseScheme=${WIKIBASE_SCHEME} -DwikibaseConceptUri=${WIKIBASE_CONCEPT_URI}"
export UPDATER_OPTS="-DwikibaseHost=${WIKIBASE_HOST} -DwikibaseScheme=${WIKIBASE_SCHEME} -DwikibaseMaxDaysBack=${WIKIBASE_MAX_DAYS_BACK}"

envsubst < /templates/mwservices.json > /wdqs/mwservices.json

exec "$@"