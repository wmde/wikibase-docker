#!/bin/sh

/wait-for-it.sh wikibase:80
/wait-for-it.sh wdqs:9999

/wikidata-query-rdf/dist/target/service-0.3.0-SNAPSHOT/runUpdate.sh -h http://wdqs:9999