FROM ubuntu:xenial as fetcher

RUN apt-get update && \
    apt-get install --yes --no-install-recommends git=1:2.* ca-certificates=201* && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN git clone https://phabricator.wikimedia.org/source/tool-quickstatements.git quickstatements
RUN git clone --depth 1 https://bitbucket.org/magnusmanske/magnustools.git magnustools

RUN rm -rf quickstatements/.git
RUN rm -rf magnustools/.git

FROM composer:1 as composer

COPY --from=fetcher /quickstatements /quickstatements

WORKDIR /quickstatements
RUN composer install --no-dev

FROM php:7.2-apache

# Install envsubst
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install --yes --no-install-recommends gettext-base=0.19.* jq=1.5* && \
    rm -rf /var/lib/apt/lists/*

COPY --from=composer /quickstatements /var/www/html/quickstatements
COPY --from=fetcher /magnustools /var/www/html/magnustools

COPY entrypoint.sh /entrypoint.sh

COPY config.json /templates/config.json
COPY oauth.ini /templates/oauth.ini
COPY php.ini /templates/php.ini

ENV APACHE_DOCUMENT_ROOT /var/www/html/quickstatements/public_html
RUN sed -ri -e "s!/var/www/html!${APACHE_DOCUMENT_ROOT}!g" /etc/apache2/sites-available/*.conf
RUN sed -ri -e "s!/var/www/!${APACHE_DOCUMENT_ROOT}!g" /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

ENV MW_SITE_NAME=wikibase-docker\
    MW_SITE_LANG=en\
    PHP_TIMEZONE=UTC

RUN install -d -owww-data /var/log/quickstatements

ENTRYPOINT ["/bin/bash"]
CMD ["/entrypoint.sh"]
