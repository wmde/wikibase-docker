#!/usr/bin/env bash
# This file is provided by the wikibase/wdqs docker image.

cd /wdqs

# TODO env vars for entity namespaces, scheme and other settings
/wait-for-it.sh $WIKIBASE_HOST:80 -t 120 -- \
/wait-for-it.sh $WDQS_HOST:$WDQS_PORT -t 120 -- \
export WIKIBASE_SCHEME="${WIKIBASE_SCHEME:-http}"
export WIKIBASE_CONCEPT_URI="${WIKIBASE_CONCEPT_URI:-${WIKIBASE_SCHEME}://${WIKIBASE_HOST}}"
./runUpdate.sh -h http://$WDQS_HOST:$WDQS_PORT -- --wikibaseHost $WIKIBASE_HOST --wikibaseScheme $WIKIBASE_SCHEME --entityNamespaces $WDQS_ENTITY_NAMESPACES --conceptUri $WIKIBASE_CONCEPT_URI