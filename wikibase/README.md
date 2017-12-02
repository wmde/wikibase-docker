## wikibase docker image

Wikibase extension running on Mediawiki.

NOTE: this image currently installs Mediawiki and probably shouldn't automagically do that.

Automated build.

## Tags

Image name                    | Parent image            
----------------------------- | ------------------------
`wikibase/wikibase:1.29`      | [mediawiki:1.29](https://hub.docker.com/_/mediawiki/)

## Environment variables

Note: MW_ADMIN_NAME and MW_ADMIN_PASS probably shouldn't be here...

Variable          | Default              | Description
------------------|  --------------------| ----------
`DB_SERVER`       | "mysql.svc:3306"     | Hostname and port for the MySQL server to use for Mediawiki & Wikibase
`DB_USER`         | "wikiuser"           | Username to use for the MySQL server
`DB_PASS`         | "sqlpass"            | Password to use for the MySQL server
`DB_NAME`         | "my_wiki"            | Database name to use for the MySQL server
`MW_SITE_NAME`    | "wikibase-docker"    | $wgSitename to use for MediaWiki
`MW_SITE_LANG`    | "en"                 | $wgLanguageCode to use for MediaWiki
`MW_ADMIN_NAME`   | "admin"              | Admin username to create on MediaWiki first install
`MW_ADMIN_PASS`   | "adminpass"          | Admin password to use for admin account on first install

## Filesystem layout

Directory                         | Description
--------------------------------- | ------------------------------------------------------------------------------
`/var/www/html`                   | Base Mediawiki directory

File                              | Description
--------------------------------- | ------------------------------------------------------------------------------
`/LocalSettings.php.template`     | Template for Mediawiki Localsettings.php (substituted to `/var/www/html/LocalSettings.php` at runtime)