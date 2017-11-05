#!/bin/sh

# Wait for the db to come up
/wait-for-it.sh $DB_SERVER -t 60
# Sometimes it appears to come up and then go back down meaning MW install fails
# So wait for a second and double check!
sleep 1
/wait-for-it.sh $DB_SERVER -t 60

# Do the mediawiki install
# TODO if LocalSettings already exists DONT run install.php!!
php /var/www/html/maintenance/install.php --dbuser $DB_USER --dbpass $DB_PASS --dbname $DB_NAME --dbserver $DB_SERVER --lang $MW_SITE_LANG --pass $MW_ADMIN_PASS $MW_SITE_NAME $MW_ADMIN_NAME

# Copy our LocalSettings into place after install from the template
# https://stackoverflow.com/a/24964089/4746236
export DOLLAR='$'
envsubst < /LocalSettings.php.template > /var/www/html/LocalSettings.php

# Run update.php to install Wikibase
php /var/www/html/maintenance/update.php --quick

# Run the actual entry point
docker-php-entrypoint apache2-foreground