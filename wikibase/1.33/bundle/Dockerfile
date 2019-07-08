FROM ubuntu:xenial as fetcher

RUN apt-get update && \
    apt-get install --yes --no-install-recommends unzip=6.* jq=1.* curl=7.* ca-certificates=201* && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

COPY download-extension.sh .
ADD https://github.com/filbertkm/WikibaseImport/archive/master.tar.gz /WikibaseImport.tar.gz
RUN bash download-extension.sh OAuth;\
bash download-extension.sh Elastica;\
bash download-extension.sh CirrusSearch;\
bash download-extension.sh UniversalLanguageSelector;\
bash download-extension.sh cldr;\
# Temporary, will remove once 1.34 is there
curl -s "https://gerrit.wikimedia.org/r/plugins/gitiles/mediawiki/extensions/EntitySchema/+archive/wmf/1.34.0-wmf.8.tar.gz" -o EntitySchema.tar.gz;\
tar xzf OAuth.tar.gz;\
tar xzf Elastica.tar.gz;\
tar xzf CirrusSearch.tar.gz;\
tar xzf UniversalLanguageSelector.tar.gz;\
tar xzf cldr.tar.gz;\
tar xzf WikibaseImport.tar.gz;\
mkdir EntitySchema;\
tar xzf EntitySchema.tar.gz -C EntitySchema

FROM composer as composer
COPY --from=fetcher /WikibaseImport-master /WikibaseImport
WORKDIR /WikibaseImport
RUN composer install --no-dev
COPY --from=fetcher /Elastica /Elastica
WORKDIR /Elastica
RUN composer install --no-dev

FROM wikibase/wikibase:1.33
COPY --from=fetcher /OAuth /var/www/html/extensions/OAuth
COPY --from=composer /Elastica /var/www/html/extensions/Elastica
COPY --from=fetcher /CirrusSearch /var/www/html/extensions/CirrusSearch
COPY --from=fetcher /UniversalLanguageSelector /var/www/html/extensions/UniversalLanguageSelector
COPY --from=fetcher /cldr /var/www/html/extensions/cldr
COPY --from=fetcher /EntitySchema /var/www/html/extensions/EntitySchema
COPY --from=composer /WikibaseImport /var/www/html/extensions/WikibaseImport
COPY LocalSettings.php.wikibase-bundle.template /LocalSettings.php.wikibase-bundle.template
COPY extra-install.sh /
COPY extra-entrypoint-run-first.sh /
RUN cat /LocalSettings.php.wikibase-bundle.template >> /LocalSettings.php.template && rm /LocalSettings.php.wikibase-bundle.template
