<?php

## Database settings
$wgDBserver = "mysql";
$wgDBname = "my_wiki";
$wgDBuser = "wikiuser";
$wgDBpassword = "sqlpass";

## Locale

$wgShellLocale = "en_US.utf8";
$wgLanguageCode = "en";

$wgSitename = "docker-wikibase";
$wgMetaNamespace = "Project";
$wgScriptPath = "";

wfLoadSkin( 'Vector' );