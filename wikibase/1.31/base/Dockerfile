FROM wikibase/wikibase-common as common
FROM ubuntu:xenial as fetcher

RUN apt-get update && \
    apt-get install --yes --no-install-recommends unzip=6.* && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

ADD https://github.com/wikimedia/mediawiki-extensions-Wikibase/archive/REL1_31.zip .

# Creates /mediawiki-extensions-Wikibase-REL1_31
RUN unzip REL1_31.zip && rm ./*.zip


FROM composer as composer

COPY --from=fetcher /mediawiki-extensions-Wikibase-REL1_31 /Wikibase

WORKDIR /Wikibase
RUN composer install --no-dev


FROM mediawiki:1.31

# Install envsubst
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install --yes --no-install-recommends gettext-base=0.19.* && \
    rm -rf /var/lib/apt/lists/*

RUN a2enmod rewrite

RUN install -d /var/log/mediawiki -o www-data

RUN docker-php-ext-install calendar

COPY --from=composer /Wikibase /var/www/html/extensions/Wikibase
COPY --from=common /wait-for-it.sh /wait-for-it.sh
COPY --from=common /entrypoint.sh /entrypoint.sh
COPY --from=common /LocalSettings.php.template /LocalSettings.php.template
COPY --from=common /htaccess /var/www/html/.htaccess

RUN ln -s /var/www/html/ /var/www/html/w

ENV MW_SITE_NAME=wikibase-docker\
    MW_SITE_LANG=en

ENTRYPOINT ["/bin/bash"]
CMD ["/entrypoint.sh"]
