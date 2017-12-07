#!/bin/sh

set -eu

export DOLLAR='$'
envsubst < /templates/config.js > /usr/share/nginx/html/wikibase/config.js
envsubst < /templates/default.conf > /etc/nginx/conf.d/default.conf

exec "$@"