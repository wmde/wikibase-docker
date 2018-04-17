#!/bin/sh
# This file is provided by the wikibase/wdqs-proxy docker image.

set -eu

envsubst < /etc/nginx/conf.d/wdqs.template > /etc/nginx/conf.d/default.conf

nginx -g 'daemon off;'
