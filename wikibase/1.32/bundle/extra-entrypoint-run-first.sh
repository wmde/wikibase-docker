#!/usr/bin/env bash

/wait-for-it.sh $MW_ELASTIC_HOST:$MW_ELASTIC_PORT -t 300
