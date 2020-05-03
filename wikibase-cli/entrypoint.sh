#!/usr/bin/env bash
log_success(){
  echo -e "\e[0;32m$1\e[0;0m $2"
}

log_error(){
  echo -e "\e[0;31m$1\e[0;0m $2"
}

log_missing(){
  log_error "missing environment variable:" $1
}

if [[ "$WB_HOST" == "" ]] ; then
  log_missing "WB_HOST"
  exit 1
fi

if [[ "$OAUTH_CONSUMER_KEY" != "" && "$OAUTH_CONSUMER_SECRET" != "" && "$OAUTH_TOKEN" != "" && "$OAUTH_TOKEN_SECRET" != "" ]] ; then
  envsubst < /config.oauth.json > /wikibase-cli/local/config.json
elif [[ "$WB_USERNAME" != "" && "$WB_PASSWORD" != "" ]]; then
  envsubst < /config.username-password.json > /wikibase-cli/local/config.json
else
  if [[ "$OAUTH_CONSUMER_KEY" != "" || "$OAUTH_CONSUMER_SECRET" != "" || "$OAUTH_TOKEN" != "" || "$OAUTH_TOKEN_SECRET" != "" ]] ; then
    [[ "$OAUTH_CONSUMER_KEY" == "" ]] && log_missing "OAUTH_CONSUMER_KEY"
    [[ "$OAUTH_CONSUMER_SECRET" == "" ]] && log_missing "OAUTH_CONSUMER_SECRET"
    [[ "$OAUTH_TOKEN" == "" ]] && log_missing "OAUTH_TOKEN"
    [[ "$OAUTH_TOKEN_SECRET" == "" ]] && log_missing "OAUTH_TOKEN_SECRET"
  elif [[ "$WB_USERNAME" != "" ]]; then log_missing "WB_PASSWORD"
  elif [[ "$WB_PASSWORD" != "" ]]; then log_missing "WB_USERNAME"
  else log_error "credentials not found"
  fi
  exit 1
fi

wb config credentials "$WB_HOST" test > /dev/null && {
  log_success "$WB_HOST credentials are correctly configured"
} || {
  log_error "invalid credentials"
  exit 1
}

wb "$@" < /dev/stdin
