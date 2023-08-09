---
sidebar_position: 7
title: Detailed Architecture
---

This document describes the detailed Architecture of the Agents Standard and Kit based on ARC42 standard.

## Introduction and Goals

The main objective concerning the approach described in this section is to create a state-of-the-art compute-to-data architecture for automotive use cases (and beyond) based on standards and best practices around GAIA-X and W3C. To reach this aim, full semantic integration, search and query with focus on relations between entities and data sovereignty is focused. In contrast to a simple file-based data transfer, this shifts the responsibility for the access, authorization to the data and processing of the data from the application development to the provider and hence ultimately, the actual owner of the data. To achieve this aim, the Knowledge Agent standard shall achieve the following abilities:

* the ability to define well-formed and composable computations/scripts (skills) which operate over various assets of various business partners.
* the ability to invoke and dynamically distribute these (sub-)skills over the relevant partners/connectors using an extensible agent interface.
* the ability to safely provide data and service assets via appropriate agent implementations which "bind" the skill to the backend execution engines (rather than mapping data).
* the ability for an agent/connector/business partner to decide
  * whether to hide particular data and computations inside a sub-skill
  * whether to delegate/federate particular computations/sub-skills to other agents
  * whether to migrate or clone an agent/asset from a partner
* the ability to describe data and service assets as well as appropriate federation policies in the IDS vocabulary in order to allow for a dynamic matchmaking of skills and agents.
* the ability to define domain/use case-based ontologies which form the vocabulary used in the skill definitions.
* the ability to visualize and develop the ontologies and skills in appropriate SDKs and User Experience components.

See also the KIT [Introduction](../adoption-view/intro) section and The [High-Level Architecture](architecture).

## Constraints

The Knowledge Agents Architecture is based on the Catena-X Dataspace Architecture with a specific focus on the Eclipse Dataspace Connector (EDC). It integrates with Catena-X Portal/Core Services & Identity Management principles and supports the typical interaction models as required by Catena-X Use Cases, such as
* Traceability with Focus on Low-Volume Bills-Of-Material Data and Deep Supply Chains with One-Up and One-Down Visibility
* Behaviour Twin with Focus on High-Volume Telematics Data and Flat and Trustful Supply Chain  

Furthermore, on the vocabulary/script level it utilizes and extends well-defined profiles of W3C Semantic Web Standards, such as OWL, RDF, SHACL, SPARQL.

## Context and Scope

The standard is relevant for the following roles:

- Business Application Provider
- Enablement Service Provider
- Data Consumer
- Data Provider

The following Catena-X stakeholders are affected by Knowledge Agent approach

- **Business Application Provider:** Applications that use KA technology on behalf of a Dataspace Participant (e.g. a Fleet Monitor, an Incident Reporting Solution).

- **Enablement Service Provider:** Services to assist Dataspace Participants/Applications in processing data based on KA technology (e.g. a Graph Database, a Virtual Graph Binding Engine, an EDC Package).
As a second path, Companies are addressed that want to provide compute resources (for example by a server or other KA-enabled Applications or Services) based on instances/configurations of KA-enabled EDC Packages, for example a Recycling Software Specialist

- **Data Consumer:** Companies that want to use data and logic (for example by KA-enabled Applications or Services) based on instances/configurations of KA-enabled EDC Packages, such as a Recycling Company or a Tier-2 Automotive Supplier
- **Data Provider:** Companies that want to provide data (for example by a backend database or other KA-enabled Applications or Services) based on instances/configurations of KA-enabled EDC Packages, for example an Automotive OEM. Companies that want to provide functions (for example by a REST endpoint or other KA-enabled Applications or Services) based on instances/configurations of KA-enabled EDC Packages, for example a Tier1 Sensor Device Supplier

Content-wise the following capabilities of Catena-X are addressed:

- Query and Search (Basic Mechanism, Integration in User Experiences)
- Services for making use of various federated data sources being part of a data space (Data & Function Provisioning, Logic Development & Provisioning)
- Semantic Modelling
- Publishing, Negotiation, Transfer Protocols and Policy Enforcement via IDS (EDC) connector

## Solution Strategy

Knowledge Agents regards the peer-to-peer Dataspace as one large (virtual) knowledge graph.

A graph, because the representation of data as a set of Triples (Outgoing-Node = Subject, Edge = Predicate, Receiving-Node = Object) is the highest form of normalization to which all other forms of structured data can be abstracted.

Virtual, because this graph is not centrally instantiated in a dedicated database, but it is manifested by a computation (traversal) which jumps from node to node (and hereby: from the sovereignity domain of one business partner to the another one including taking over authentication and authorization information).  

Knowledge because computations and graph contents are not arbitrary, but share common meta-data (again in the form of a graph interlinked with the actual instance graph) such that the vocabulary (at least: edge names) is standardized and computations can be formulated (offered)  independent of the data.

To reach that metaphor, the Knowledge Agents Architecture uses the following specifications, some of which are standard-relevant:

    * A general description language based on the Resource Description Framework (RDF)
    * A Meta-Model defined by OWL-R
    * A platform Ontology (consisting of several domain ontologies) as the Semantic Model
    * A description of graphs (=graph assets) which contain instance data for the Semantic Model (or: use-case driven and role-driven subsets thereof) and which may be described as SHACL constraints
    * A query language to traverse the graphs in SparQL and store these queries as skills (=skill assets) in the database

Non-standard relevant, but provided as a best practice/blueprint architecture are

    * Bindings for relational and functional data
      * R2RML or OBDA for relational data
      * RDF4J/SAIL configuration for REST remoting
    * SQL- and REST-based Virtualizers which bridge public Dataspace Operations with internal/private backend systems/data sources.

  [![Example_Graph_Standards](/img/Example_Graph.jpg)](/img/Example_Graph.jpg)

Knowledge Agents regards the peer-to-peer Dataspace as one large federated execution engine.

Federation means distributed that is there is no central endpoint/resource which controls the computation, but the execution may be entered/triggered on any tenant and uses a scalable set of resources which are contributed by each participant.

Federation means independent in that there is no central authentication/authorization regime, but the computation is validated, controled and (transparently) delegated by decentral policies as given/defined be each particpant.

See also [High-Level Architecture](architecture).

## Building Block View

See chapter [Layers & Modules](modules)

[![Architecture High-Level](/img/knowledge_agent_architecture_small.png)](/img/knowledge_agent_architecture.png)
 
## Runtime View

[![Runtime View2](/img/Runtime_View3.png)](/img/Runtime_View3.png)

Sequence of actions:

    A data provider provides a self description of the piece of knowledge he likes to provide including the terms of conditions in his own data catalogue
        * Graph assets describe
          * node classes
          * relations (arity) and 
          * constraints on nodes and relations (temporal, value ranges, ...) 
          * constraints on the queries/skills that may be executed on the graph
        * Graph usage policies can restrict the following operations on graphs (given an execution context)
          * selection
          * traversion
          * the storage
          * the manipulation and the
          * deletion of nodes and relations  
    A data provider marks particular graph assets as being visible in the federated data catalog. The federated data catalogues of the federated companies/EDCs will be automatically synchronized.
    Any consuming app can employ an agent with a suitable skill/query (which can be provided locally or as a remote asset, too)
    The agent will match the requirements in the skill with the offers in the federated data catalog to fill in the endpoints and usage policies from the self description. Optional: If necessary, needed attributes/claims have to be requested from a suitable issuer to get the verifiable credentials into the wallet.
    Agreements (between XA, XC, eventually between XB) have to be set up in such a way that the corresponding agents will be available through the data plane. Optional: Within EDC the contracts are negotiated and the needed attributes/claims are verified (see PEP, PDP and PIP).
    The agent delegates a sub-query/sub-skill to the respective knowledge owners (data provider) for the knowledge via an instance of EDC. It annotates the sub-queries with a call context which contains the EDC/agent calling sequence and the other assets with which the result data → ohne data oder resulting data will be joined.
    The data plane will validate the calling context together with the claims inside the agreement token. → im Schaubild gibt es zweimal Schritt "7"; eine der Beschreibungen fehlt hier also, oder?
    The agent executes the actual query by mapping to a backend data system and finally provides the app the result → "provides the result to the app"? → auf "8" kommt zweimal vor; einmal als "bind" Schritt ins Backend, einmal als request
    The agent can decide to delegate further down the line → sollte das auch im Schaubild zu sehen sein?

## Deployment View

See chapter [Deployment](../operation-view/deployment).

## Crosscutting Concepts

## Architectural Decisions

## Quality Requirements

## Risks & Technical Debt

## Glossary

The App in the figure serves the Consumer by gathering, analyzing, and presenting the knowledge about business questions such as: How much of a certain material can be found in a different vehicle series? It is assumed that the data which is needed to answer such questions is distributed over the network and cannot be found at one central place.

### Skill

To help collecting the data over the network, Skills are introduced. A Skill is a pre-formulated query (or: procedure) with limited scope such as: List all vehicle series that contain ?material produced in ?location. The Skill is used to access all federated data instances via the tenant (=authentication and authorization scope) of the caller. A skill receives input in the form of a data set [{?material:“Rubber”,?location:“Phuket”}] which drives the control flow, the filtering and aggregating  of the information, and finally producing an output data set [{?series:<4711>,?oem:&lt;OEM&gt;,?weightKg:”3.2”},{?series:&lt;0815&gt;,?oem:&lt;EMO&gt;, ?weightKg:”1.4”}]}.

### Semantic Model

In order to obtain the correct results in a federated system, all the participants of the skill execution need to have common understanding (Semantic Model, in KA this is mechanized by a Federated Catalogue based on the Web Ontology Language  OWL) over the vocabulary (Data Model, in KA this is represented generically by sets, i.e., graphs of Resource Description Framework RDF triples). Relying on these conventions, a Skill executor can calculate which Providers are able to contribute or yield the necessary information in which sequence such that the resulting distributed operation will be performant.

### Matchmaking Agent

This coordinating job is taken over by the Matchmaking Agent, an endpoint that is mandatory for any KA-enabled Dataspace Participant. For that purpose, the Matchmaking Agent supports the SparQL specification with the effect that the dataspace can be traversed as one large data structure. Hereby, the Consumer-Side Matchmaking Agent will – as driven by the builtin federation features of SparQL - interact with the KA-enabled EDC in order to negotiate and perform the transfer of Sub-Skills (=SparQL Contexts) to other Dataspace Participants.

### Binding Agent

In turn, upon successful transfer of the Sub-Skill, the Provider-Side Matchmaking Agent(s) will be activated by their respective EDC. Prior to such a success, the Provider EDC of course first needs to offer a so-called Graph Asset: Graph Assets are a variant of ordinary Data Assets in the Catena-X EDC Standard; while Data Asset typically refer to an actual backend system (e.g., an Blob in an ObjectStorey, an AAS server, a REST endpoint), Graph Assets introduce another intermediary instance, the so-called Binding Agent.

Simply put, the Binding Agent is a restricted version of the Matchmaking Agent (subset of OWL/SparQL, e.g., without federation) which is just focused on translating Sub-Skils of a particular business domain (Bill-Of-Material, Chemical Materials, Production Sites, etc.)  into proper SQL- or REST based backend system calls. This scheme has several advantages:

* For different types of backend systems, business domains and usage scenarios, different Binding Agent implementations (Caching Graph Store, SQL Binding Engine, REST Binding Engine) can be switched-in without affecting both the shared dataspace/semantic model and the mostly immutable backend systems/data models as well.
* Access to the backend systems can be optimized by JIT compilation technology.
* The same backend system/data model can be used in various Graph Assets/Use Cases und different roles and policies.
* Access to the backend system is decoupled by another layer of security, such that additional types of policies (role-based row-level and attribute-level access) can be implemented in the interplay of Matchmaking and Binding Agents.
* There is a clear distinction between advanced graph operations (including type inference and transitive/recursive traversal also via EDC) on the Matchmaking Level and efficient, but more restricted and secure graph operations on the Binding/Data Level.

### Federated Catalogue

As mentioned earlier, essential for the realization of the idea is the creation, governance and discoverability of a well-defined semantic catalogue, which forms together with the data a Federated Knowledge Graph. In this context, the definition of a Knowledge Graph (KG) as "a multi relational graph composed of entities and relations which are regarded as nodes and different types of edges, respectively" is extended with aspect of federation. We see a Federated KG as a KG where entities and relations reside physically distributed over multiple systems connected through a network and a common query language. We see semantic metadata as structural information to scope the entities and relations of the KG based on ontological principles. This is the agreement, necessary for the successful interplay of the distributed parties within the data space.


