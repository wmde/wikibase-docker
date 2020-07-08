FROM ubuntu:xenial as fetcher

RUN apt-get update && \
    apt-get install --yes --no-install-recommends unzip=6.* && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

ADD https://archiva.wikimedia.org/repository/releases/org/wikidata/query/rdf/service/0.3.40/service-0.3.40-dist.tar.gz ./service-dist.tar.gz

RUN tar xfv service-dist.tar.gz && rm service-dist.tar.gz

FROM openjdk:8-jdk-alpine

# Blazegraph scripts require bash
# Install gettext for envsubst command, (it needs libintl package)
# Install curl for the loadData.sh wdqs script (if someone needs it)
RUN set -x ; \
    apk --no-cache add bash=\<4.5.0 gettext=\<0.19.8.2 libintl=\<0.19.8.2 curl=\<7.64.999 su-exec=\~0.2

RUN addgroup -g 66 -S blazegraph
RUN adduser -S -G blazegraph -u 666 -s /bin/bash blazegraph

COPY --from=fetcher --chown=blazegraph:blazegraph /service-0.3.40 /wdqs

RUN mkdir /var/log/wdqs && chown blazegraph /var/log/wdqs

# Don't set a memory limit otherwise bad things happen (OOMs)
ENV MEMORY=""\
    HEAP_SIZE="1g"\
    HOST="0.0.0.0"\
    WDQS_ENTITY_NAMESPACES="120,122"\
    WIKIBASE_SCHEME="http"\
    WIKIBASE_MAX_DAYS_BACK="90"

WORKDIR /wdqs

COPY --chown=blazegraph:blazegraph wait-for-it.sh entrypoint.sh runBlazegraph.sh runUpdate.sh /
COPY --chown=blazegraph:blazegraph mwservices.json /templates/mwservices.json
COPY --chown=blazegraph:blazegraph RWStore.properties whitelist.txt /wdqs/

# TODO this shouldn't be needed, but CI currently doesnt check for the +x bit, which is why this line is here
RUN chmod +x /wdqs/runUpdate.sh

ENTRYPOINT ["/entrypoint.sh"]
