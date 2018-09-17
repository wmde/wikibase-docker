FROM ubuntu:xenial as fetcher

RUN apt-get update && \
    apt-get install --yes --no-install-recommends unzip=6.* && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

ADD https://github.com/wikimedia/mediawiki-extensions-Wikibase/archive/REL1_30.zip .

# Creates /mediawiki-extensions-Wikibase-REL1_30
RUN unzip REL1_30.zip && rm ./*.zip


FROM composer as composer

COPY --from=fetcher /mediawiki-extensions-Wikibase-REL1_30 /Wikibase

WORKDIR /Wikibase
RUN composer install --no-dev


FROM mediawiki:1.30

# Install envsubst
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install --yes --no-install-recommends gettext-base=0.19.* && \
    rm -rf /var/lib/apt/lists/*

RUN a2enmod rewrite

RUN install -d /var/log/mediawiki -o www-data

RUN docker-php-ext-install calendar

COPY --from=composer /Wikibase /var/www/html/extensions/Wikibase
COPY wait-for-it.sh /wait-for-it.sh
COPY entrypoint.sh /entrypoint.sh
COPY LocalSettings.php.template /LocalSettings.php.template
COPY htaccess /var/www/html/.htaccess

RUN ln -s /var/www/html/ /var/www/html/w

ENV MW_SITE_NAME=wikibase-docker\
    MW_SITE_LANG=en

ENTRYPOINT ["/bin/bash"]
CMD ["/entrypoint.sh"]
