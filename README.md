<> Copyright (c) 2021 Copyright Holder (Catena-X Consortium)
<>
<> See the AUTHORS file(s) distributed with this work for additional
<> information regarding authorship.
<>
<> See the LICENSE file(s) distributed with this work for
<> additional information regarding license terms.

# Federated Catena-X Data Components Spike 

This repository documents an experiment to describe and implement federated Catena-X data components.

## Introduction

### Catena-X (Dataspace) Components

![Catena-X Component](catenax_component.PNG)

A Catena-X (Dataspace) Component implements
- a service API on a data plane (=network)
- the IDS/GAIA-X connector API on a possibly separated control plane

A Catena-X (Dataspace) Component may use/delegate to
- a set of internal modules/services on an internal plane.

The inner workings (secrets, tokens, states, failures) of the internal plane is largely hidden 
from the data plane.

The data plane is described largely independent of the connector plane (except maybe additional transport 
headers). 

The connector plane interacts with the data plane and the internal plane via API and dataflow controllers.

### Catena-X Data Component

![Catena-X Data Component](catenax_data_component.PNG)

A Catena-X Data Component is a Catena-X Component which implements at least one
- standardized synchronous query API (aka "pull API" although that is misleading the way that data actually flows), such as GraphQL, SparQL or REST/CRUD, or
- standardized asynchronous and batched event API (aka "push API", such as file-based HTTP/POST on top of csv, ttl, xml or json

The internal data is organized in assets (like database views or graphs) which obey to specific data policies. We expect each asset to
contain a coherent and possibly large set of documents/entities/trees/rows which can be addressed individually as well as searched and 
aggregated as a collection.

Data Policies comprise:
- The permission/restriction to read and query (partial) data from the asset.
- The permission/restriction to union/join/aggregate (partial) data with other assets.
- The permission/restriction to store (partial) data from the asset.
- The permission/restriction to redistribute (partial) data from the asset.
- The permission/restriction to write (partial) data into the asset.

Data assets may federate (i.e. join, union, aggregate) data from other assets. Data policies are required to be consistent, i.e.,
a permission/restriction from a subordinate asset can never be relaxed at the union level. In that respect we strongly discourage 
building arbitrary or even recursive asset relationships.

### Catena-X Federated Component

![Catena-X Federated Component](catenax_federated_component.PNG)

A Catena-X Federated Component is a type of component whose service API will not 
change when building/deploying a merged/delegating instance. 

Since the connector API is supposed to be fixed that means that it is possible without changing the surrounding 
architecture/depending code to either 
- build a central component out of disparate components for reasons of simplicity and better sharing of resources
- split an existing component into separate components for reasons of data sovereignity and scaling of resources.

The step of federating is often accompanied/motivated by a change of connector assets/policies. However, we require a federated
component to apply only policies which may be uphold during the federation/split process.

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
--form 'file=@BAMMmodels/com.catenax/0.0.1/Material.ttl' \
--form 'graph="default"'
```

For uploading a second aspect model to tenant2:

```
curl --location --request POST 'http://localhost:2121/tenant2-hub/upload' \
--form 'file=@BAMMmodels/com.catenax/0.1.1/ProductUsage.ttl' \
--form 'graph="default"'
```

Querying all relations from the endpoints (delivers no results for central):

```
curl --location --request POST 'http://localhost:2121/central-hub/query' \
--header 'Content-Type: application/sparql-query' \
--data-raw 'SELECT ?subject ?predicate ?object
WHERE {
    ?subject ?predicate ?object .
}'
```

```
curl --location --request POST 'http://localhost:2121/tenant1-hub/query' \
--header 'Content-Type: application/sparql-query' \
--data-raw 'SELECT ?subject ?predicate ?object
WHERE {
    ?subject ?predicate ?object .
}'
```

```
curl --location --request POST 'http://localhost:2121/tenant2-hub/query' \
--header 'Content-Type: application/sparql-query' \
--data-raw 'SELECT ?subject ?predicate ?object
WHERE {
    ?subject ?predicate ?object .
}'
```

Federated union of aspect models from central:

```
curl --location --request POST 'http://localhost:2121/central-hub/query' \
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

### Run the tenant triple data components

```
./run_local.sh -tenant1 -external &
./run_local.sh -tenant2 -external &
```

Federated & sovereign union of aspect models:

```
curl -X POST http://localhost:8181/api/sparql/hub -H "Content-Type: application/sparql-query"  -H "catenax-security-token: mock-eu" -H "catenax-connector-context: urn:connector:app:semantics:catenax:net" -d 'PREFIX rdf:  <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
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
