#!/bin/sh
# This file is provided by the wikibase/wdqs-frontend docker image.

# Test if required environment variables have been set
REQUIRED_VARIABLES=(WIKIBASE_HOST WDQS_HOST)
for i in ${REQUIRED_VARIABLES[@]}; do
    eval THISSHOULDBESET=\$$i
    if [ -z "$THISSHOULDBESET" ]; then
    echo "$i is required but isn't set. You can pass it using either plain docker or docker-compose";
    exit 1;
    fi
done

set -eu

export DOLLAR='$'
envsubst < /templates/config.js > /usr/share/nginx/html/wikibase/config.js
envsubst < /templates/default.conf > /etc/nginx/conf.d/default.conf

exec "$@"