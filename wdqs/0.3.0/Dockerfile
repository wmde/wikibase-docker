FROM ubuntu as fetcher

RUN apt-get update && \
    apt-get install --yes --no-install-recommends unzip

ADD https://search.maven.org/remotecontent?filepath=org/wikidata/query/rdf/service/0.3.0/service-0.3.0-dist.zip ./service-dist.zip

# Creates /wikidata-query-deploy
RUN unzip service-dist.zip && rm service-dist.zip


FROM openjdk:8-jdk-alpine

# Blazegraph scripts require bash
# Install gettext for envsubst command, (it needs libintl package)
RUN set -x; \
    apk --update add bash gettext libintl

COPY --from=fetcher /service-0.3.0 /wdqs

# Don't set a memory limit otherwise bad things happen (OOMs)
ENV MEMORY=""\
    HEAP_SIZE="1g"\
    HOST="0.0.0.0"\
    WIKIBASE_HOST="wikibase.svc"\
    WDQS_HOST="wdqs.svc"\
    WDQS_PORT="9999"\
    WDQS_ENTITY_NAMESPACES="120,122"\
    WIKIBASE_SCHEME="http"

EXPOSE $WDQS_PORT

WORKDIR "/wdqs/"

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