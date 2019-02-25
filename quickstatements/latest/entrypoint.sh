#!/usr/bin/env bash

# Test if required environment variables have been set
REQUIRED_VARIABLES=(QS_PUBLIC_SCHEME_HOST_AND_PORT WB_PUBLIC_SCHEME_HOST_AND_PORT WIKIBASE_SCHEME_AND_HOST WB_PROPERTY_NAMESPACE WB_PROPERTY_PREFIX WB_ITEM_NAMESPACE WB_ITEM_PREFIX)
for i in ${REQUIRED_VARIABLES[@]}; do
    if ! [[ -v "$i" ]]; then
    echo "$i is required but isn't set. You should pass it to docker. See: https://docs.docker.com/engine/reference/commandline/run/#set-environment-variables--e---env---env-file";
    exit 1;
    fi
done

OAUTH_REQUIRED_VARIABLES=(OAUTH_CONSUMER_KEY OAUTH_CONSUMER_SECRET)
for i in ${REQUIRED_VARIABLES[@]}; do
    if ! [[ -v "$i" || -f /quickstatements/data/qs-oauth.json ]]; then
    echo "$i is required but isn't set. You should pass it to docker. See: https://docs.docker.com/engine/reference/commandline/run/#set-environment-variables--e---env---env-file";
    exit 1;
    fi
done

if [[ -f /quickstatements/data/qs-oauth.json ]]; then
    export OAUTH_CONSUMER_KEY=$(jq -r '.key' /quickstatements/data/qs-oauth.json);
    export OAUTH_CONSUMER_SECRET=$(jq -r '.secret' /quickstatements/data/qs-oauth.json);
fi

envsubst < /templates/config.json > /var/www/html/quickstatements/public_html/config.json
envsubst < /templates/oauth.ini > /var/www/html/quickstatements/oauth.ini
envsubst < /templates/php.ini > /usr/local/etc/php/conf.d/php.ini

docker-php-entrypoint apache2-foreground
