## wikibase docker image

Wikibase extension running on Mediawiki.

If no `LocalSettings.php` file is mounted then an installation & update will automatically happen.
If `LocalSettings.php` is mounted then the image assumes you will do this yourself.

Automated build.

### Tags

Image name                                                                               | Parent image
------------------------------------------------------------------------------------     | ------------------------
`wikibase/wikibase` : `latest`, `1.35`, `lts`, `latest-base`, `1.35-base`, `lts-base`    | [mediawiki:1.35](https://hub.docker.com/_/mediawiki/)
`wikibase/wikibase` : `1.31`, `1.31-base`                                                | [mediawiki:1.31](https://hub.docker.com/_/mediawiki/)
`wikibase/wikibase` : `latest-bundle`, `lts-bundle`, `1.35-bundle`                       | [wikibase:1.35](https://hub.docker.com/r/wikibase/wikibase/)
`wikibase/wikibase` : `1.31-bundle`                                                      | [wikibase:1.31](https://hub.docker.com/r/wikibase/wikibase/)

### Version support

Wikibase operates a continuous development model (alongside Mediawiki), where software changes are pushed live to Wikimedia sites such as Wikidata on a regular basis.

The LTS (long term stable) and EOL (end of life) versions and dates for Wikibase are the same as those for Mediawiki.

See https://www.mediawiki.org/wiki/Version_lifecycle for more details.

## Bundle image
Wikibase-bundle images are built from the base wikibase images and also include the following additional extensions:
- [OAuth](https://www.mediawiki.org/wiki/Extension:OAuth)
- [Elastica](https://www.mediawiki.org/wiki/Extension:Elastica)
- [CirrusSearch](https://www.mediawiki.org/wiki/Extension:CirrusSearch)
- [CLDR](https://www.mediawiki.org/wiki/Extension:CLDR)
- [WikibaseImport](https://github.com/filbertkm/WikibaseImport)
- [UniversalLanguageSelector](https://www.mediawiki.org/wiki/Extension:UniversalLanguageSelector)
- [EntitySchema](https://www.mediawiki.org/wiki/Extension:EntitySchema) (from 1.33)
- [WikibaseCirrusSearch](https://www.mediawiki.org/wiki/Extension:WikibaseCirrusSearch) (from 1.34)

### Upgrading

When upgrading between Wikibase versions you will have to run update.php to update your mysql tables.

A blog post documenting the update progress for this image in a docker-compose setup can be found [here](https://addshore.com/2019/01/wikibase-docker-mediawiki-wikibase-update/)


### Environment variables

Note: MW_ADMIN_NAME and MW_ADMIN_PASS probably shouldn't be here...

Variable          | Default                   | Description
------------------|  -------------------------| ----------
`DB_SERVER`       | "mysql.svc:3306"          | Hostname and port for the MySQL server to use for Mediawiki & Wikibase
`DB_USER`         | "wikiuser"                | Username to use for the MySQL server
`DB_PASS`         | "sqlpass"                 | Password to use for the MySQL server
`DB_NAME`         | "my_wiki"                 | Database name to use for the MySQL server
`MW_SITE_NAME`    | "wikibase-docker"         | $wgSitename to use for MediaWiki
`MW_SITE_LANG`    | "en"                      | $wgLanguageCode to use for MediaWiki
`MW_ADMIN_NAME`   | "WikibaseAdmin"           | Admin username to create on MediaWiki first install
`MW_ADMIN_PASS`   | "WikibaseDockerAdminPass" | Admin password to use for admin account on first install
`MW_WG_SECRET_KEY`| "secretkey"               | Used as source of entropy for persistent login/Oauth etc..(since 1.30)

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

### Development

A new image should be created for every major release of MediaWiki and Wikibase.
These images currently use the [MediaWiki docker hub base image](https://hub.docker.com/_/mediawiki), so that needs to have a new version prior to updates here.

 - Create a new release folder, copying the content from a previous release
 - Update the base Dockerfile to fetch the latest mediawiki image
 - Update the bundle Dockerfile to use the new version of the base image
 - Update download-extension.sh to fetch new versions of the extensions
 - Update the CI build by checking the steps in the main README Development section in this repo.

Releases that are no longer supported per the [Version lifecycle](https://www.mediawiki.org/wiki/Version_lifecycle) can be deleted.
