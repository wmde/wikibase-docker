FROM ubuntu as fetcher

RUN apt-get update && \
    apt-get install --yes --no-install-recommends ca-certificates wget unzip

# Creates /mediawiki-extensions-Wikibase-REL1_29
RUN wget https://github.com/wikimedia/mediawiki-extensions-Wikibase/archive/REL1_29.zip &&\
    unzip REL1_29.zip


FROM composer as composer

COPY --from=fetcher /mediawiki-extensions-Wikibase-REL1_29 /Wikibase

RUN cd /Wikibase && composer install --no-dev


FROM mediawiki:1.29

COPY --from=composer /Wikibase /var/www/html/extensions/Wikibase
COPY wait-for-it.sh /wait-for-it.sh
COPY entrypoint.sh /entrypoint.sh
COPY LocalSettings.php /LocalSettings.php

ENTRYPOINT ["/bin/sh"]
CMD ["/entrypoint.sh"]