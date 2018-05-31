FROM ubuntu:xenial as fetcher

RUN apt-get update && \
    apt-get install --yes --no-install-recommends unzip=6.0-20ubuntu1

ADD https://github.com/wikimedia/wikidata-query-gui/archive/master.zip ./master.zip

# Creates /wikidata-query-gui-master
RUN unzip master.zip && rm master.zip


FROM nginx:stable-alpine

COPY --from=fetcher /wikidata-query-gui-master /tmp/wikidata-query-gui-master

WORKDIR /tmp/wikidata-query-gui-master

# Put wdqs gui in the right place
RUN set -x ; \
    apk --no-cache add --virtual build-dependencies ca-certificates=20171114-r0 git=2.15.2-r0 nodejs=8.9.3-r1 jq=1.5-r5 \
    && mv package.json package.json.orig \
    && jq 'delpaths([["devDependencies","karma-qunit"],["devDependencies","qunitjs"],["devDependencies","sinon"]])' \
        > package.json < package.json.orig \
    && npm install \
    && rm -rf /usr/share/nginx/html \
    && mv /tmp/wikidata-query-gui-master /usr/share/nginx/html \
    && rm -rf /tmp/* \
    && rm -rf ~/.npm \
    && apk del build-dependencies

COPY entrypoint.sh /entrypoint.sh
COPY config.js /templates/config.js
COPY default.conf /templates/default.conf

ENV LANGUAGE=en\
    BRAND_TITLE=DockerWikibaseQueryService

ENTRYPOINT ["/entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]