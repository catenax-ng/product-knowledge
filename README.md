

[Copyright (c) 2021 T-Systems International GmbH (Catena-X Consortium)]: # () 

[See the AUTHORS file(s) distributed with this work for additional information regarding authorship.]: # ()

[See the LICENSE file(s) distributed with this work for additional information regarding license terms.]: # ()

# Federated Catena-X Data Components Spike 

This repository documents an experiment to describe and implement federated Catena-X data components.

After clone, please remember to also initially pull the submodules by invoking

```
git submodule update --init --recursive
```

You will need a JDK>=11 installed in the JAVA_HOME environment variable.

You will need Apache Maven installed in the PATH environment variable.

## Introduction

### Catena-X (Dataspace) Components

![Catena-X Component](catenax_component.PNG)

A *Catena-X (Dataspace) Component* implements
- a **service API** on a *data plane* (=network)
- the **IDS/GAIA-X connector API** on a possibly separated *control plane*

A Catena-X (Dataspace) Component may use/delegate to
- a set of internal modules/services on an *internal plane*.

The inner workings (secrets, tokens, states, failures, API) of the internal plane is largely hidden 
from the data plane in order to enable a broad range of deployment scenarios.

For similar reasons, the data plane is also described largely independent of the connector plane (except maybe additional 
transport/data packet headers and annotations). 

The connector plane interacts with the data plane and the internal plane via 
so-called controller objects which listen to/propagate events and changes in the 
respective planes.

### Catena-X Data Components

![Catena-X Data Component](catenax_data_component.PNG)

A *Catena-X Data Component* is a Catena-X Component which implements at least one
- standardized **synchronous query API** (aka "pull API", although that name is misleading regarding the actual bidirectional way that data may be transmitted through that API), such as *GraphQL*-, *SparQL*- or *REST/CRUD*-based, or
- standardized **asynchronous and batched event API** (aka "push API"), such as file-based *HTTP/POST* on top of *CSV*, *TTL*, *XML* or *json*

The internal data is organized in **assets** (like database schemas or graphs) which obey to specific **data policies**. 
We expect each asset to contain a coherent and possibly large set of documents/entities/trees/rows 
which can be addressed individually as well as searched and aggregated as a (sub-)collection.

Data Policies comprise:
- The permission/restriction to *read and query* (partial) data from the asset.
- The permission/restriction to *union/join/aggregate* (partial) data with other assets.
- The permission/restriction to *store* (partial) data from the asset.
- The permission/restriction to *redistribute* (partial) data from the asset.
- The permission/restriction to *write or update* (partial) data in the asset.

Data Policies in combination with the Connector API allow each Catena-X Data Component for *multi-tenancy*. 
That means that it is a safe and soverign way to host data on behalf of different (mutually competitive or unknown) 
stakeholders.

Data assets may **federate** (i.e. *join, union, aggregate*) data from other assets. 
In this case, data policies are required to be consistent, i.e., a permission/restriction to a particular 
federated data asset should never be relaxed at the federating level. 
In that respect we strongly discourage building arbitrary or even recursive asset relationships. Instead, we 
propose data processing methods which allow lineage analysis that is the traceability of each data point to 
its original assets (and hence: policies).

### Catena-X Federated Components

![Catena-X Federated and Federating Components](catenax_federated_component.PNG)

A *Catena-X Federated Component* is a type of component whose service API will not significantly 
change when building or separating either a merged or split-up deployment. 

Since the Connector API is supposed to be fixed that effectively enables us - without changing the surrounding 
architecture or even code - to either 
- build a central, multi-tenant *federating component* out of disparate *federated components* (tenants) for reasons of simplicity and better sharing of resources.
- split an existing *federating component* into separate *federated components* for reasons of data sovereignity and scaling of resources.

Although the step of (de-)federation is often accompanied or even motivated by a change of assets/policies, 
we require a Catena-X Federated Component to apply only policies which may be equivalently uphold during the 
merge/split process.

### A Catena-X Federated Triple Data Component

![Catena-X Federated Triple Data Component](catenax_fed_triple_data_comp.PNG)

In this spike we demonstrate how to use existing open source modules to build a *Federated Catena-X (Triple) Data Component* out of:
- [Eclipse Dataspace Connector](https://projects.eclipse.org/projects/technology.dataspaceconnector)
- [Apache Jena Fuseki](https://jena.apache.org/documentation/fuseki2/)

As the data service API, we chose
- as the synchronous query API: [*SPARQL over http/s*](https://www.w3.org/TR/sparql11-query/) 
- as the asynchronous event API: *[TTL file](https://www.w3.org/TR/turtle/) over http/s*

The rationale for choosing this triple data approach is 
* a graph is the most general concept behind any tree, schema- or table-based approach
* a graph bridges the gap between data and meta-data representations
  * it can be immediately applied to semantic services
* a graph is a good basis for lineage analysis
* SPARQL already has builtin concepts of separation/federation (GRAPHS and SERVICES)
* SPARQL allows to express all kinds of CRUD operations
* there are SPARQL bindings for all kind of performant storage engines (SQL databases, graph databases, ...)

In the spike, we demonstrate how
* a SPARQL query posted to a central federating service (with some additional http headers) will be 
  1. first converted and validated into an ordinary connector-plane artifact request of type "sparql"
  2. forwarded (with some extended-context http headers) to the internal Fuseki database
  3. delegated and joined from the Fuseki database to the federated services (which recursively behave like the federating service)
  4. Any cross-graph/cross-asset policies are checked at the level of the federating service. 
  5. Any cross-service policies are checked at the level of the federated service.
* the central federating component registers a streaming data request from its own connector to the federated connectors
  1. the type of the data request will be "turtle"
  2. the destination of the data request will be the TTL post endpoint of the federating component
  3. the target asset of the data request will be a graph in the federated database
  4. whenever that graph changes, a TTL file is posted to all successfully subscribed/pending data request destinations (with additional http headers)
  5. the turtle endpoint needs to just check the headers for validity before forwarding the file to the central Fuseki database
  6. this event processing is implemented recursively, i.e., the central service now also checks for any pending subscribers
  
## How to build and run

### Build repo and run a (non-sovereign) internal triple store with separate endpoints for different tenants

```
./run_local.sh -all -build -complete -internal &
```

Exposed endpoints/tenants:
- http://localhost:2121/central-hub
  - http://localhost:2121/central-hub/query (sparql)
  - http://localhost:2121/central-hub/upload (ttl)
- http://localhost:2121/tenant1-hub
  - http://localhost:2121/central-hub/query
  - http://localhost:2121/central-hub/upload
- http://localhost:2121/tenant2-hub
  - http://localhost:2121/central-hub/query
  - http://localhost:2121/central-hub/upload

For uploading aspect models to different graphs in tenant1, you may invoke:

```
curl -X POST 'http://localhost:2121/tenant1-hub/upload' \
--form 'file=@BAMMmodels/com.catenax/0.0.1/Material.ttl' \
--form 'graph="urn:x-arq:DefaultGraph"'
```

```
curl -X POST 'http://localhost:2121/tenant1-hub/upload' \
--form 'file=@BAMMmodels/com.catenax/0.0.1/EolStory.ttl' \
--form 'graph="urn:tenant1:PrivateGraph"'
```

For uploading aspect models to different graphs of tenant2, you may invoke:

```
curl -X POST 'http://localhost:2121/tenant2-hub/upload' \
--form 'file=@BAMMmodels/com.catenax/0.1.1/ProductUsage.ttl' \
--form 'graph="urn:x-arq:DefaultGraph"'
```

```
curl -X POST 'http://localhost:2121/tenant2-hub/upload' \
--form 'file=@BAMMmodels/com.catenax/0.1.1/ReturnRequest.ttl' \
--form 'graph="urn:tenant2:PrivateGraph"'
```

For querying all relations from the different endpoints (delivers no results for central):

```
curl -X POST 'http://localhost:2121/central-hub/query' \
--header 'Content-Type: application/sparql-query' \
--data-raw 'SELECT ?subject ?predicate ?object
WHERE {
    ?subject ?predicate ?object .
}'
```

```
curl -X POST 'http://localhost:2121/tenant1-hub/query' \
--header 'Content-Type: application/sparql-query' \
--data-raw 'SELECT ?subject ?predicate ?object
WHERE {
    ?subject ?predicate ?object .
}'
```

```
curl -X POST 'http://localhost:2121/tenant2-hub/query' \
--header 'Content-Type: application/sparql-query' \
--data-raw 'SELECT ?subject ?predicate ?object
WHERE {
    ?subject ?predicate ?object .
}'
```

This is an example of SPARQL builtin-federation of graphs and services. When invoked after above statements, 
it should list the four aspect models which have been directly installed.

```
curl -X POST 'http://localhost:2121/central-hub/query' \
--header 'Content-Type: application/sparql-query' \
--data-raw 'PREFIX rdf:  <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX bamm: <urn:bamm:io.openmanufacturing:meta-model:1.0.0#>

SELECT ?aspect
WHERE {
    {
        SERVICE <http://localhost:2121/tenant1-hub/query> { 
            {
              ?aspect rdf:type bamm:Aspect .
            }
            UNION
            {
              GRAPH <urn:tenant1:PropagateGraph> {
                ?aspect rdf:type bamm:Aspect .
              }
            }
            UNION
            {
              GRAPH <urn:tenant1:PrivateGraph> {
                ?aspect rdf:type bamm:Aspect .
              }
            }
        }
    }
    UNION
    {
        SERVICE <http://localhost:2121/tenant2-hub/query> { 
            {
              ?aspect rdf:type bamm:Aspect .
            }
            UNION
            {
              GRAPH <urn:tenant2:PropagateGraph> {
                ?aspect rdf:type bamm:Aspect .
              }
            }
            UNION
            {
              GRAPH <urn:tenant2:PrivateGraph> {
                ?aspect rdf:type bamm:Aspect .
              }
            }
        }
    }
    UNION
    {
        GRAPH <urn:tenant2:PropagateGraph> { 
            ?aspect rdf:type bamm:Aspect .
        }
    }
    UNION
    {
        GRAPH <urn:tenant2:PropagateGraph> { 
            ?aspect rdf:type bamm:Aspect .
        }
    }
}'
```

### Run two federated/tenant triple data components

```
./run_local.sh -tenant1 -external &
./run_local.sh -tenant2 -external &
```

Exposed endpoints/tenants:
- http://localhost:8182/api
  - http://localhost:8182/api/sparql/hub
  - http://localhost:8182/api/turtle/hub
- http://localhost:8183/api
  - http://localhost:8183/api/sparql/hub
  - http://localhost:8183/api/turtle/hub
  
For querying tenant1 assets with the SPARQL API (using Catena-X Headers), you can issue the following command (please note that 
all ED-connectors have been configured using the sample "mock-identity" provider and its trivial tokens):

```
curl -X POST http://localhost:8182/api/sparql/hub \
-H "Content-Type: application/sparql-query" \
-H "catenax-security-token: mock-eu" \
-H "catenax-connector-context: urn:connector:central:semantics:catenax:net" \
-d 'PREFIX rdf:  <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX bamm: <urn:bamm:io.openmanufacturing:meta-model:1.0.0#>

SELECT ?aspect
WHERE {
    {
      ?aspect rdf:type bamm:Aspect .
    } 
    UNION
    {
        GRAPH <urn:tenant1:PrivateGraph> {
          ?aspect rdf:type bamm:Aspect .
        }
    }
    UNION
    {
        GRAPH <urn:tenant1:PropagateGraph> {
          ?aspect rdf:type bamm:Aspect .
        }
    }
}
'
```

### Run a central/federating triple data component

```
./run_local.sh -central -external &
```

Exposed endpoints/tenants:
- http://localhost:8181/api
  - http://localhost:8181/api/sparql/hub
  - http://localhost:8181/api/turtle/hub
  
For querying the resulting federation of assets/graphs with the SPARQL API, you can issue:

```
curl -X POST http://localhost:8181/api/sparql/hub \
-H "Content-Type: application/sparql-query"  \
-H "catenax-security-token: mock-eu" \
-H "catenax-connector-context: urn:connector:app:semantics:catenax:net" \
-d 'PREFIX rdf:  <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX bamm: <urn:bamm:io.openmanufacturing:meta-model:1.0.0#>

SELECT ?aspect
WHERE {
    {
        SERVICE <http://localhost:8182/api/sparql/hub> { 
            {
              ?aspect rdf:type bamm:Aspect .
            }
        }
    }
    UNION
    {
        SERVICE <http://localhost:8183/api/sparql/hub> { 
            {
              ?aspect rdf:type bamm:Aspect .
            }
        }
    }
    UNION
    {
        GRAPH <urn:tenant1:PropagateGraph> {
          ?aspect rdf:type bamm:Aspect .
        }
    }
    UNION
    {
        GRAPH <urn:tenant2:PropagateGraph> {
          ?aspect rdf:type bamm:Aspect .
        }
    }
}
'
```

For performing an update to tenant1 and tenant2 assets with the TTL API which then propagate to 
central (and whose effect which you can check by rerunning the previous query afterwards):

```
curl -X POST 'http://localhost:8182/api/turtle/hub' \
-H "catenax-security-token: mock-eu" \
-H "catenax-connector-context: urn:connector:app:semantics:catenax:net" \
--form 'file=@BAMMmodels/com.catenax/0.0.1/TechnicalData.ttl' \
--form 'graph="urn:tenant1:PropagateGraph"'
```

```
curl -X POST 'http://localhost:8183/api/turtle/hub' \
-H "catenax-security-token: mock-eu" \
-H "catenax-connector-context: urn:connector:app:semantics:catenax:net" \
--form 'file=@BAMMmodels/com.catenax/0.1.1/QualityAlert.ttl' \
--form 'graph="urn:tenant2:PropagateGraph"'
```
