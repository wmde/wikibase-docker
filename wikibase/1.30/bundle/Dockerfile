FROM ubuntu:xenial as fetcher

RUN apt-get update && \
    apt-get install --yes --no-install-recommends unzip=6.* jq=1.* curl=7.* ca-certificates=201*
COPY download-extension.sh .
ADD https://github.com/filbertkm/WikibaseImport/archive/master.tar.gz /WikibaseImport.tar.gz
RUN bash download-extension.sh OAuth;\
bash download-extension.sh Elastica;\
bash download-extension.sh CirrusSearch;\
tar xzf OAuth.tar.gz;\
tar xzf Elastica.tar.gz;\
tar xzf CirrusSearch.tar.gz;\
tar xzf WikibaseImport.tar.gz

FROM composer as composer
COPY --from=fetcher /WikibaseImport-master /WikibaseImport
WORKDIR /WikibaseImport
RUN composer install --no-dev
COPY --from=fetcher /Elastica /Elastica
WORKDIR /Elastica
RUN composer install --no-dev

FROM wikibase/wikibase:1.30
COPY --from=fetcher /OAuth /var/www/html/extensions/OAuth
COPY --from=composer /Elastica /var/www/html/extensions/Elastica
COPY --from=fetcher /CirrusSearch /var/www/html/extensions/CirrusSearch
COPY --from=composer /WikibaseImport /var/www/html/extensions/WikibaseImport
COPY LocalSettings.php.wikibase-bundle.template /LocalSettings.php.wikibase-bundle.template
COPY extra-install.sh /
COPY extra-entrypoint-run-first.sh /
RUN cat /LocalSettings.php.wikibase-bundle.template >> /LocalSettings.php.template && rm /LocalSettings.php.wikibase-bundle.template
