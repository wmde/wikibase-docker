## wdqs-proxy docker image

Proxy to put infrom of the wdqs image enforcing READONLY requests query timeouts.

Automated build.

## Tags

Image name                      | Parent image             | WDQS UI Version
------------------------------- | ------------------------ | --------------
`wikibase/wdqs-proxy:latest`    | [nginx:stable-alpine](https://hub.docker.com/_/nginx/) | master


## Environment variables

NOTE TODO XXX: PROXY_PASS_HOST is currently provided by the nginx image and 
we should probably instead use WDQS_HOST and WDQS_PORT and set PROXY_PASS_HOST ourselves.

Variable          | Default                      | Description
------------------|  ----------------------------| ----------
`PROXY_PASS_HOST` | "wdqs.svc:9999"              | Language to use in the UI (default)