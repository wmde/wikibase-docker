## wikibase-docker

This repo contains images needed to setup Wikibase and a query service using Docker.

Each image contained within this repo has its own README (linked below).

If you want some more light reading on the subject of using these images / this repo for beginners check out [this tag](https://addshore.com/tag/wikibase-docker/) specifically:
 - [Initial inception of these images](https://addshore.com/2017/12/wikibase-docker-images/)
 - [First basic example usage (the wikibase registry)](https://addshore.com/2018/04/wikibase-of-wikibases/)
 - [Customizing the exampe docker-compose file](https://addshore.com/2018/06/customizing-wikibase-config-in-the-docker-compose-example/)
 - [Creating your own Dockerfile for wikibase](https://addshore.com/2019/02/creating-a-dockerfile-for-the-wikibase-registry/)
 - [Example update process for wikibase](https://addshore.com/2019/01/wikibase-docker-mediawiki-wikibase-update/)

### Issue tracking

We use [Phabricator to track
issues](https://phabricator.wikimedia.org/maniphest/task/edit/form/1/?projects=wikibase-containers). See the [list of current issues](https://phabricator.wikimedia.org/maniphest/?project=wikibase-containers&statuses=open&group=none&order=newest#R).

### Images

Image name               | Description   | README
------------------------ | ------------- | ----------
[`wikibase/wikibase`](https://hub.docker.com/r/wikibase/wikibase) | MediaWiki with the Wikibase extension| [README](https://github.com/wmde/wikibase-docker/blob/master/wikibase/README.md)
[`wikibase/wdqs`](https://hub.docker.com/r/wikibase/wdqs) | Blazegraph SPARQL query service backend | [README](https://github.com/wmde/wikibase-docker/blob/master/wdqs/README.md)
[`wikibase/wdqs-proxy`](https://hub.docker.com/r/wikibase/wdqs-proxy) | Proxy to make the query service READONLY and enforce query timeouts | [README](https://github.com/wmde/wikibase-docker/blob/master/wdqs-proxy/README.md)
[`wikibase/wdqs-frontend`](https://hub.docker.com/r/wikibase/wdqs-frontend) | UI for the SPARQL query service | [README](https://github.com/wmde/wikibase-docker/blob/master/wdqs-frontend/README.md)
[`wikibase/quickstatements`](https://hub.docker.com/r/wikibase/quickstatements) | UI to add data to Wikibase | [README](https://github.com/wmde/wikibase-docker/blob/master/quickstatements/README.md)

### Docker compose example

This repo contains an EXAMPLE docker compose setup for Wikibase.

[README](https://github.com/wmde/wikibase-docker/blob/master/README-compose.md)
