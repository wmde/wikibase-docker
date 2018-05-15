FROM ubuntu as fetcher

RUN apt-get update && \
    apt-get install --yes --no-install-recommends unzip jq curl ca-certificates
ADD download-extension.sh .
RUN bash download-extension.sh OAuth
RUN tar xzf OAuth.tar.gz && rm *.tar.gz
ADD https://github.com/filbertkm/WikibaseImport/archive/master.tar.gz /WikibaseImport.tar.gz
RUN tar xzf WikibaseImport.tar.gz


FROM composer as composer
COPY --from=fetcher /WikibaseImport-master /WikibaseImport
RUN cd /WikibaseImport && composer install --no-dev

FROM wikibase/wikibase:1.30
COPY --from=fetcher /OAuth /var/www/html/extensions/OAuth
COPY --from=composer /WikibaseImport /var/www/html/extensions/WikibaseImport
COPY LocalSettings.php.wikibase-bundle.template /LocalSettings.php.wikibase-bundle.template
RUN cat /LocalSettings.php.wikibase-bundle.template >> /LocalSettings.php.template && rm /LocalSettings.php.wikibase-bundle.template
