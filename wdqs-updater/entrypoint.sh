#!/bin/sh

: ${WIKIBASE_HOSTNAME:=www.wikidata.org}
: ${QUERY_SERVICE_BACKEND:=wdqs:9999}

echo /tmp/wikidata-query-rdf/dist/src/script/runUpdate.sh -h $QUERY_SERVICE_BACKEND -- \""-DwikibaseHost=$WIKIBASE_HOSTNAME\"" > /runUpdate.sh
chmod +x /runUpdate.sh

exec "$@"