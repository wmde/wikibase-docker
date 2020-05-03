# wikibase-cli docker image

[wikibase-cli](https://www.wikidata.org/wiki/Wikidata:Tools/WikibaseJS-cli) is a generalist command-line interface to Wikibase: it can do all sorts of [read](https://github.com/maxlath/wikibase-cli/blob/master/docs/read_operations.md) and [write](https://github.com/maxlath/wikibase-cli/blob/master/docs/write_operations.md) operations, including [importing](https://github.com/maxlath/wikibase-cli/blob/master/docs/write_operations.md#batch-mode) and [exporting](https://github.com/maxlath/wikibase-cli/blob/master/docs/read_operations.md#wb-data) large batches of data.

The version installed by [this repo `docker-compose.yml`](https://github.com/wmde/wikibase-docker/blob/master/docker-compose.yml) is `maxlath/wikibase-cli:latest-wikibase-docker` (build from this [Dockerfile](https://github.com/wmde/wikibase-docker/blob/master/wikibase-cli/Dockerfile)).

## Setup
Those variables can be customized in `docker-compose.yml`

Variable                                                                           | Description
---------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------
`WB_HOST`                                                                          | Wikibase instance host
`WB_USERNAME`, `WB_PASSWORD`                                                       | The username and password of the user that should be used to edit Wikibase (will be ignored if OAuth tokens are set)
`OAUTH_CONSUMER_KEY`, `OAUTH_CONSUMER_SECRET`, `OAUTH_TOKEN`, `OAUTH_TOKEN_SECRET` | OAuth tokens
`WDQS_HOST`                                                                        | Query Service host. **Optional**: only required for read commands such as `wb sparql`, `wb query`, and `wb convert`

## How-to
Everywhere the [documentation](https://github.com/maxlath/wikibase-cli#summary) refers to `wb`, you can substitute `docker-compose exec wikibase-cli wb`
```sh
# Creating an alias in the current terminal
alias wb="docker-compose exec wikibase-cli wb"

# List the available commands
wb --help

# Create an item
wb create-entity '{ "labels": { "en": "some item label" } }'

# Create a propery
wb create-entity '{ "datataype": "string", "labels": { "en": "some property label" } }'

# Find those entities
wb search 'some item label'
wb search 'some property label' --type property

# Get those entities data
wb data Q1 P1
```

Unfortunately, for commands that can take arguments on stdin, you can't use `docker-compose exec` as it will return an error: `the input device is not a TTY`. This can be worked around, by using the `docker exec` command which has an interactive (`-i`) mode:
```sh
CONTAINER_ID=$(docker ps | grep wikibase-cli | awk '{print $1}')
alias wb="docker exec $CONTAINER_ID wikibase-cli wb"
# OR as a one-liner
alias wb="docker exec $(docker ps | grep wikibase-cli | awk '{print $1}') wikibase-cli wb"

# Create many entities
cat ./demo/data.ndjson | wb create-entity --batch

# Get the simplified data from entities found by a SPARQL query
wb sparql ./demo/items_with_P1_and_P2_claims.rq | wb data --simplify > items_with_P1_and_P2_claims.ndjson
```

**NB**: If you do a lot of small operations, directly [installing](https://github.com/maxlath/wikibase-cli#installation) wikibase-cli on your host machine could give you some performance gains, as it removes the need to interact with a container (which might cost something like 300ms per command). But to do that you need to setup the [configuration](https://github.com/maxlath/wikibase-cli/blob/master/docs/config.md#config) yourself.

### Issues
After having looked for any pre-existing case, you are welcome to open issues on [`wikibase-cli` main repo](https://github.com/maxlath/wikibase-cli/issues). Please make sure to mention that you are using wikibase-cli within this docker setup.
