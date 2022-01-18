
[Copyright (c) 2021-2022 T-Systems International GmbH (Catena-X Consortium)]: # () 

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
You will need internet access and (optionally) a proxy installed in the HTTP_PROXY_HOST and HTTP_PROXY_PORT environment variables.
The build process will install a (local) gradle build tool during the run.

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

The (internally organised, stored or served) data is organized in **assets** (like database schemas or graphs) which obey to specific **data policies**. 
We expect each asset to contain a coherent and possibly large set of documents/entities/trees/rows 
which can be addressed individually as well as searched and aggregated as a (sub-)collection.

Data Policies comprise:
- The permission/restriction to *read and query* (partial) data from the asset.
- The permission/restriction to *write or update* (partial) data in the asset.
- The permission/restriction to *delete* (partial) data in the asset.
- The permission/restriction to *store and redistribute* (partial) data from the asset.
- The permission/restriction to *subscribe/listen* to (partial) data changes from the asset.

Data Policies in combination with the Connector API allow each Catena-X Data Component for *multi-tenancy*. 
That means that there is a safe and sovereign way to serve data on behalf of different (mutually competitive or unknown) 
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
* a (TTL) graph is the most general concept behind any tree, schema- or table-based data representation
* a (TTL) graph bridges the gap between data and meta-data representations. It is the natural representation of semantic-enabled services.
* a (TTL) graph is a useful tool for lineage analysis
* SPARQL allows to express all kinds of CRUD operations
* SPARQL already has builtin concepts of separation/federation (GRAPHS and SERVICES)
* SPARQL has bindings for all kind of performant storage engines (SQL databases, graph databases, ...)

In the spike, we demonstrate how
* a SPARQL query posted to a federating service named *central* (with some extended http headers) will be 
  1. first converted and validated into a connector-plane artifact request of type "sparql"
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
  
#### Additional Data-Plane Headers

* **catenax-connector-context** the sequence of connector-ids which have (recursively) initiated this request (in reverse order, e.g. "urn:connector:central:semantics:catenax:net;urn:connector:app:semantics:catenax:net") 
* **catenax-security-token** the security token which is first validated against the **catenax-connector-context** in order to obtain request claims which maybe validated against the requested assets` policies in a second step
* **catenax-correlation-id** a traceable (and sufficiently unique) identifier that will annotate all correlated requests. Correlated requests should not recurse.

#### Additional Connector-Plane (Data Destination/Claim/Policy-Function) Properties

* **catenax-request-type** the concrete type of triple request issued (SELECT, INSERT, DELETE, SUBSCRIBE)
* **catenax-request-location** the internal address/URN of the targetted asset
* **catenax-request-graph** the schema/graph of the targetted asset
* **catenax-request-token** a security token that is to be forwarded to the targetted asset
* **ids:origin** extends the "single-connector-id" claim/policy function to represent and match above sequence
* **cx:union-asset** represent and match a set of graph (=sub-asset) names which are to be aggregated, e.g. ("urn:tenant1:PrivateGraph;urn:x-arq:Default-Graph")

The latter two policy functions/claim properties are used in conjunction with a regular expression string and the following
two operators: 
* with the EQ Operator, the regular expression needs to match the complete sequence/set 
* with the IN Operator, the regular expression needs to match ALL components of the sequence/set 

#### Important Packages and Classes 

* [net.catenax.semantics.triples.SparqlHelper](src/main/java/net/catenax/semantics/triples/SparqlHelper.java) A REST client for an internal plane (Fuseki) triple engine/store which implements the actual SparQL und TTL endpoints. At this level, all calls are synchronous. The Fuseki engine has been extended to forward all headers with "catenax" prefix to any outgoing federation calls.
* [net.catenax.semantics.connector.TripleDataPlaneExtension](src/main/java/net/catenax/semantics/connector/TripleDataPlaneExtension.java) The Eclipse Dataspace Connector extension which 
  * exposes all data and connector plane controllers
  * registers policy extensions
  * registers all synchronous and asynchronous data flows
  * creates two federated policies
    * co-policy-local: Used for all assets having "Private" in their id. Will only allow "single-level" (non-federated) calls.
    * co-policy-central: Used for all other assets. Federation and level-one distribution is allowed under the duty of duplicating the federated read permissions.  
  * registers all assets 
  * initiates all asynchronous subscriptions to remote assets 
* [net.catenax.semantics.connector.FederatedArtifactRequestController](src/main/java/net/catenax/semantics/connector/FederatedArtifactRequestController.java) An extension/replacement to the standard (but slightly refactored) standard IDS request controller. Firstly, it copes with requests which target/join multiple assets at once. Secondly, it evaluates the policies/permissions in the presence of an adhoc or derived request type. For example, if a policy has several READ and UPDATE permissions under the SELECT command, it is enough to find a single READ rule without problems to validate the policy.
* [net.catenax.semantics.connector.sparql](src/main/java/net/catenax/semantics/connector/sparql) This package hosts all extensions related to synchronous SparQL API
  * [net.catenax.semantics.connector.sparql.SparqlSynchronousApi](src/main/java/net/catenax/semantics/connector/sparql/SparqlSynchronousApi.java) This data plane controller translates/delegates incoming SparQL requests into the connector plane and waits for the transfer process to finish. Therefore, it registers also as a listener to the TransferProcessManager.
  * [net.catenax.semantics.connector.sparql.SparqlSynchronousDataflow](src/main/java/net/catenax/semantics/connector/sparql/SparqlSynchronousDataflow.java) The data flow controller is invoked by the connector to issue a synchronous SparQL request to an internal service (which by itself may again invoke a data plane API) and writes the result back into the transfer process.
* [net.catenax.semantics.connector.turtle](src/main/java/net/catenax/semantics/connector/turtle) This package hosts all extensions related to the asynchronous Turtle API
  * [net.catenax.semantics.connector.turtle.TurtleAsynchronousDataflow](src/main/java/net/catenax/semantics/connector/turtle/TurtleAsynchronousDataflow.java) This data flow controller is invoked by the connector to initiate a streaming subscription. Each time an internal TURTLE file event is triggered, it will publish that file to the given data destination.
  * [net.catenax.semantics.connector.turtle.TurtleAsynchronousApi](src/main/java/net/catenax/semantics/connector/turtle/TurtleAsynchronousApi.java) This data plane controller is invoked as the result of the publish action. It delegates to an internal triple database and may itself initiate a propagation event.
* [net.catenax.semantics.connector.policy](src/main/java/net/catenax/semantics/connector/policy) This package hosts all extensions related to IDS policies
  * [net.catenax.semantics.connector.policy.ConnectorOriginMatchFunction](src/main/java/net/catenax/semantics/connector/policy/ConnectorOriginMatchFunction.java) The "ids:origin" function to regex-match the sequence of calling connector ids
  * [net.catenax.semantics.connector.policy.UnionAssetMatchFunction](src/main/java/net/catenax/semantics/connector/policy/UnionAssetMatchFunction.java) The "cx:union-asset" function to regex-match the set of unioned assets
  * [net.catenax.semantics.connector.policy.CrossConnectorPolicy](src/main/java/net/catenax/semantics/connector/policy/CrossConnectorPolicy.java) Builds and evaluates federation policies where permission is given if a single rule matching the current request type has no problems associated.

## How to build and run

### Build complete repo with sub-modules EDC and Fuseki and run a (non-sovereign) internal triple store with separate endpoints for different tenants

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

Here is an example, where federated access is restricted by policies:

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
        SERVICE <http://localhost:8183/api/sparql/hub> { 
            {
                ?aspect rdf:type bamm:Aspect .
            }
            UNION
            {
                GRAPH <urn:tenant2:PrivateGraph> { 
                    ?aspect rdf:type bamm:Aspect .
                }
            }
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
-H "catenax-correlation-id: 42" \
-H "catenax-connector-context: urn:connector:tenant1:semantics:catenax:net" \
--form 'file=@BAMMmodels/com.catenax/0.0.1/TechnicalData.ttl' \
--form 'graph="urn:tenant1:PropagateGraph"'
```

```
curl -X POST 'http://localhost:8183/api/turtle/hub' \
-H "catenax-security-token: mock-eu" \
-H "catenax-correlation-id: 43" \
-H "catenax-connector-context: urn:connector:tenant2:semantics:catenax:net" \
--form 'file=@BAMMmodels/com.catenax/0.1.1/QualityAlert.ttl' \
--form 'graph="urn:tenant2:PropagateGraph"'
```
