#!/usr/bin/env bash

cd /wdqs

# TODO env vars for entity namespaces, scheme and other settings
wait-for-it.sh $WIKIBASE_HOST:80 -t 60 -- \
/wait-for-it.sh $WDQS_HOST:$WDQS_PORT -t 60 -- \
./runUpdate.sh -h http://$WDQS_HOST:$WDQS_PORT -- --wikibaseHost $WIKIBASE_HOST --wikibaseScheme http --entityNamespaces 120,122
