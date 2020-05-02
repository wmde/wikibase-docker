FROM node:12-alpine

# Dependencies:
# - gettext: installs envsubst
RUN apk add gettext && \
  npm install --global --production "wikibase-cli@latest" && \
  ln -s /usr/local/lib/node_modules/wikibase-cli /wikibase-cli && \
  mkdir -p /wikibase-cli/local

COPY entrypoint.sh /entrypoint.sh
COPY config.json /config.json

ENTRYPOINT [ "/entrypoint.sh" ]
