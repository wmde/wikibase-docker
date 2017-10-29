#!/bin/sh

# Wait for the db to come up
/wait-for-it.sh mysql.svc:3306 -t 60
# Sometimes it appears to come up and then go back down meaning MW install fails
# So wait for a second and double check!
sleep 1
/wait-for-it.sh mysql.svc:3306 -t 60

# Do the mediawiki install
# TODO if LocalSettings already exists DONT run install.php!!
php /var/www/html/maintenance/install.php --dbuser wikiuser --dbpass sqlpass --dbname my_wiki --dbserver mysql.svc --lang en --pass adminpass docker-wikibase admin

# Copy our LocalSettings into place after install
cp /LocalSettings.php /var/www/html/

# Run update.php to install Wikibase
php /var/www/html/maintenance/update.php --quick

# Run the actual entry point
docker-php-entrypoint apache2-foreground