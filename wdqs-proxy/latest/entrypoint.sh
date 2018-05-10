#!/bin/sh
# This file is provided by the wikibase/wdqs-proxy docker image.

# Test if required environment variables have been set
if [ -z "$PROXY_PASS_HOST" ]; then
echo "PROXY_PASS_HOST is required but isn't set. You can pass it using either plain docker or docker-compose";
exit 1;
fi

set -eu

envsubst < /etc/nginx/conf.d/wdqs.template > /etc/nginx/conf.d/default.conf

nginx -g 'daemon off;'
