#!/usr/bin/env bash

#https://graysonkoonce.com/getting-the-current-branch-name-during-a-pull-request-in-travis-ci
export BRANCH=$(if [ "$TRAVIS_PULL_REQUEST" == "false" ]; then echo $TRAVIS_BRANCH; else echo $TRAVIS_PULL_REQUEST_BRANCH; fi)

if [ "$BRANCH" == "master" ]
then echo "This commit has been merged to master so on success images will be pushed" && docker login -u $DOCKER_USER -p $DOCKER_PASS
else echo "This is branch; $BRANCH so we won't be pushing"
fi
