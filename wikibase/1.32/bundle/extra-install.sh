#!/bin/bash

php /var/www/html/extensions/CirrusSearch/maintenance/updateSearchIndexConfig.php
php /var/www/html/extensions/CirrusSearch/maintenance/forceSearchIndex.php --skipParse
php /var/www/html/extensions/CirrusSearch/maintenance/forceSearchIndex.php --skipLinks --indexOnSkip
