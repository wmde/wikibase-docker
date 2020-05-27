## wikibase elasticsearch image

Wikibase needs the extra plugin for elasticsearch from here:

https://mvnrepository.com/artifact/org.wikimedia.search/extra/6.5.4

Image name                              | Parent image             
--------------------------------------- | ------------------------ 
`wikibase/elasticsearch` : `6.5.4-extra`, `latest`     | [elasticsearch:6.5.4](https://hub.docker.com/_/elasticsearch/)
`wikibase/elasticsearch` : `5.6.14-extra`              | [elasticsearch:5.6.14](https://hub.docker.com/_/elasticsearch/)

### Development

New versions of this image should be created alongside new versions of elasticsearch that are used in production for Wikidata.

The versions required for this image can generally be seen under the dependencies of the [CirrusSearch extension](https://www.mediawiki.org/wiki/Extension:CirrusSearch).

You can find the plugin versions that can be used at https://mvnrepository.com/artifact/org.wikimedia.search/extra-common

The elasticsearch version and versions of plugins should match for new images.

The process is generally:
 - Create a new directory using a previous one as an example
 - Update the Dockerfile to use the newer version of elasticsearch and extensions
 - Update the CI build by checking the steps in the main README Development section in this repo.
