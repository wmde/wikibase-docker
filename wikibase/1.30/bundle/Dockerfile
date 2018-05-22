FROM ubuntu as fetcher

RUN apt-get update && \
    apt-get install --yes --no-install-recommends unzip=6.0-20ubuntu1 jq=1.5+dfsg-1 curl=7.47.0-1ubuntu2.8 ca-certificates=20170717~16.04.1
COPY download-extension.sh .
RUN bash download-extension.sh OAuth
RUN tar xzf OAuth.tar.gz && rm ./*.tar.gz
ADD https://github.com/filbertkm/WikibaseImport/archive/master.tar.gz /WikibaseImport.tar.gz
RUN tar xzf WikibaseImport.tar.gz

FROM composer as composer
COPY --from=fetcher /WikibaseImport-master /WikibaseImport
WORKDIR /WikibaseImport
RUN composer install --no-dev

FROM wikibase/wikibase:1.30
COPY --from=fetcher /OAuth /var/www/html/extensions/OAuth
COPY --from=composer /WikibaseImport /var/www/html/extensions/WikibaseImport
COPY LocalSettings.php.wikibase-bundle.template /LocalSettings.php.wikibase-bundle.template
RUN cat /LocalSettings.php.wikibase-bundle.template >> /LocalSettings.php.template && rm /LocalSettings.php.wikibase-bundle.template
