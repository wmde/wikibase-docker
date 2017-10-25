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

EXPOSE 9999

#TODO change foobar to the env var?
#TODO run from the snapshpot extracted zip file scripts?
WORKDIR "/wikidata-query-rdf/"
CMD ["mvn", "-DargLine=\"-DwikibaseHost=$WIKIBASE_HOSTNAME\"", "-pl", "tools", "jetty:run"]