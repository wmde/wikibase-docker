FROM wikibase/wdqs

RUN chmod +x /wdqs/runUpdate.sh

COPY wait-for-it.sh /wait-for-it.sh
COPY entrypoint.sh /entrypoint.sh

ENV UPDATER_OPTS="-DwikibaseHost=wikibase.svc"

CMD ["/entrypoint.sh"]