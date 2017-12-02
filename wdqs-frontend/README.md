## wdqs-frontend docker image

UI for the wikibase query service, as seen @ [https://query.wikidata.org](https://query.wikidata.org) for Wikidata.

Automated build.

## Tags

Image name                      | Parent image             | WDQS UI Version
------------------------------- | ------------------------ | --------------
`wikibase/wdqs-frontend:latest` | [nginx:stable-alpine](https://hub.docker.com/_/nginx/) | master


## Environment variables

Variable          | Default                      | Description
------------------|  ----------------------------| ----------
`LANGUAGE`        | "en"                         | Language to use in the UI
`BRAND_TITLE`     | "DockerWikibaseQueryService" | Name to display on the UI
`WIKIBASE_HOST`   | "wikibase.svc"               | Hostname of the Wikibase host
`WDQS_HOST`       | "wdqs-proxy.svc"             | Hostname of the WDQS host (probably READONLY, hence use of the wdqs-proxy service)
