FROM ubuntu as fetcher

RUN apt-get update && \
    apt-get install --yes --no-install-recommends ca-certificates wget unzip

# Creates /wikidata-query-deploy
RUN wget http://search.maven.org/remotecontent?filepath=org/wikidata/query/rdf/service/0.2.5/service-0.2.5-dist.zip \
    && unzip *.zip \
    && rm *.zip


FROM openjdk:8-jdk-alpine

# Blazegraph scripts require bash
# Install gettext for envsubst command, (it needs libintl package)
RUN set -x; \
    apk --update add bash gettext libintl

COPY --from=fetcher /service-0.2.5 /wdqs

# Don't set a memory limit otherwise bad things happen (OOMs)
ENV MEMORY=""\
    HEAP_SIZE="1g"\
    HOST="0.0.0.0"\
    WIKIBASE_HOST="wikibase.svc"

EXPOSE 9999

WORKDIR "/wdqs/"

COPY entrypoint.sh /entrypoint.sh
COPY mwservices.json /templates/mwservices.json
COPY RWStore.properties /wdqs/RWStore.properties
COPY whitelist.txt /wdqs/whitelist.txt

ENTRYPOINT ["/entrypoint.sh"]