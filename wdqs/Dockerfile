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

COPY --from=builder /wikidata-query-rdf /wikidata-query-rdf

RUN sed -i 's/HEAP_SIZE=${HEAP_SIZE:-"16g"}/HEAP_SIZE=${HEAP_SIZE:-"2g"}/;s/HOST=${HOST:-"localhost"}/HOST="0.0.0.0"/' /wikidata-query-rdf/dist/target/service-0.3.0-SNAPSHOT/runBlazegraph.sh

EXPOSE 9999

WORKDIR "/wikidata-query-rdf/dist/target/service-0.3.0-SNAPSHOT/"
#TODO use bash
CMD ["sh", "./runBlazegraph.sh"]