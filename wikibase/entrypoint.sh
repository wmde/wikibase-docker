#!/bin/sh

# Do the mediawiki install
php /var/www/html/maintenance/install.php --dbuser wikiuser --dbpass sqlpass --dbname my_wiki --dbserver mysql --lang en --pass adminpass docker-wikibase admin

# Run the actual entry point
docker-php-entrypoint apache2-foreground