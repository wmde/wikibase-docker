## wikibase-docker

This repo contains images needed to setup Wikibase and a query service using Docker.

Each image contained within this repo has its own README (linked below).

### Issue tracking

We use [Phabricator to track
issues](https://phabricator.wikimedia.org/maniphest/task/edit/form/1/?projects=wikibase-containers). See the [list of current issues](https://phabricator.wikimedia.org/maniphest/?project=wikibase-containers&statuses=open&group=none&order=newest#R).

### Images

Image name               | Description   | README
------------------------ | ------------- | ----------
[`wikibase/wikibase`](https://store.docker.com/community/images/wikibase/wikibase) | MediaWiki with the Wikibase extension| [README](https://github.com/wmde/wikibase-docker/blob/master/wikibase/README.md)
[`wikibase/wdqs`](https://store.docker.com/community/images/wikibase/wdqs) | Blazegraph SPARQL query service backend | [README](https://github.com/wmde/wikibase-docker/blob/master/wdqs/README.md)
[`wikibase/wdqs-proxy`](https://store.docker.com/community/images/wikibase/wdqs-proxy) | Proxy to make the query service READONLY and enforce query timeouts | [README](https://github.com/wmde/wikibase-docker/blob/master/wdqs-proxy/README.md)
[`wikibase/wdqs-frontend`](https://store.docker.com/community/images/wikibase/wdqs-frontend) | UI for the SPARQL query service | [README](https://github.com/wmde/wikibase-docker/blob/master/wdqs-frontend/README.md)
[`wikibase/quickstatements`](https://store.docker.com/community/images/wikibase/quickstatements) | UI to add data to Wikibase | [README](https://github.com/wmde/wikibase-docker/blob/master/quickstatements/README.md)

### Docker compose example

This repo contains an EXAMPLE docker compose setup for Wikibase.

[README](https://github.com/wmde/wikibase-docker/blob/master/README-compose.md)
