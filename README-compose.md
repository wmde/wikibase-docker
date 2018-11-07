## Installing a stand-alone Wikibase instance + SPARQL Query Service with Docker

This repository contains an EXAMPLE docker compose file that can be used with the images also contained in this repo. Following these instructions, you'll be able to install a stand-alone instance of Wikibase – the collaborative structured data engine behind [Wikidata](https://wikidata.org/) – as well as fully functional SPARQL endpoint and query service, complete with a data visualization frontend and query helper (similar to the [Wikidata Query Service](https://query.wikidata.org/)).

Individual documentation for each image used in this example can be found [here](https://github.com/wmde/wikibase-docker/blob/master/README.md).

**WARNING:** Currently this example requires 3GB+ of memory. If you are running Docker for Windows or Mac and have containers run within a VM (the default) make sure you set your VM memory allocation to 4GB. If you don't do this the query service may fail to run.

## Installing Docker and the Wikibase images

You'll need to install Docker, Docker Compose and clone images from this repository. For a single script to run that should work on a Wikimedia Toolforge (wmflabs) VM running Debian Jessie with 4GB memory, take a look at setup.sh in this repository.

#### 1) Install Docker (community edition) & Docker compose

 - https://docs.docker.com/engine/installation/
 - https://docs.docker.com/compose/install/

Note: Docker Compose is included in the Docker community edition, so most likely you won't need to install it separately.

#### 2) Copy the docker-compose.yml file

This file is only meant as an example, your modification might be needed.

```
wget https://raw.githubusercontent.com/wmde/wikibase-docker/master/docker-compose.yml
```

If you want to develop the Dockerfiles then you should clone this repo and instead use the docker-compose-build.yml file.

#### 3) Setting up and starting the containers

Note: In linux you must either be in the docker group or use SUDO!

**Pulling / updating the images**

```
docker-compose pull
```

**Starting the containers**

```
docker-compose up
```

**Quickstatements**
To set up quickstatements follow the instructions in the quickstatements [README](https://github.com/wmde/wikibase-docker/blob/master/quickstatements/README.md)

**Stopping the containers**

```
docker-compose stop
```

**Removing the containers**

```
docker-compose down
```

This will keep all data stored by MySQL, Mediawiki and the Query Service in Docker volumes.

**Removing both the containers and data**

**WARNING:** this will remove ALL of the data you had added to Wikibase and the Query Service.

```
docker-compose down --volumes
```

## Backing up data from Docker volumes

All data for Wikibase and the Query Service is stored in Docker volumes. You can create compressed copies of these volumes to use as backups or to hand off to other users.

You can see all Docker volumes created by using the following command:

```
docker volume ls | grep wikibasedocker
```

You can grab a zip of each volumes by doing the following:

```
docker run -v wikibasedocker_mediawiki-mysql-data:/volume -v /tmp/wikibase-data:/backup --rm loomchild/volume-backup backup mediawiki-mysql-data
```

You, or someone else, can then restore the volume by doing the following:

```
docker run -v wikibasedocker_mediawiki-mysql-data:/volume -v /tmp/wikibase-data:/backup --rm loomchild/volume-backup restore mediawiki-mysql-data
```

## Accessing your Wikibase instance and the Query Service UI

Access the following hosts:
 - [Wikibase @ http://localhost:8181](http://localhost:8181)
 - [Query Service UI @ http://localhost:8282](http://localhost:8282)
 - [Query Service Backend (Behind a proxy) @ http://localhost:8989/bigdata/](http://localhost:8989/bigdata/)
 - [Query Service Backend (Direct) @ http://localhost:8999/bigdata/](http://localhost:8999/bigdata/)
 - [Quickstatements @ http://localhost:9191](http://localhost:9191)

## Creating content and querying it

You can start creating items and properties to start populating your Wikibase instance via these special pages
  - [Create a new item](http://localhost:8181/wiki/Special:NewItem)
  - [Create a new property](http://localhost:8181/wiki/Special:NewProperty)

Once you've created your first items and statements, you'll be able to query them and visualize the results through the [Query Service UI](http://localhost:8282).

## Exporting data as a JSON or RDF dump

Get a JSON dump from wikibase:

```docker-compose exec wikibase php ./extensions/Wikibase/repo/maintenance/dumpJson.php```

Get an RDF dump from wikibase:

```docker-compose exec wikibase php ./extensions/Wikibase/repo/maintenance/dumpRdf.php```

## Troubleshooting

* [I am on linux and I don't want to run docker as root!](https://askubuntu.com/questions/477551/how-can-i-use-docker-without-sudo#477554)
* The query service is not running or seems to get killed by the OS?
  * The docker-compose setup requires more than 2GB of available RAM to start. While being developed the dev machine has 4GB of RAM.
