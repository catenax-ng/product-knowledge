# Catena-X Knowledge Agents (Hey Catena!) Provisioning Agent

The Provisioning Agent will bind typical (relational/structued) backend data sources such as Databases and Datalakes in a secure manner 
to the dataspace.

This is a folder providing the FOSS implementation of a Hey Catena! Agent (=SparQL Endpoint) for provider-side deployment.

Highly-scaleable replacements for (not only) the role of the FOSS Provisioning Agent are:
* [GraphDB](https://www.ontotext.com/products/graphdb/)
* [Neptune](https://aws.amazon.com/de/neptune/)

## Architecture

The FOSS Provisioning Agent uses the [OnTop Virtual Knowledge Graph](https://ontop-vkg.org/) system.

According to their homepage: "... exposes the content of arbitrary relational databases as knowledge graphs. These graphs are virtual, which means that data remains in the data sources instead of being moved to another database."

Ontop operates on four standards: three W3C standards and one ANSI standard. It translates

* incoming *Queries* in [SparQL 1.1](https://www.w3.org/TR/sparql11-query/)
* using a *Mapping* in [R2RML](https://www.w3.org/TR/r2rml/) (or the slightly simpler Ontop Mapping Language - OBDA)
* from an *Ontology* in [OWL 2 QL](https://www.w3.org/TR/owl2-profiles/#OWL_2_QL)
* into [*SQL*](https://datacadamia.com/data/type/relation/sql/ansi) queries.

The [Ontop CLI](https://ontop-vkg.org/tutorial/endpoint/endpoint-cli.html) is a Java/Spring application which must
be extended with an appropriate JDBC driver.

The Ontop CLI can host only one endpoint per port, if you want to expose different ontologies, mappings or database sources,
you must configure another endpoint=port. See <a href="#Containerizing">Containerizing</a> for an example.

### Security

Besides the authentication of the Ontop engine at the relational database via jdbc (one url/user per endpoint), there is no 
additional (row-level) security mechanism.

Hence we recommend to apply a role-based approach.

For any accessing role:
- define a separate database schema with appropriately filtered views
- define a separate endpoint/port/mapping.

See <a href="#Containerizing">Containerizing</a> for an example.

### Data Sources and Scaleablility

For the sample deployments, we use single agent container with an embedded database (H2) and/or a second database virtualization container (Dremio Community Edition) using preloaded files.

Practical deployments will 
* scale and balance the agent containers (for which the lifecycle hooks are already provided).
* use an enterprise-level database (Postgres Service) or database virtualization infrastructure (Dremio Enterprise, Denodo, Teii) that is backed by an appropriate storage system (ADSL, S3, Netapp).

## Deployment & Usage

### Containerizing (Provisioning Agent)

To build the docker image of the Agent, please invoke this command

```console
docker build -t ghcr.io/catenax-ng/product-knowledge/dataspace/provisioning-agent:latest -f src/main/docker/Dockerfile.agent .
```

The image contains
* the Ontop CLI distribution
* an H2 in-memory database
* a large SQL file for sample database initialisation (until we find a more easy way of deployment)

To run the docker image, you could invoke this command

```console
docker run -p 8080:8080 \
  -v $(pwd)/resources/university.ttl:/input/ontology.ttl \
  -v $(pwd)/resources/university-role1.obda:/input/mapping.obda \
  -v $(pwd)/resources/university-role1.properties:/input/settings.properties \
  -v $(pwd)/resources/university.sql:/tmp/university.sql \
  ghcr.io/catenax-ng/product-knowledge/dataspace/provisioning-agent:0.5.3
````

Afterwards, you should be able to access the [local SparQL endpoint](http://localhost:8080/) via
the browser or by directly invoking a query

```console
curl --location --request POST 'http://localhost:8080/sparql' \
--header 'Content-Type: application/sparql-query' \
--header 'Accept: application/json' \
--data-raw 'PREFIX : <http://example.org/voc#>

SELECT ?x
WHERE {
   ?x a :Professor .
}'
```

You may manipulate any of the following environment variables to configure the image behaviour.
Note that there is no builtin security (ssl/auth) for the exposed endpoints.
This must be provided by hiding them in an appropriate service network layer.

| ENVIRONMENT VARIABLE        | Required  | Example                                                                | Description                          | List |
|---	                        |---	      |---	                                                                   |---                                   | ---  |
| JAVA_TOOL_OPTIONS           |           | -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=*:8090   | JMV (Debugging option)               | X    | 
| ONTOP_PORT                  |           | 8080 (default)                                                         | A port number                        | X    |
| ONTOP_ONTOLOGY_FILE         |           | /input/ontology.ttl (default)                                          | Path to ontology file (ttl or xml)   | X    |
| ONTOP_MAPPING_FILE          |           | /input/mapping.obda (default)                                          | Path to mapping file (obda)          | X    |
| ONTOP_PROPERTIES_FILE       |           | /input/settings.properties (default)                                   | Path to settings file (properties)   | X    |
| ONTOP_PORTAL_FILE           |           | /input/portal.toml                                                     | Path to portal config (toml)         | X    |
| ONTOP_CORS_ALLOWED_ORIGINS  |           | * (default)                                                            | CORS domain name                     |      |
| ONTOP_DEV_MODE              |           | true (default)                                                         | Redeploy endpoint on file changes    | X    |

Here is an example which exposes two endpoints for two different roles (database users, restricted mappings but same ontology)

```console
docker run -p 8080:8080 -p 8082:8082 \
  -v $(pwd)/resources/university.ttl:/input/ontology.ttl \
  -v $(pwd)/resources/university-role1.obda:/input/role1.obda \
  -v $(pwd)/resources/university-role1.properties:/input/role1.properties \
  -v $(pwd)/resources/university-role2.obda:/input/role2.obda \
  -v $(pwd)/resources/university-role2.properties:/input/role2.properties \
  -v $(pwd)/resources/university.sql:/tmp/university.sql \
  -e ONTOP_PORT="8080 8082" \
  -e ONTOP_ONTOLOGY_FILE="/input/ontology.ttl /input/ontology.ttl" \
  -e ONTOP_MAPPING_FILE="/input/role1.obda /input/role2.obda" \
  -e ONTOP_PROPERTIES_FILE="/input/role1.properties /input/role2.properties" \
  -e ONTOP_DEV_MODE="false false" \
  ghcr.io/catenax-ng/product-knowledge/dataspace/provisioning-agent:latest
````

Accessing entities spanning two schemas using the first role/endpoint delivers a greater count

```console
curl --location --request POST 'http://localhost:8080/sparql' \
--header 'Content-Type: application/sparql-query' \
--header 'Accept: application/json' \
--data-raw 'PREFIX : <http://example.org/voc#>

SELECT (COUNT(DISTINCT ?x) as ?count)
WHERE {
   ?x a :Course .
}'
```

```json
{
  "head" : {
    "vars" : [
      "count"
    ]
  },
  "results" : {
    "bindings" : [
      {
        "count" : {
          "datatype" : "http://www.w3.org/2001/XMLSchema#integer",
          "type" : "literal",
          "value" : "12"
        }
      }
    ]
  }
}
```

Accessing entities using the restricted role/endpoint delivers a smaller count

```console
curl --location --request POST 'http://localhost:8082/sparql' \
--header 'Content-Type: application/sparql-query' \
--header 'Accept: application/json' \
--data-raw 'PREFIX : <http://example.org/voc#>

SELECT (COUNT(DISTINCT ?x) as ?count)
WHERE {
   ?x a :Course .
}'
```

```json
{
  "head" : {
    "vars" : [
      "count"
    ]
  },
  "results" : {
    "bindings" : [
      {
        "count" : {
          "datatype" : "http://www.w3.org/2001/XMLSchema#integer",
          "type" : "literal",
          "value" : "6"
        }
      }
    ]
  }
}
```

### Containerizing (Backend)

To build the docker image of the Database Virtualization Layer, please invoke this command

```console
docker build -t ghcr.io/catenax-ng/product-knowledge/backend/sql-virtualize-dremio-oss:latest -f src/main/docker/Dockerfile.backend .
```

The image contains
* the Dremio OSS distribution
* some JSON files for sample provisioning

To run the docker image, you could invoke this command

```console
docker run -p 9047:9047 -p 31010:31010 -p 45678:45678 \
  ghcr.io/catenax-ng/product-knowledge/backend/sql-virtualize-dremio-oss:latest
````

When the image is run for the first time you need to setup an admin user:

```console
curl 'http://localhost:9047/apiv2/bootstrap/firstuser' -X PUT \
      -H 'Authorization: _dremionull' -H 'Content-Type: application/json' \
     --data-binary '{"userName":"foo","firstName":"foo","lastName":"bar","email":"foo@bar.com","createdAt":1526186430755,"password":"bananas4ever"}'
````

Now you could login to the [Dremio console](http://localhost:9047) and add a 
new source to the local filesystem (via )

### Deployment

An example how to deploy the image can be found 
* in the [Docker Compose](../../../infrastructure/docker-compose.yml) recipe as well as 
* in the [Helm Chart](../../../infrastructure/templates/oem-provider.yaml) template.


### Interact with the Provisioning Agent

Once started (either locally on port 8080 or in a forwarded port from github codespaces via [docker compose](../../../infrastructure/README.md) you will be able 
to access a SPARQL Console:

- http://localhost:8080/
- https://drcgjung-catenax-ng-product-knowledge-wjgvvr6fgx97-8080.githubpreview.dev/

At the same time you may directly interface the SPARQL over HTTP endpoint

```console
curl --location --request POST 'http://localhost:8080/sparql' \
--header 'Content-Type: application/sparql-query' \
--header 'Accept: application/json' \
--data-raw 'PREFIX : <http://example.org/voc#>
SELECT DISTINCT ?teacher {
  ?teacher a :Teacher .
}
'
```

## Notice

* see copyright notice in the top folder
* see license file in the top folder
* see authors file in the top folder





