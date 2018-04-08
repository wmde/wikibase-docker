#!/bin/sh
# This file is provided by the wikibase/wdqs-frontend docker image.

set -eu

export DOLLAR='$'
envsubst < /templates/config.js > /usr/share/nginx/html/wikibase/config.js
envsubst < /templates/default.conf > /etc/nginx/conf.d/default.conf

exec "$@"