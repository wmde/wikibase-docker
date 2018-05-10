#!/bin/sh
# This file is provided by the wikibase/wdqs-frontend docker image.

# Test if required environment variables have been set
if [ -z "$WIKIBASE_HOST" ]; then
echo "WIKIBASE_HOST is required but isn't set. You can pass it using either plain docker or docker-compose";
exit 1;
fi

if [ -z "$WDQS_HOST" ]; then
echo "WDQS_HOST is required but isn't set. You can pass it using either plain docker or docker-compose";
exit 1;
fi

set -eu

export DOLLAR='$'
envsubst < /templates/config.js > /usr/share/nginx/html/wikibase/config.js
envsubst < /templates/default.conf > /etc/nginx/conf.d/default.conf

exec "$@"