FROM wikibase/wdqs

RUN chmod +x /wikidata-query-rdf/dist/target/service-0.3.0-SNAPSHOT/runUpdate.sh

COPY wait-for-it.sh /wait-for-it.sh
COPY entrypoint.sh /entrypoint.sh

ENV UPDATER_OPTS="-DwikibaseHost=wikibase"

CMD ["/entrypoint.sh"]