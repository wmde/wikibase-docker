## Installing a stand-alone Wikibase and most used services

This repository contains an EXAMPLE docker-compose file that can be used with the wikibase docker images on https://hub.docker.com/r/wikibase
Following these instructions, you'll be able to install:
 - A stand-alone instance of Wikibase – the collaborative structured data engine behind [Wikidata](https://wikidata.org/)
 - A fully functional SPARQL endpoint and query service, complete with a data visualization frontend and query helper (similar to the [Wikidata Query Service](https://query.wikidata.org/)).
 - ElasticSearch, for improved serach
 - Quickstatements, a bulk editing tool

**RAM Required:** This example requires 4GB+ of RAM. If you are running Docker for Windows or Mac and have containers run within a VM (the default) make sure you set your VM memory allocation to 4GB or more. If you don't do this everything will probably fail.

### 1) Installing Docker and docker-compose

This is the first step and often the hardest, as every operating system has a different way of installing Docker.

Most setups will come with docker-compose.
If yours doesn't then you can get it at https://docs.docker.com/compose/install/

#### Linux

1. Download and Install Docker Engine-Community using the appropriate instructions for your distro from https://docs.docker.com/install/
2. Make sure you read the instructions regarding using sudo/root or creating a group for docker.

#### Windows

##### Pro, with Hyper-V virtualization

1. Download and Install - Docker Desktop https://www.docker.com/products/docker-desktop
2. Turn on virtualization in BIOS settings (if not already done)
3. Open Docker advanced settings and increase the memory limit for the Virtual machine to more than 4GB

##### Not Pro, or without Hyper-V virtualization

1. Download and Install- Docker Toolbox https://docs.docker.com/toolbox/toolbox_install_windows/
2. Increase your virtual machine memmory allocation
3. Note: You may have to use the IP address of your VM machine once setup, not localhost

#### Mac

1. Download and Install - Docker Desktop https://www.docker.com/products/docker-desktop
2. Open Docker advanced settings and increase the memory limit for the Virtual machine to more than 4GB

### 2) Download the docker-compose.yml file example

This file is only meant as an example, your modification might be needed.

#### If you have the wget command

```
wget https://raw.githubusercontent.com/wmde/wikibase-docker/master/docker-compose.yml
```

#### If you do not

If you don't have wget then just download the file from the web and save it into your working directory with the name docker-compose.yml

### 3) Downloading images and starting the containers

**Pulling / updating the images**

The below command will download the versions of the docker images used in the docker-compose example.

```
docker-compose pull
```

**Starting the containers**

The below command will start several containers but hide the output. If you want to see what is happening see the section on viewing logs below.

```
docker-compose up -d
```

**Viewing container output**

The below command will output a stream of logs from all containers

```
docker-compose logs -f
```

### 4) Wait and check

The setup will take a short while and includes automatic steps such as:
 - Initializing Blazegraph storage
 - Initializing MySql storage
 - Initializing Elasticsearch storage
 - Installing Mediawiki and Wikibase database tables
 - Creating oauth details for Quickstatements

You can check to see if all containers are running with the below command:

```
docker-compose ps
```

If any appear to not be running then something has likely gone wrong.
Take a look at the troubleshooting section at the bottom of this readme.

Once setup has complete you should be able to naviagte to the services.

Note: Docker Toolbox users, you may have to use the IP address of your virtual machine instead of localhost.

Access the following hosts:
 - [Wikibase @ http://localhost:8181](http://localhost:8181)
 - [Query Service UI @ http://localhost:8282](http://localhost:8282)
 - [Query Service Backend (Behind a proxy) @ http://localhost:8989/bigdata/](http://localhost:8989/bigdata/)
 - [Quickstatements @ http://localhost:9191](http://localhost:9191)

If you want to access the balzegraph SPARQL endpoint directly for writing you need to bypass the read only proxy.
You will need to make a change similar to this: https://github.com/wmde/wikibase-docker/pull/16/files
You will then be able to access the query service on localhost for writing.
 - [Query Service Backend (Direct) @ http://localhost:8999/bigdata/](http://localhost:8999/bigdata/)

### 4) Other commands

**Stopping the containers (keeps data and containers)**

```
docker-compose stop
```

**Removing the containers (keeps data, removes containers)**

This will keep all data stored by MySQL, Mediawiki and the Query Service in Docker volumes.

```
docker-compose down
```

**Removing the containers and data**

**WARNING:** this will remove ALL of the data you had added to MediaWiki, Wikibase, the QueryService and ElasticSearch.

```
docker-compose down --volumes
```

### 5) Interacting with Wikibase

A default user is created on setup. Username "WikibaseAdmin", Password "WikibaseDockerAdminPass".

This is highly insecure, so if your instance is public please change the password in your docker-compose.yml before setup, or after setting up using MediaWiki.

#### Creating content and querying it

You can start creating items and properties to start populating your Wikibase instance via these special pages
  - [Create a new item](http://localhost:8181/wiki/Special:NewItem)
  - [Create a new property](http://localhost:8181/wiki/Special:NewProperty)

Once you've created your first items and statements, you'll be able to query them and visualize the results through the [Query Service UI](http://localhost:8282).

#### Exporting data as a JSON or RDF dump

Get a JSON dump from wikibase:

```docker-compose exec wikibase php ./extensions/Wikibase/repo/maintenance/dumpJson.php```

Get an RDF dump from wikibase:

```docker-compose exec wikibase php ./extensions/Wikibase/repo/maintenance/dumpRdf.php```

### 6) Managing data

#### Backing up data from Docker volumes

All data for Wikibase and the Query Service is stored in Docker volumes. You can create compressed copies of these volumes to use as backups or to hand off to other users.

Volume backups will only work if you use the same image when restoring / using the backup data.
If you are backing up your mysql data you may also want to just take an SQL dump.

You can see all Docker volumes created by using the following command:

```
docker volume ls | grep wikibase-docker
```

You can grab a zip of each volumes by doing the following:

```
docker run -v wikibase-docker_mediawiki-mysql-data:/volume -v /tmp/wikibase-data:/backup --rm loomchild/volume-backup backup mediawiki-mysql-data
```

You, or someone else, can then restore the volume by doing the following:

```
docker run -v wikibase-docker_mediawiki-mysql-data:/volume -v /tmp/wikibase-data:/backup --rm loomchild/volume-backup restore mediawiki-mysql-data
```

#### Backing up data using mysqldump

If using volume-backup for the database does not work because of InnoDB tables
([check here](https://dev.mysql.com/doc/refman/8.0/en/backup-methods.html)),
you can achieve data backup using mysqldump.

##### Backing up with mysqldump

```
docker exec wikibase-docker_mysql_1 mysqldump -u wikiuser -psqlpass my_wiki > backup.sql
```

##### Restoring from mysqldump backup file

```
docker exec wikibase-docker_mysql_1 mysql -u wikiuser -psqlpass my_wiki < backup.sql

```

## Troubleshooting

* [I am on linux and I don't want to run docker as root!](https://askubuntu.com/questions/477551/how-can-i-use-docker-without-sudo#477554)
* Everything seemed to stop and nothing seems to work
  * The docker-compose setup requires more than 4GB of available RAM to start.
* I am using Docker Toolbox and can't access localhost:8181 (or anything else on localhost)
  * You probably need to connect to the IP address of the virtual machine
