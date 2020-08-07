# OAuth
wfLoadExtension( 'OAuth' );
${DOLLAR}wgGroupPermissions['sysop']['mwoauthproposeconsumer'] = true;
${DOLLAR}wgGroupPermissions['sysop']['mwoauthmanageconsumer'] = true;
${DOLLAR}wgGroupPermissions['sysop']['mwoauthviewprivate'] = true;
${DOLLAR}wgGroupPermissions['sysop']['mwoauthupdateownconsumer'] = true;

# WikibaseImport
require_once "${DOLLAR}IP/extensions/WikibaseImport/WikibaseImport.php";

# CirrusSearch
wfLoadExtension( 'Elastica' );
wfLoadExtension( 'CirrusSearch' );
wfLoadExtension( 'WikibaseCirrusSearch' );
${DOLLAR}wgCirrusSearchServers = [ '${MW_ELASTIC_HOST}' ];
${DOLLAR}wgSearchType = 'CirrusSearch';
${DOLLAR}wgCirrusSearchExtraIndexSettings['index.mapping.total_fields.limit'] = 5000;
${DOLLAR}wgWBCSUseCirrus = true;

# UniversalLanguageSelector
wfLoadExtension( 'UniversalLanguageSelector' );

# cldr
wfLoadExtension( 'cldr' );

#EntitySchema
wfLoadExtension( 'EntitySchema' );
