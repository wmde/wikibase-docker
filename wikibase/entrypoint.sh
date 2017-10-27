#!/bin/sh

# Wait for the db to come up
/wait-for-it.sh mysql:3306

# Do the mediawiki install
# TODO if LocalSettings already exists DONT run install.php!!
php /var/www/html/maintenance/install.php --dbuser wikiuser --dbpass sqlpass --dbname my_wiki --dbserver mysql --lang en --pass adminpass docker-wikibase admin

# Copy our LocalSettings into place after install
cp /LocalSettings.php /var/www/html/

# Run the actual entry point
docker-php-entrypoint apache2-foreground