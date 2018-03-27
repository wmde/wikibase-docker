## wdqs docker image

Wikibase specific blazegraph image.

WARNING: This image seems to require quite allot of memory for the JVM of blazegraph to start. If you are running Docker for Windows or Mac and have containers run within a VM (the default) make sure you set your VM memory allocation to somethig greater than 2GB (4GB recommended). If you don't do this the query service may fail to run. It might be possible to fix this memory hogging at some point.

Automated build.

### Tags

Image name                    | Parent image             | WDQS Version
----------------------------- | ------------------------ | --------------
`wikibase/wdqs:0.3.0` | [openjdk:8-jdk-alpine](https://hub.docker.com/_/openjdk/) | [0.3.0](https://search.maven.org/#artifactdetails%7Corg.wikidata.query.rdf%7Cservice%7C0.2.5%7Cpom)
`wikibase/wdqs:0.2.5` | [openjdk:8-jdk-alpine](https://hub.docker.com/_/openjdk/) | [0.2.5](https://search.maven.org/#artifactdetails%7Corg.wikidata.query.rdf%7Cservice%7C0.2.5%7Cpom)


### Environment variables

Variable          | Default        | Description
------------------|  --------------| ----------
`MEMORY`          | ""             | Memory limit for blazegraph
`HEAP_SIZE`       | "1g"           | Heap size for blazegraph
`WIKIBASE_HOST`   | "wikibase.svc" | Hostname of the Wikibase host
`WDQS_HOST`       | "wdqs.svc"     | Hostname of the WDQS host (this service)
`WDQS_PORT`       | "9999"         | Port of the WDQS host (this service)


### Filesystem layout

File                              | Description
--------------------------------- | ------------------------------------------------------------------------------
`/wdqs/whitelist.txt`             | Whitelist file for other SPARQL endpoints
`/wdqs/RWStore.properties`        | Properties for the service
`/templates/mwservices.json`      | Template for MediaWiki services (substituted to `/wdqs/mwservices.json` at runtime)
