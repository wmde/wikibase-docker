## wikibase docker image

Wikibase extension running on Mediawiki.

If no `LocalSettings.php` file is mounted then an installation & update will automatically happen.
If `LocalSettings.php` is mounted then the image assumes you will do this yoruself.

Automated build.

## Tags

Image name                                  | Parent image            
------------------------------------------- | ------------------------
`wikibase/wikibase` : `latest`, `1.30`      | [mediawiki:1.30](https://hub.docker.com/_/mediawiki/)
`wikibase/wikibase` : `legacy`, `1.29`      | [mediawiki:1.29](https://hub.docker.com/_/mediawiki/)

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
`/var/www/html/skins`             | Mediawiki skins directory
`/var/www/html/extensions`        | Mediawiki extensions directory

File                              | Description
--------------------------------- | ------------------------------------------------------------------------------
`/LocalSettings.php.template`     | Template for Mediawiki Localsettings.php (substituted to `/var/www/html/LocalSettings.php` at runtime)
`/var/www/html/LocalSettings.php` | LocalSettings.php location, when passed in `/LocalSettings.php.template` will not be used. install.php & update.php will also not be run.