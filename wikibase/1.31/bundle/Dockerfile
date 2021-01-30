FROM ubuntu:xenial as fetcher

RUN apt-get update && \
    apt-get install --yes --no-install-recommends unzip=6.* jq=1.* curl=7.* ca-certificates=201* && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

COPY download-extension.sh .
ADD https://github.com/wikidata/WikibaseImport/archive/master.tar.gz /WikibaseImport.tar.gz
RUN bash download-extension.sh OAuth;\
bash download-extension.sh Elastica;\
bash download-extension.sh CirrusSearch;\
bash download-extension.sh UniversalLanguageSelector;\
bash download-extension.sh cldr;\
tar xzf OAuth.tar.gz;\
tar xzf Elastica.tar.gz;\
tar xzf CirrusSearch.tar.gz;\
tar xzf UniversalLanguageSelector.tar.gz;\
tar xzf cldr.tar.gz;\
tar xzf WikibaseImport.tar.gz;\
rm ./*.tar.gz

FROM wikibase/wikibase:1.31 as collector
COPY --from=fetcher /WikibaseImport-master /var/www/html/extensions/WikibaseImport
COPY --from=fetcher /Elastica /var/www/html/extensions/Elastica
COPY --from=fetcher /OAuth /var/www/html/extensions/OAuth
COPY --from=fetcher /CirrusSearch /var/www/html/extensions/CirrusSearch
COPY --from=fetcher /UniversalLanguageSelector /var/www/html/extensions/UniversalLanguageSelector
COPY --from=fetcher /cldr /var/www/html/extensions/cldr

FROM composer@sha256:d374b2e1f715621e9d9929575d6b35b11cf4a6dc237d4a08f2e6d1611f534675 as composer
COPY --from=collector /var/www/html /var/www/html
WORKDIR /var/www/html/
RUN rm /var/www/html/composer.lock
RUN composer install --no-dev

FROM wikibase/wikibase:1.31

RUN apt-get update && \
    apt-get install --yes --no-install-recommends jq=1.* && \
    apt-get clean && rm -rf /var/lib/apt/lists/*
COPY --from=composer /var/www/html /var/www/html
COPY LocalSettings.php.wikibase-bundle.template /LocalSettings.php.wikibase-bundle.template
COPY extra-install.sh /
COPY extra-entrypoint-run-first.sh /
RUN cat /LocalSettings.php.wikibase-bundle.template >> /LocalSettings.php.template && rm /LocalSettings.php.wikibase-bundle.template
COPY oauth.ini /templates/oauth.ini
