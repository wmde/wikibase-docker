#!/bin/sh

/wait-for-it.sh wikibase.svc:80 -t 60
/wait-for-it.sh wdqs:9999 -t 60

/wdqs/runUpdate.sh -h http://wdqs:9999 -- --wikibaseHost wikibase.svc --wikibaseScheme http --entityNamespaces 120,122
