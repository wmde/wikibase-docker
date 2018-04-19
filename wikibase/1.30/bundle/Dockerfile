FROM ubuntu as fetcher

RUN apt-get update && \
    apt-get install --yes --no-install-recommends unzip

ADD https://extdist.wmflabs.org/dist/extensions/OAuth-REL1_30-352260e.tar.gz .

# Creates /mediawiki-extensions-Wikibase-REL1_30
RUN tar xzf OAuth-REL1_30-352260e.tar.gz && rm *.tar.gz


FROM wikibase/wikibase:1.30

COPY --from=fetcher /OAuth /var/www/html/extensions/OAuth

COPY LocalSettings.php.template /LocalSettings.php.template
