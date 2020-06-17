## wikibase-docker

This repo contains [Docker](https://www.docker.com/) images needed to setup a local Wikibase instance and a query service.

Each image contained within this repo has its own README with more detailed information:

Image name               | Description   | README
------------------------ | ------------- | ----------
[`wikibase/wikibase`](https://hub.docker.com/r/wikibase/wikibase) | MediaWiki with the Wikibase extension| [README](https://github.com/wmde/wikibase-docker/blob/master/wikibase/README.md)
[`wikibase/wdqs`](https://hub.docker.com/r/wikibase/wdqs) | Blazegraph SPARQL query service backend | [README](https://github.com/wmde/wikibase-docker/blob/master/wdqs/README.md)
[`wikibase/wdqs-proxy`](https://hub.docker.com/r/wikibase/wdqs-proxy) | Proxy to make the query service READONLY and enforce query timeouts | [README](https://github.com/wmde/wikibase-docker/blob/master/wdqs-proxy/README.md)
[`wikibase/wdqs-frontend`](https://hub.docker.com/r/wikibase/wdqs-frontend) | UI for the SPARQL query service | [README](https://github.com/wmde/wikibase-docker/blob/master/wdqs-frontend/README.md)
[`wikibase/quickstatements`](https://hub.docker.com/r/wikibase/quickstatements) | UI to add data to Wikibase | [README](https://github.com/wmde/wikibase-docker/blob/master/quickstatements/README.md)

### Docker compose example

This repo contains an EXAMPLE docker compose setup for Wikibase (specified in the [docker-compose.yml](docker-compose.yml) file) that combines the images described above to set up a fully-featured local Wikibase environment. You can use that file as a base to build a custom environment tailored to your needs.

To try it out, make sure you have Docker installed, then just clone this repository, enter its directory and run `docker-compose up -d`. Once that step completes, you should have:
- a MediaWiki wiki fully configured with [Wikibase](https://www.mediawiki.org/wiki/Wikibase), available at http://localhost:8181
- a [Wikidata Query Service](https://www.mediawiki.org/wiki/Wikidata_Query_Service) instance available at http://localhost:8282
- a [QuickStatements](https://www.wikidata.org/wiki/Help:QuickStatements) instance, available at http://localhost:9191

Note that the Wikibase instance has no data; no items or properties. To add some data, use the `Special:NewItem` and `Special:NewProperty` pages in the local wiki; then you can add statements to the added items using the properties you defined.

For more information about this example enviroment, please see the [README-compose.md](https://github.com/wmde/wikibase-docker/blob/master/README-compose.md) file.

### Issue tracking

We use [Phabricator to track
issues](https://phabricator.wikimedia.org/maniphest/task/edit/form/1/?projects=wikibase-containers). See the [list of current issues](https://phabricator.wikimedia.org/maniphest/?project=wikibase-containers&statuses=open&group=none&order=newest#R).

### Development

New images will be build and automatically pushed to docker hub when merged on master.
Builds on branches and in PRs will not be pushed.

Each image directory contains a README with a separate Development section for how updates of that image generally work.

The following steps relate to all images:

 - Update the various .travis/build-deploy.sh scripts to correctly tag the images that are being built, including updating the latest tag.
 - Update .travis.yml to reflect new or removed images

### Further reading

For beginner-friendly light reading on the subject of using these images / this repo, check out the posts under [this tag](https://addshore.com/tag/wikibase-docker/), specifically:
 - [Announcement of the creation of these images](https://addshore.com/2017/12/wikibase-docker-images/)
 - [First basic example usage (the wikibase registry)](https://addshore.com/2018/04/wikibase-of-wikibases/)
 - [Customizing the example docker-compose file](https://addshore.com/2018/06/customizing-wikibase-config-in-the-docker-compose-example/)
 - [Creating your own Dockerfile for wikibase](https://addshore.com/2019/02/creating-a-dockerfile-for-the-wikibase-registry/)
 - [Example update process for wikibase](https://addshore.com/2019/01/wikibase-docker-mediawiki-wikibase-update/)
 - [Changing the concept URI of an existing Wikibase with data](https://addshore.com/2019/11/changing-the-concept-uri-of-an-existing-wikibase-with-data/)
