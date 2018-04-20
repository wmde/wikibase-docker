#!/usr/bin/env bash

# Test if required environment variables have been set
REQUIRED_VARIABLES=(OAUTH_CONSUMER_KEY OAUTH_CONSUMER_SECRET QS_PUBLIC_SCHEME_HOST_AND_PORT WB_PUBLIC_SCHEME_HOST_AND_PORT WIKIBASE_SCHEME_AND_HOST)
for i in ${REQUIRED_VARIABLES[@]}; do
    if ! [[ -v "$i" ]]; then
    echo "$i is required but isn't set. You should pass it to docker. See: https://docs.docker.com/engine/reference/commandline/run/#set-environment-variables--e---env---env-file";
    exit 1;
    fi
done

export DOLLAR='$'
envsubst < /templates/config.json > /var/www/html/quickstatements/public_html/config.json
envsubst < /templates/oauth.ini > /var/www/html/quickstatements/oauth.ini
envsubst < /templates/php.ini > /usr/local/etc/php/conf.d/php.ini

docker-php-entrypoint apache2-foreground
