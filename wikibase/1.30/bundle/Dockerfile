FROM ubuntu as fetcher

RUN apt-get update && \
    apt-get install --yes --no-install-recommends unzip jq curl ca-certificates
ADD download-extension.sh .
RUN bash download-extension.sh OAuth
RUN tar xzf OAuth.tar.gz && rm *.tar.gz

FROM wikibase/wikibase:1.30
COPY --from=fetcher /OAuth /var/www/html/extensions/OAuth
COPY LocalSettings.php.wikibase-bundle.template /LocalSettings.php.wikibase-bundle.template
RUN cat /LocalSettings.php.wikibase-bundle.template >> /LocalSettings.php.template && rm /LocalSettings.php.wikibase-bundle.template
