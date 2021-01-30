FROM ubuntu:xenial as fetcher

COPY download-extension.sh .
RUN apt-get update && \
    apt-get install --yes --no-install-recommends unzip=6.* jq=1.* curl=7.* ca-certificates=201* && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN bash download-extension.sh Wikibase;\
tar xzf Wikibase.tar.gz;


FROM mediawiki:1.31 as collector
COPY --from=fetcher /Wikibase /var/www/html/extensions/Wikibase


FROM composer@sha256:d374b2e1f715621e9d9929575d6b35b11cf4a6dc237d4a08f2e6d1611f534675 as composer
COPY --from=collector /var/www/html /var/www/html
WORKDIR /var/www/html/
COPY composer.local.json /var/www/html/composer.local.json
RUN composer install --no-dev


FROM mediawiki:1.31

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install --yes --no-install-recommends libbz2-dev=1.* gettext-base=0.19.* && \
    rm -rf /var/lib/apt/lists/*

RUN a2enmod rewrite

RUN install -d /var/log/mediawiki -o www-data

RUN docker-php-ext-install calendar bz2

COPY --from=composer /var/www/html /var/www/html
COPY wait-for-it.sh /wait-for-it.sh
COPY entrypoint.sh /entrypoint.sh
COPY LocalSettings.php.template /LocalSettings.php.template
COPY htaccess /var/www/html/.htaccess

RUN ln -s /var/www/html/ /var/www/html/w

ENV MW_SITE_NAME=wikibase-docker\
    MW_SITE_LANG=en

ENTRYPOINT ["/bin/bash"]
CMD ["/entrypoint.sh"]
