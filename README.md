**Setup and endpoints**

docker-compose up --build

 - Wikibase @ http://localhost:8181
 - Query Service UI @ http://localhost:8282
 - Query Service Backend (Behind a proxy) @ http://localhost:8989
 - Query Service Backend (Direct) @ http://localhost:8999

docker-compose down

**Exporting data**

Get a JSON dump from wikibase:

```docker-compose exec wikibase php ./extensions/Wikibase/repo/maintenance/dumpJson.php```

Get an RDF dump from wikibase:

```docker-compose exec wikibase php ./extensions/Wikibase/repo/maintenance/dumpRdf.php```