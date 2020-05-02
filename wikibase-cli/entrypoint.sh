#!/usr/bin/env sh
envsubst < /config.json > /wikibase-cli/local/config.json
wb "$@" < /dev/stdin
