## LEGACY: wikibase-docker

**This repository will no longer be maintained by WMDE.**

Please see the announcement for new WMDE maintained docker images https://lists.wikimedia.org/hyperkitty/list/wikibaseug@lists.wikimedia.org/thread/WW4LZJINT3PIG3DOYKTXIWVP3WAKWXCT/
Along with docs https://www.mediawiki.org/wiki/Wikibase/Docker

-----

### Issue tracking

Please do not file issues against these legacy docker images.

### Development

These images are no longer developed.

### Further reading

 - [Docker Wikibase Install Docs](https://www.mediawiki.org/wiki/Wikibase/Docker)
 - [Announcement of new WMDE maintained docker images & releases](https://lists.wikimedia.org/hyperkitty/list/wikibaseug@lists.wikimedia.org/thread/WW4LZJINT3PIG3DOYKTXIWVP3WAKWXCT/)

### Old Repo Guide

Each legacy image contained within this repo has its own README with more detailed information:

LEGACY Image name               | Description   | README
------------------------ | ------------- | ----------
[`wikibase/wikibase`](https://hub.docker.com/r/wikibase/wikibase) | MediaWiki with the Wikibase extension| [README](https://github.com/wmde/wikibase-docker/blob/master/wikibase/README.md)
[`wikibase/wdqs`](https://hub.docker.com/r/wikibase/wdqs) | Blazegraph SPARQL query service backend | [README](https://github.com/wmde/wikibase-docker/blob/master/wdqs/README.md)
[`wikibase/wdqs-proxy`](https://hub.docker.com/r/wikibase/wdqs-proxy) | Proxy to make the query service READONLY and enforce query timeouts | [README](https://github.com/wmde/wikibase-docker/blob/master/wdqs-proxy/README.md)
[`wikibase/wdqs-frontend`](https://hub.docker.com/r/wikibase/wdqs-frontend) | UI for the SPARQL query service | [README](https://github.com/wmde/wikibase-docker/blob/master/wdqs-frontend/README.md)
[`wikibase/quickstatements`](https://hub.docker.com/r/wikibase/quickstatements) | UI to add data to Wikibase | [README](https://github.com/wmde/wikibase-docker/blob/master/quickstatements/README.md)
