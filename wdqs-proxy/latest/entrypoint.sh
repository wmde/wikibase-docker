#!/bin/sh
# This file is provided by the wikibase/wdqs-proxy docker image.

# Test if required environment variables have been set
REQUIRED_VARIABLES=(PROXY_PASS_HOST)
for i in ${REQUIRED_VARIABLES[@]}; do
    eval THISSHOULDBESET=\$$i
    if [ -z "$THISSHOULDBESET" ]; then
    echo "$i is required but isn't set. You can pass it using either plain docker or docker-compose";
    exit 1;
    fi
done

set -eu

envsubst < /etc/nginx/conf.d/wdqs.template > /etc/nginx/conf.d/default.conf

nginx -g 'daemon off;'
