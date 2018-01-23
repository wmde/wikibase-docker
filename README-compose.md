## Docker Compose Example

This repository contains an example docker compose file that can be used with the images also contained in this repo.

## Install Instructions

For a single script to run that should work on a WMF labs VM running debian jessie with 4GB memory take a look at setup.sh in this repository.

#### 1) Install Docker (community edition)

https://docs.docker.com/engine/installation/

#### 2) Install Docker Compose

https://docs.docker.com/compose/install/

#### 3) Clone this repository

```
git clone https://github.com/wmde/wikibase-docker.git
```

## Usage Instructions

Note: In linux you must either be in the docker group or use SUDO!

You can also simply use the docker-compose file here as an example and create your own with modifications.

#### Start the containers

If you are just a user you can pull the images from docker hub:
```
docker-compose pull
docker-compose up --no-build -d
```

If you want to develop the Dockerfiles then you will want to build the images yourself:
```
docker-compose up --build -d
```

#### Stop the containers

```
docker-compose stop
```

#### Remove the containers

```
docker-compose down
```

This will keep all data stored by mysql, mediawiki and the query service in docker volumes.

#### Remove the containers and data

**WARNING:** this will remove ALL of the data you had added to Wikibase and the Query Service.

```
docker-compose down --volumes
```

## Backup and Data transfer instructions

All data for wikibase and the query service is stored in docker volumes.
You can create compressed copies of these volumes to use as backups or to had off to other users.

You can see all docker volumes created by using the following command:

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

## Access Instructions

**Host access**

Access the following hosts:
 - [Wikibase @ http://localhost:8181](http://localhost:8181)
 - [Query Service UI @ http://localhost:8282](http://localhost:8282)
 - [Query Service Backend (Behind a proxy) @ http://localhost:8989/bigdata/](http://localhost:8989/bigdata/)
 - [Query Service Backend (Direct) @ http://localhost:8999/bigdata/](http://localhost:8999/bigdata/)

**Exporting data**

Get a JSON dump from wikibase:

```docker-compose exec wikibase php ./extensions/Wikibase/repo/maintenance/dumpJson.php```

Get an RDF dump from wikibase:

```docker-compose exec wikibase php ./extensions/Wikibase/repo/maintenance/dumpRdf.php```

## Troubleshooting

* [I am on linux and I don't want to run docker as root!](https://askubuntu.com/questions/477551/how-can-i-use-docker-without-sudo#477554)
* The query service is not running or seems to get killed by the OS?
  * The docker-compose setup requires more than 2GB of available RAM to start. While being developed the dev machine has 8GB of RAM.
