## wikibase docker image

Wikibase extension running on Mediawiki.

If no `LocalSettings.php` file is mounted then an installation & update will automatically happen.
If `LocalSettings.php` is mounted then the image assumes you will do this yourself.

Automated build.

### Tags

Image name                                                            | Parent image
-----------------------------------------------------------------     | ------------------------
`wikibase/wikibase` : `latest`, `1.30`, `latest-base`, `1.30-base`    | [mediawiki:1.30](https://hub.docker.com/_/mediawiki/)
`wikibase/wikibase` : `legacy`, `1.29`                                | [mediawiki:1.29](https://hub.docker.com/_/mediawiki/)
`wikibase/wikibase` : `latest-bundle`, `1.30-bundle`                  | [wikibase:1.30](https://hub.docker.com/r/wikibase/wikibase/)

## Bundle image
Wikibase-bundle images are built from the base wikibase images and also include the following addtional extensions:
- [OAuth](https://www.mediawiki.org/wiki/Extension:OAuth)
- [Elastica](https://www.mediawiki.org/wiki/Extension:Elastica)
- [CirrusSearch](https://www.mediawiki.org/wiki/Extension:CirrusSearch)
- [WikibaseImport](https://github.com/filbertkm/WikibaseImport)

### Upgrading

When upgrading between Wikibase versions you will have to run update.php to update your mysql tables.

To do this you can run the following command on the newer container:

```docker exec 275129f0ebfe php //var/www/html/maintenance/update.php```


### Environment variables

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
`MW_WG_SECRET_KEY`| "secretkey"          | Used as source of entropy for persistent login/Oauth etc..(since 1.30)

### Filesystem layout

Directory                         | Description
--------------------------------- | ------------------------------------------------------------------------------
`/var/www/html`                   | Base Mediawiki directory
`/var/www/html/skins`             | Mediawiki skins directory
`/var/www/html/extensions`        | Mediawiki extensions directory

File                              | Description
--------------------------------- | ------------------------------------------------------------------------------
`/LocalSettings.php.template`     | Template for Mediawiki Localsettings.php (substituted to `/var/www/html/LocalSettings.php` at runtime)
`/var/www/html/LocalSettings.php` | LocalSettings.php location, when passed in `/LocalSettings.php.template` will not be used. install.php & update.php will also not be run.
`/extra-install.sh`               | Extra code that will be run if LocalSettings.php isn't present (since 1.30)
`/extra-preinstall-runtime.sh`    | Extra code that will be run from the entrypoint every time (since 1.30)

### Running Maintenance Scripts
Maintenance scripts from extensions and mediawiki core can be run with `docker exec` using the wikibase/wikibase container as the targeted container

For example to run a maintenance script from WikibaseImport:

```docker exec <container name / hash> php //var/www/html/extensions/WikibaseImport/maintenance/importEntities.php --entity Q147```
