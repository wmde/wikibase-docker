FROM wdqs

RUN set -x; \
    apk --update add bash

RUN cd /tmp/wikidata-query-rdf/dist/target \
    && unzip service-0.2.5-SNAPSHOT-dist.zip \
    && rm service-0.2.5-SNAPSHOT-dist.zip

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/bin/sh", "/runUpdate.sh"]