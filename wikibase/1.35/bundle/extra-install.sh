#!/bin/bash

php /var/www/html/extensions/CirrusSearch/maintenance/UpdateSearchIndexConfig.php
php /var/www/html/extensions/CirrusSearch/maintenance/ForceSearchIndex.php --skipParse
php /var/www/html/extensions/CirrusSearch/maintenance/ForceSearchIndex.php --skipLinks --indexOnSkip

n=0
until [ $n -ge 5 ]
do
   php /var/www/html/extensions/OAuth/maintenance/createOAuthConsumer.php --approve --callbackUrl  $QS_PUBLIC_SCHEME_HOST_AND_PORT/api.php \
	--callbackIsPrefix true --user $MW_ADMIN_NAME --name QuickStatements --description QuickStatements --version 1.0.1 \
	--grants createeditmovepage --grants editpage --grants highvolume --jsonOnSuccess > /quickstatements/data/qs-oauth.json && break
	n=$[$n+1]
	sleep 5s
done

if [[ -f /quickstatements/data/qs-oauth.json ]]; then
    export OAUTH_CONSUMER_KEY=$(jq -r '.key' /quickstatements/data/qs-oauth.json);
    export OAUTH_CONSUMER_SECRET=$(jq -r '.secret' /quickstatements/data/qs-oauth.json);
	envsubst < /templates/oauth.ini > /quickstatements/data/oauth.ini
fi
