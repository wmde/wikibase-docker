#!/bin/sh

: ${BRAND_TITLE:=WikibaseQuery}
: ${LANGUAGE:=en}
: ${SPARQL_URI:="https://query.wikidata.org/bigdata/namespace/wdq/sparql"}
: ${WIKIBASE_API:="https://www.wikidata.org/w/api.php"}

sed -i 's|BRAND_TITLE|'"$BRAND_TITLE"'|' /usr/share/nginx/html/wikibase/config.js
sed -i 's|LANGUAGE|'"$LANGUAGE"'|' /usr/share/nginx/html/wikibase/config.js
sed -i 's|SPARQL_URI|'"$SPARQL_URI"'|' /usr/share/nginx/html/wikibase/config.js
sed -i 's|WIKIBASE_API|'"$WIKIBASE_API"'|' /usr/share/nginx/html/wikibase/config.js

exec "$@"