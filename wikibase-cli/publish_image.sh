#!/usr/bin/env bash
if [[ -z ./Dockerfile || $(basename $PWD) != "wikibase-cli" ]] ; then
  echo 'this script should be run from wikibase-docker/wikibase-cli directory'
  exit 1
fi

version=$(npm info wikibase-cli --json | jq '.version' -cr)
docker build -t wikibase-cli .
docker tag wikibase-cli "maxlath/wikibase-cli:v${version}-wikibase-docker"
docker push "maxlath/wikibase-cli:v${version}-wikibase-docker"
docker tag wikibase-cli maxlath/wikibase-cli:latest-wikibase-docker
docker push maxlath/wikibase-cli:latest-wikibase-docker
