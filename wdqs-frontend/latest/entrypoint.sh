#!/bin/sh
# This file is provided by the wikibase/wdqs-frontend docker image.

# Test if required environment variables have been set
if [ -z "$WIKIBASE_HOST" ]; then
echo "WIKIBASE_HOST is required but isn't set. You should pass it to docker. See: https://docs.docker.com/engine/reference/commandline/run/#set-environment-variables--e---env---env-file";
exit 1;
fi

if [ -z "$WDQS_HOST" ]; then
echo "WDQS_HOST is required but isn't set. You should pass it to docker. See: https://docs.docker.com/engine/reference/commandline/run/#set-environment-variables--e---env---env-file";
exit 1;
fi

set -eu

export DOLLAR='$'
envsubst < /templates/custom-config.json > /usr/share/nginx/html/custom-config.json
envsubst < /templates/default.conf > /etc/nginx/conf.d/default.conf

exec "$@"
