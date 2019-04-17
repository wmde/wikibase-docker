#!/bin/bash

php /var/www/html/extensions/CirrusSearch/maintenance/updateSearchIndexConfig.php
php /var/www/html/extensions/CirrusSearch/maintenance/forceSearchIndex.php --skipParse
php /var/www/html/extensions/CirrusSearch/maintenance/forceSearchIndex.php --skipLinks --indexOnSkip

if [ ! -e "/quickstatements/data/qs-oauth.json" ]; then
	php /var/www/html/extensions/OAuth/maintenance/createOAuthConsumer.php --approve --callbackUrl  $QS_PUBLIC_SCHEME_HOST_AND_PORT \
		--callbackIsPrefix true --user Admin --name QuickStatements --description QuickStatements --version 1.0.1 \
		--grants createeditmovepage --grants editpage --grants highvolume --jsonOnSuccess > /quickstatements/data/qs-oauth.json
fi
