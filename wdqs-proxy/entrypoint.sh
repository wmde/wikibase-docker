#!/bin/sh

envsubst < /etc/nginx/conf.d/wdqs.template > /etc/nginx/conf.d/default.conf

nginx -g 'daemon off;'
