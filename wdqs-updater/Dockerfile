FROM wikibase/wdqs

RUN set -x; \
    apk --update add bash

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/bin/sh", "/runUpdate.sh"]