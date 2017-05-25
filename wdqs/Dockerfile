FROM openjdk:8-jdk-alpine

RUN set -x; \
    apk --update add --virtual build-dependencies git \
    && apk --update add ca-certificates maven \
    && git clone https://github.com/wikimedia/wikidata-query-rdf.git /tmp/wikidata-query-rdf --depth 1 \
    && cd /tmp/wikidata-query-rdf/ \
    && mvn install -DskipTests=true \
    && mvn sortpom:sort \
    && apk del build-dependencies
#TODO delete ~/.m2
#TODO Move out of tmp....

EXPOSE 9999

#TODO change foobar to the env var?
WORKDIR "/tmp/wikidata-query-rdf/"
CMD ["mvn", "-DargLine=\"-DwikibaseHost=$WIKIBASE_HOSTNAME\"", "-pl", "tools", "jetty:run"]