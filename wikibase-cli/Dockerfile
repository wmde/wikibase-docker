FROM node:12-alpine

# Dependencies:
# - gettext: installs envsubst
RUN apk add gettext bash && \
  npm install --global --production "wikibase-cli@latest" && \
  ln -s /usr/local/lib/node_modules/wikibase-cli /wikibase-cli && \
  mkdir -p /wikibase-cli/local

COPY entrypoint.sh /entrypoint.sh
COPY config.username-password.json /config.username-password.json
COPY config.oauth.json /config.oauth.json

ENTRYPOINT [ "/entrypoint.sh" ]
