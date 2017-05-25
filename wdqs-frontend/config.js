/* exported CONFIG */
var CONFIG = ( function ( window, $ ) {
    'use strict';

    return {
        language: 'LANGUAGE',
        api: {
            sparql: {
                uri: 'SPARQL_URI'
            },
            wikibase: {
                uri: 'WIKIBASE_API'
            }
        },
        i18nLoad: function( lang ) {
            var loadFallbackLang = null;
            if ( lang !== this.language ) {
                //load default language as fallback language
                loadFallbackLang = $.i18n().load( 'i18n/' + this.language + '.json', this.language );
            }
            return $.when(
                loadFallbackLang,
                $.i18n().load( 'i18n/' + lang + '.json', lang )
            );
        },
        brand: {
            title: 'BRAND_TITLE'
        }
    };

} )( window, jQuery );