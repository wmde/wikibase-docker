FROM ubuntu:xenial as fetcher

RUN apt-get update && \
    apt-get install --yes --no-install-recommends unzip=6.* && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

ADD https://github.com/wikimedia/wikidata-query-gui/archive/master.zip ./master.zip

# Creates /wikidata-query-gui-master
RUN unzip master.zip && rm master.zip


# TODO this should probably just be a node image?
FROM nginx:stable-alpine as builder

COPY --from=fetcher /wikidata-query-gui-master /tmp/wikidata-query-gui-master

WORKDIR /tmp/wikidata-query-gui-master

# Put wdqs gui in the right place
RUN apk --no-cache add --virtual build-dependencies ca-certificates~=20191127-r2 git~=2.24 nodejs~=12 npm~=12 jq~=1.6 python~=2.7 make~=4.2 g++~=9.3

# TODO do npm build instead of leaving any dev node modules hanging around
RUN mv package.json package.json.orig \
    && jq 'delpaths([["devDependencies","karma-qunit"],["devDependencies","qunitjs"],["devDependencies","sinon"]])' \
        > package.json < package.json.orig \
    && jq 'setpath(["devDependencies","less"]; "~2.7.1")' \
        > package.json < package.json.orig \
    && npm install


FROM nginx:stable-alpine as final

WORKDIR /usr/share/nginx/html

COPY --from=builder /tmp/wikidata-query-gui-master /usr/share/nginx/html
RUN echo "" > style.css
COPY entrypoint.sh /entrypoint.sh
COPY custom-config.json /templates/custom-config.json
COPY default.conf /templates/default.conf

ENV LANGUAGE=en\
    BRAND_TITLE=DockerWikibaseQueryService\
    COPYRIGHT_URL=undefined

ENTRYPOINT ["/entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
