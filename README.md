<> Copyright (c) 2021 Copyright Holder (Catena-X Consortium)
<>
<> See the AUTHORS file(s) distributed with this work for additional
<> information regarding authorship.
<>
<> See the LICENSE file(s) distributed with this work for
<> additional information regarding license terms.

# Federated Catena-X Data Component Spike 

This repository documents an experiment to implement federated Catena-X data components.

## Introduction

### Catena-X (Dataspace) Component

A Catena-X Component implements
- a service API on a data plane (=network)
- the IDS/GAIA-X connector API on a possibly separated control plane

A Catena-X Component may uses/delegate to
- a set of internal modules/services on an internal plane.

### Catena-X Data Component

A Catena-X Data Component implements at least one
- standardized synchronous query API (aka "pull API" although that is misleading the way that data actually flows), such as GraphQL, SparQL or REST/CRUD, or
- standardized asynchronous and batched event API (aka "push API", such as file-based HTTP/POST on top of csv, ttl, xml or json

### Catena-X Federated Component

A Catena-X Federated Component is a component whose service API will not change when building/deploying a merged/delegating instance.

### Catena-X Federated Data Component based on SparQL/Turtle

In this spike we demonstrate how to use existing open source modules to build a federated Catena-X (triple) data component:
- Eclipse Dataspace Connector
- Apache Fuseki

As the API, we chose
- as the query API: SPARQL over http 
- as the event API: TTL file upload (TODO)

The reason for this is that
* the graph representation is the most general concept behind any tree, schema- or table-based approach
* the graph representation bridges the gap between data and meta-data representations
* SPARQL already has a builtin concept of separation/federation (GRAPHS or SERVICES)
* SPARQL allows to express all kinds of CRUD operations
* there are SPARQL bindings for all kind of performant storage engines (SQL databases, graph databases, ...)

## How to build and run

### Build repo and run a (non-sovereign) internal triple store with separate endpoints for different tenants

```
./run_local.sh -all -build -complete -internal &
```

Exposed endpoints/tenants:
- central-hub
  - query
  - upload
- tenant1-hub
    - query
    - upload
- tenant2-hub
    - query
    - upload
- central-registry
    - query
    - upload
- tenant1-registry
    - query
    - upload
- tenant2-registry
    - query
    - upload

For uploading an aspect model to tenant1:

```
curl --location --request POST 'http://localhost:2121/tenant1-hub/upload' \
--form 'file=@"/C:/Users/cjung7/Projekte/catenax/BAMMmodels/Material/0.1.1/Material.ttl"' \
--form 'graph="default"'
```

For uploading a second aspect model to tenant2:

```
curl --location --request POST 'http://localhost:2121/tenant2-hub/upload' \
--form 'file=@"/C:/Users/cjung7/Projekte/catenax/BAMMmodels/ProductUsage/0.1.1/ProductUsage.ttl"' \
--form 'graph="default"'
```

Querying all relations from the endpoints (delivers no results for central):

```
curl --location --request POST 'http://localhost:2121/central-hub/sparql' \
--header 'Content-Type: application/sparql-query' \
--data-raw 'SELECT ?subject ?predicate ?object
WHERE {
    ?subject ?predicate ?object .
}'
```

```
curl --location --request POST 'http://localhost:2121/tenant1-hub/sparql' \
--header 'Content-Type: application/sparql-query' \
--data-raw 'SELECT ?subject ?predicate ?object
WHERE {
    ?subject ?predicate ?object .
}'
```

```
curl --location --request POST 'http://localhost:2121/tenant2-hub/sparql' \
--header 'Content-Type: application/sparql-query' \
--data-raw 'SELECT ?subject ?predicate ?object
WHERE {
    ?subject ?predicate ?object .
}'
```

Federated union of aspect models from central:

```
curl --location --request POST 'http://localhost:2121/central-hub/sparql' \
--header 'Content-Type: application/sparql-query' \
--data-raw 'PREFIX rdf:  <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX bamm: <urn:bamm:io.openmanufacturing:meta-model:1.0.0#>

SELECT ?aspect
WHERE {
    {
        SERVICE <http://localhost:2121/tenant1-hub/query> { 
            ?aspect rdf:type bamm:Aspect .
        }
    }
    UNION
    {
        SERVICE <http://localhost:2121/tenant2-hub/query> { 
            ?aspect rdf:type bamm:Aspect .
        }
    }
}'
```

### Run the (sovereign) federated triple data component

```
./run_local.sh -central -external &
```

Accessing the query API using Catena-X Headers (still delivering no internal aspect)

```
curl -X POST http://localhost:8181/api/sparql/hub -H "Content-Type: application/sparql-query"  -H "catenax-security-token: mock-eu" -H "catenax-caller-connector: urn:connector:app:semantics:catenax:net" -d 'PREFIX rdf:  <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX bamm: <urn:bamm:io.openmanufacturing:meta-model:1.0.0#>

SELECT ?aspect
WHERE {
    ?aspect rdf:type bamm:Aspect .
}
'
```

### Run the tenant triple data components

```
./run_local.sh -tenant1 -external &
./run_local.sh -tenant2 -external &
```

Federated & sovereign union of aspect models:

```
curl -X POST http://localhost:8181/api/sparql/hub -H "Content-Type: application/sparql-query"  -H "catenax-security-token: mock-eu" -H "catenax-caller-connector: urn:connector:app:semantics:catenax:net" -d 'PREFIX rdf:  <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX bamm: <urn:bamm:io.openmanufacturing:meta-model:1.0.0#>

SELECT ?aspect
WHERE {
    {
        SERVICE <http://localhost:8182/api/sparql/hub> { 
            ?aspect rdf:type bamm:Aspect .
        }
    }
    UNION
    {
        SERVICE <http://localhost:8183/api/sparql/hub> { 
            ?aspect rdf:type bamm:Aspect .
        }
    }
}
'
```


