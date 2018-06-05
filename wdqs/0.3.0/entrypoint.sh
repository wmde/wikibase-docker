#!/usr/bin/env bash
# This file is provided by the wikibase/wdqs docker image.

# Test if required environment variables have been set
for requiredVariable in WIKIBASE_HOST WDQS_HOST WDQS_PORT; do
    if [[ ! -v $requiredVariable || -z ${!requiredVariable} ]]; then
        printf >&2 '%s is required, but either unset or empty. You should pass it to docker. See: %s\n' \
            "$requiredVariable" \
            'https://docs.docker.com/engine/reference/commandline/run/#set-environment-variables--e---env---env-file'
        exit 1
    fi
done

set -eu

export BLAZEGRAPH_OPTS="-DwikibaseHost=${WIKIBASE_HOST}"
export UPDATER_OPTS="-DwikibaseHost=${WIKIBASE_HOST} -DwikibaseMaxDaysBack=${WIKIBASE_MAX_DAYS_BACK}"

envsubst < /templates/mwservices.json > /wdqs/mwservices.json

exec "$@"
