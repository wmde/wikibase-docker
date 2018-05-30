#!/bin/bash

docker pull gcr.io/gcp-runtimes/container-structure-test:latest

docker run --rm -i -v /var/run/docker.sock:/var/run/docker.sock \
-v $DIR:/tests \
gcr.io/gcp-runtimes/container-structure-test:latest \
test --image wikibase/wikibase:1.30-bundle --config /tests/bundle_test_config.yaml