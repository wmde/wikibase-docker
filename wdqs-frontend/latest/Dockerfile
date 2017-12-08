FROM ubuntu as fetcher

RUN apt-get update && \
    apt-get install --yes --no-install-recommends unzip

ADD https://github.com/wikimedia/wikidata-query-gui/archive/master.zip ./master.zip

# Creates /wikidata-query-gui-master
RUN unzip master.zip && rm master.zip


FROM nginx:stable-alpine

COPY --from=fetcher /wikidata-query-gui-master /tmp/wikidata-query-gui-master

# Put wdqs gui in the right place
RUN set -x; \
    apk --update add --virtual build-dependencies ca-certificates git nodejs jq \
    && cd /tmp/wikidata-query-gui-master \
    && mv package.json package.json.orig \
    && cat package.json.orig \
        | jq 'delpaths([["devDependencies","karma-qunit"],["devDependencies","qunitjs"],["devDependencies","sinon"]])' \
        > package.json \
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
    BRAND_TITLE=DockerWikibaseQueryService\
    WIKIBASE_HOST="wikibase.svc"\
    WDQS_HOST="wdqs-proxy.svc"

ENTRYPOINT ["/entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]