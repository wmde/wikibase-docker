#!/usr/bin/env bash

#https://graysonkoonce.com/getting-the-current-branch-name-during-a-pull-request-in-travis-ci
export BRANCH=$(if [ "$TRAVIS_PULL_REQUEST" == "false" ]; then echo $TRAVIS_BRANCH; else echo $TRAVIS_PULL_REQUEST_BRANCH; fi)

if [ "$BRANCH" == "master" ]; then
    echo "This commit has been merged to master so on success images will be pushed"
    export SHOULD_DOCKER_PUSH=true
else
    echo "This is branch: $BRANCH so we won't be pushing"
fi

if [ "$SHOULD_DOCKER_PUSH" = true ]; then
echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
fi
