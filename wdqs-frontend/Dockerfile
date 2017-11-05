FROM nginx:stable-alpine

# Fetch the wdqs gui
RUN set -x; \
    apk --update add --virtual build-dependencies wget unzip ca-certificates \
    && wget -O /tmp/code.zip https://github.com/wikimedia/wikidata-query-gui/archive/master.zip \
    && unzip /tmp/code.zip -d /tmp \
    && rm /tmp/code.zip \
    && apk del build-dependencies

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
COPY config.js /usr/share/nginx/html/wikibase/config.js
COPY default.conf /etc/nginx/conf.d/default.conf

ENTRYPOINT ["/entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]