## wdqs-proxy docker image

Proxy to put infront of the wdqs image enforcing READONLY requests query timeouts.

In order to change how this image is configured just mount over the wdqs.template file.

Automated build.

## Tags

Image name                          | Parent image             | WDQS UI Version
-------------------------------     | ------------------------ | --------------
`wikibase/wdqs-proxy` : `latest`    | [nginx:stable-alpine](https://hub.docker.com/_/nginx/) | master


## Environment variables

NOTE TODO XXX: PROXY_PASS_HOST is currently provided by the nginx image and 
we should probably instead use WDQS_HOST and WDQS_PORT and set PROXY_PASS_HOST ourselves.

Variable          | Default                      | Description
------------------|  ----------------------------| ----------
`PROXY_PASS_HOST` | "wdqs.svc:9999"              | Where to forward the requests to


### Filesystem layout

File                               | Description
---------------------------------  | ------------------------------------------------------------------------------
`/etc/nginx/conf.d/wdqs.template`  | Template for the nginx config (substituted to `/etc/nginx/conf.d/default.conf` at runtime)
`/etc/nginx/conf.d/default.conf`   | nginx config. To override this you must also use a custom entrypoint to avoid the file being overwritten.

### Development

This image is based directly on the nginx latest image, thus new images are not needed for new releases.

However if the latest image goes through a major version bump that renders our configuration broken we may need to create a new image.
