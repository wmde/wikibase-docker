FROM wikibase/wdqs

RUN chmod +x /wikidata-query-rdf/dist/target/service-0.3.0-SNAPSHOT/runUpdate.sh

COPY wait-for-it.sh /wait-for-it.sh
COPY entrypoint.sh /entrypoint.sh

#ENV UPDATER_OPTS="--wikibaseHost wikibase"

RUN sed -i 's/#!\/usr\/bin\/env bash/#!\/usr\/bin\/env bash\nset -x/' /wikidata-query-rdf/dist/target/service-0.3.0-SNAPSHOT/runUpdate.sh

ENV UPDATER_OPTS="-DwikibaseHost=wikibase"

CMD ["/entrypoint.sh"]