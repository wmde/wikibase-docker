/* exported CONFIG */
var CONFIG = ( function ( window, $ ) {
    'use strict';

    function getUserLanguage() {
        var lang = ( navigator.languages && navigator.languages[0] ) ||
            navigator.language ||
            navigator.userLanguage;

        if ( lang && typeof lang === 'string' ) {
            return lang.split( '-' ).shift();
        }

        return null;
    }

    /* This is evil and can probably die */
    var root = 'https://query.wikidata.org/';

    var configDeploy = {
        language: getUserLanguage() || 'LANGUAGE',
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
            logo: 'logo.svg',
            title: 'Wikidata Query'
        },
        location: {
            root: root,
            index: root
        },
        showBirthdayPresents: new Date().getTime() >= Date.UTC( 2017, 10 - 1, 29 )
    };

    var hostname = window.location.hostname.toLowerCase();

    if ( hostname === '' || hostname === 'localhost' || hostname === '127.0.0.1' ) {

        // Override for local debugging
        return $.extend( true, {}, configDeploy, {
            api: {
                sparql: {
                    uri: 'SPARQL_URI'

                }
            },
            i18nLoad: function( lang ) {
                return $.when(
                    $.i18n().load( 'i18n/' + lang + '.json', lang ),
                    $.i18n().load( 'node_modules/jquery.uls/i18n/' + lang + '.json', lang )
                );
            },
            brand: {
                title: 'BRAND_TITLE'
            },
            location: {
                root: './',
                index: './index.html'
            },
            showBirthdayPresents: true
        } );
    }

    return configDeploy;

} )( window, jQuery );