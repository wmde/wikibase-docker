FROM ubuntu as fetcher

RUN apt-get update && \
    apt-get install --yes --no-install-recommends unzip

ADD https://github.com/wikimedia/mediawiki-extensions-Wikibase/archive/REL1_29.zip .

# Creates /mediawiki-extensions-Wikibase-REL1_29
RUN unzip REL1_29.zip && rm *.zip


FROM composer as composer

COPY --from=fetcher /mediawiki-extensions-Wikibase-REL1_29 /Wikibase

RUN cd /Wikibase && composer install --no-dev


FROM mediawiki:1.29

# Install envsubst
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install --yes --no-install-recommends gettext-base && \
    rm -rf /var/lib/apt/lists/*

RUN a2enmod rewrite

RUN install -d /var/log/mediawiki -o www-data

COPY --from=composer /Wikibase /var/www/html/extensions/Wikibase
COPY wait-for-it.sh /wait-for-it.sh
COPY entrypoint.sh /entrypoint.sh
COPY LocalSettings.php.template /LocalSettings.php.template
COPY htaccess /var/www/html/.htaccess

RUN ln -s /var/www/html/ /var/www/html/w

ENV DB_SERVER=mysql.svc:3306\
    DB_USER=wikiuser\
    DB_PASS=sqlpass\
    DB_NAME=my_wiki\
    MW_SITE_NAME=wikibase-docker\
    MW_SITE_LANG=en\
    MW_ADMIN_NAME=admin\
    MW_ADMIN_PASS=adminpass

ENTRYPOINT ["/bin/sh"]
CMD ["/entrypoint.sh"]