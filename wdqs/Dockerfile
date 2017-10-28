FROM openjdk:8-jdk-alpine as builder

RUN set -x; \
    apk --update add --virtual build-dependencies git \
    && apk --update add ca-certificates maven

RUN git clone https://github.com/wikimedia/wikidata-query-rdf.git /wikidata-query-rdf --depth 1
RUN cd /wikidata-query-rdf/ && mvn install -DskipTests=true
RUN cd /wikidata-query-rdf/ && mvn sortpom:sort

RUN cd /wikidata-query-rdf/dist/target \
    && unzip service-0.3.0-SNAPSHOT-dist.zip \
    && rm service-0.3.0-SNAPSHOT-dist.zip

FROM openjdk:8-jdk-alpine

RUN set -x; \
    apk --update add bash

COPY --from=builder /wikidata-query-rdf /wikidata-query-rdf

# Don't set a memory limit otherwise bad things happen (OOMs)
ENV MEMORY=""
ENV HEAP_SIZE="1g"
ENV HOST="0.0.0.0"
ENV BLAZEGRAPH_OPTS="-DwikibaseHost=wikibase"

EXPOSE 9999

WORKDIR "/wikidata-query-rdf/dist/target/service-0.3.0-SNAPSHOT/"

COPY mwservices.json /wikidata-query-rdf/dist/target/service-0.3.0-SNAPSHOT/mwservices.json

CMD ["./runBlazegraph.sh"]