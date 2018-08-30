FROM ubuntu:xenial as fetcher

# hadolint ignore=DL3009
RUN apt-get update && apt-get install --yes --no-install-recommends unzip=6.*

ADD https://archiva.wikimedia.org/repository/snapshots/org/wikidata/query/rdf/service/0.2.5-SNAPSHOT/service-0.2.5-SNAPSHOT-dist.zip ./service-dist.zip

RUN unzip service-dist.zip && rm service-dist.zip


FROM openjdk:8-jdk-alpine

# Blazegraph scripts require bash
# Install gettext for envsubst command, (it needs libintl package)
RUN set -x ; \
    apk --no-cache add bash~=4.4.19-r1 gettext~=0.19.8.1-r1 libintl~=0.19.8.1-r1

COPY --from=fetcher /service-0.2.5-SNAPSHOT /wdqs

# Don't set a memory limit otherwise bad things happen (OOMs)
ENV MEMORY=""\
    HEAP_SIZE="1g"\
    HOST="0.0.0.0"\
    WDQS_ENTITY_NAMESPACES="120,122"\
    WIKIBASE_SCHEME="http"

WORKDIR /wdqs

COPY wait-for-it.sh /wait-for-it.sh
COPY entrypoint.sh /entrypoint.sh
COPY runBlazegraph.sh /runBlazegraph.sh
COPY runUpdate.sh /runUpdate.sh
COPY mwservices.json /templates/mwservices.json
COPY RWStore.properties /wdqs/RWStore.properties
COPY whitelist.txt /wdqs/whitelist.txt

# TODO is this actually needed?
RUN chmod +x /wdqs/runUpdate.sh

ENTRYPOINT ["/entrypoint.sh"]
