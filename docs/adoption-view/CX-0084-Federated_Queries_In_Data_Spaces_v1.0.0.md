# CX - 0084 Federated Queries in Data Spaces (Knowledge Agents) v.1.0.0

**Contributer:**
Dr. Tom Buchert (T-Systems)
Dr. Christoph G. Jung (T-Systems)
Rolf Bosse (Mercedes-Benz GmbH)

## Table of Contents

- [CX - 0084 Federated Queries in Data Spaces (Knowledge Agents) v.1.0.0](#cx---0084-federated-queries-in-data-spaces-knowledge-agents-v100)
  - [Table of Contents](#table-of-contents)
  - [ABOUT THIS DOCUMENT \& MOTIVATION](#about-this-document--motivation)
  - [DISCLAIMER \& LIABILITY](#disclaimer--liability)
  - [REVISIONS \& UPDATE](#revisions--update)
  - [COPYRIGHT \& TRADEMARKS](#copyright--trademarks)
  - [ABSTRACT](#abstract)
  - [1. INTRODUCTION](#1-introduction)
    - [1.1 AUDIENCE \& SCOPE](#11-audience--scope)
    - [1.2 CONTEXT](#12-context)
    - [1.3 ARCHITECTURE OVERVIEW](#13-architecture-overview)
    - [1.4 CONFORMANCE](#14-conformance)
    - [1.5 PROOF OF CONFORMITY](#15-proof-of-conformity)
  - [2. Conformity Assessment Criteria](#2-conformity-assessment-criteria)
    - [2.1 CAC for EDC](#21-cac-for-edc)
    - [2.2 CAC for Matchmaking Agent](#22-cac-for-matchmaking-agent)
    - [2.3 CAC for Federated Data Catalogue](#23-cac-for-federated-data-catalogue)
    - [2.4 CAC for Binding Agent](#24-cac-for-binding-agents)
    - [2.5 CAC for Ontology Hub](#25-cac-for-ontology-hub)
  - [3 REFERENCES](#3-references)
    - [3.1 NORMATIVE REFERENCES](#31-normative-references)
  - [ANNEXES](#annexes)
    - [KA-BIND](#ka-bind)
    - [KA-MATCH](#ka-match)
    - [KA-TRANSFER](#ka-transfer)

## ABOUT THIS DOCUMENT & MOTIVATION

## DISCLAIMER & LIABILITY

## REVISIONS & UPDATE

## COPYRIGHT & TRADEMARKS

## ABSTRACT

This document provides a standard for a semantically-driven and state-of-the-art compute-to-data architecture for Catena-X, the so called Knowledge Agents approach. It builds on well-established W3C-standards of the semantic web, such as OWL, SPARQL, SHACL, RDF etc. and makes these protocols usable to formulate powerful queries to the data space. Those queries can be used to answer business questions directly (comparable to a search engine) or they can be embedded in apps to include query results into workflows with more advanced visualization etc. The document addresses all stakeholders in Catena-X context that want to exchange data via the knowledge agents approach (data providers and consumers as well as app- and enablement service providers).

## 1. INTRODUCTION

### 1.1 AUDIENCE & SCOPE

> _This section is non-normative_

In the following, we call one of the following affected stakeholders/solutions KA-enabled if it passes the Conformity Assessment Criteria (CAC, see Section 1.2 and Chapter 2):

- **Business Application Provider:** Applications that use KA technology on behalf of a Dataspace Participant (e.g. a Fleet Monitor, an Incident Reporting Solution).

- **Enablement Service Provider:** Services to assist Dataspace Participants/Applications in processing data based on KA technology (e.g. a Graph Database, a Virtual Graph Binding Engine, an EDC Package).
As a second path, Companies are addressed that want to provide compute resources (for example by a server or other KA-enabled Applications or Services) based on instances/configurations of KA-enabled EDC Packages, for example a Recycling Software Specialist

- **Data Consumer:** Companies that want to use data and logic (for example by KA-enabled Applications or Services) based on instances/configurations of KA-enabled EDC Packages, such as a Recycling Company or a Tier-2 Automotive Supplier
- **Data Provider:** Companies that want to provide data (for example by a backend database or other KA-enabled Applications or Services) based on instances/configurations of KA-enabled EDC Packages, for example an Automotive OEM. Companies that want to provide functions (for example by a REST endpoint or other KA-enabled Applications or Services) based on instances/configurations of KA-enabled EDC Packages, for example a Tier1 Sensor Device Supplier

The CAC formulated in this standard comprise the following scope:

- Query and Search (Basic Mechanism, Integration in User Experiences
- Services for making use of various federated data sources being part of a data space (Data & Function Provisioning, Logic Development & Provisioning)
- Semantic Modelling
- Publishing, Negotiation, Transfer Protocols and Policy Enforcement via IDS (EDC) connector

### 1.2 CONTEXT

> _This section is non-normative_

The main objective concerning the approach described in this section is to create a state-of-the-art compute-to-data architecture for automotive use cases (and beyond) based on standards and best practices around GAIA, W3C a. To reach this aim, full semantic integration, search and query with focus on relations between entities and data sovereignty is focused. In contrast to a simple file-based data transfer, this shifts the responsibility for the

1. access,
2. authorization to the data and
3. processing of the data

from the application development to the provider and hence ultimately, the actual owner of the data.

[![Architecture Interaction](/img/architecture_small.png)](/img/architecture.png)

Figure 1: Basic Overview about Knowledge Agents approach

The most important concepts needed for the realization are summarized in Figure 1. The App in the figure serves the consumer by gathering, analyzing, and presenting the knowledge about business questions such as: How much of a certain material can be found in a specific vehicle series? It is assumed that the data which is needed to answer such questions is distributed over the network and cannot be found at one central place.

To help collecting the data over the network, **Skills** are introduced. A Skill is a pre-formulated query (or: procedure) with limited scope such as: List all vehicle series that contain material produced in a certain location. The Skill is used to access all federated data instances via the tenant (= authentication and authorization scope) of the caller. The following paragraph shows an example how a skill could look like with SPARQL syntax:

A skill receives input in the form of a data set

[{?material:“Rubber”,?location:“Phuket”}]

which drives the control flow, the filtering and aggregating  of the information, and finally producing an output data set

[{?series:<4711>,?oem:&lt;OEM&gt;,?weightKg:”3.2”},{?series:<0815>,?oem:&lt;EMO&gt;, ?weightKg:”1.4”}]}.

In order to obtain the correct results in a federated system, all the participants of the skill execution need to have common understanding over the vocabulary (see following chapter). Relying on these conventions, an executor of a skill can calculate which providers are able to contribute or yield the necessary information in which sequence such that the resulting distributed operation will be performant.

This coordinating job is taken over by the **Matchmaking Agent**, an endpoint that is required for any KA-enabled Dataspace Participant. For that purpose, the Matchmaking Agent supports the SparQL specification with the effect that the dataspace can be traversed as one large data structure. Hereby, the Consumer-Side Matchmaking Agent will – as driven by the builtin federation features of SparQL - interact with the KA-enabled EDC in order to negotiate and perform the transfer of Sub-Skills (=SparQL Contexts) to other Dataspace Participants.
In turn, upon successful transfer of the Sub-Skill, the Provider-Side Matchmaking Agent(s) will be activated by their respective EDC. Prior to such a success, the Provider EDC of course first needs to offer a so-called Graph Asset:

**Graph Assets** are a variant of ordinary Data Assets in the Catena-X EDC Standard; while Data Asset typically refer to an actual backend system (e.g., an Blob in an Object Store, an AAS server, a REST endpoint), Graph Assets introduce another intermediary instance, the so-called Binding Agent.

Simply put, the **Binding Agent** is a restricted version of the Matchmaking Agent (subset of OWL/SparQL, e.g., without federation) which is just focused on translating Sub-Skils of a particular business domain (Bill-Of-Material, Chemical Materials, Production Sites, etc.)  into proper SQL- or REST based backend system calls. This scheme has several advantages:

- For different types of backend systems, business domains and usage scenarios, different Binding Agent implementations (Caching Graph Store, SQL Binding Engine, REST Binding Engine) can be switched-in without affecting both the shared dataspace/semantic model and the mostly immutable backend systems/data models as well.
- Access to the backend systems can be optimized by JIT compilation technology.
- The same backend system/data model can be used in various Graph Assets/Use Cases und different roles and policies.
- Access to the backend system is decoupled by another layer of security, such that additional types of policies (role-based row-level and attribute-level access) can be implemented in the interplay of Matchmaking and Binding Agents.
- There is a clear distinction between advanced graph operations (including type inference and transitive/recursive traversal also via EDC) on the Matchmaking Level and efficient, but more restricted and secure graph operations on the Binding/Data Level.

As mentioned earlier, essential for the realization of the idea is the creation, governance and discoverability of a well-defined semantic catalogue, which forms together with the data a **Federated Knowledge Graph**. In this context, the definition of a Knowledge Graph (KG) as "a multi relational graph composed of entities and relations which are regarded as nodes and different types of edges, respectively" is extended with aspect of federation. We see a Federated KG as a KG where entities and relations reside physically distributed over multiple systems connected through a network and a common query language. We see semantic metadata as structural information to scope the entities and relations of the KG based on ontological principles. This is the agreement, necessary for the successful interplay of the distributed parties within the data space.

To summarize, the Knowledge Agent standard shall achieve the following abilities:

- the ability to define well-formed and composable computations/scripts (skills) which operate over various assets of various business partners.
- the ability to invoke and dynamically distribute these (sub-)skills over the relevant partners/connectors using an extensible agent interface.
- the ability to safely provide data and service assets via appropriate agent implementations which "bind" the skill to the backend execution engines (rather than mapping data).
- the ability for an agent/connector/business partner to decide
  - whether to hide particular data and computations inside a sub-skill
  - whether to delegate/federate particular computations/sub-skills to other agents
  - whether to migrate or clone an agent/asset from a partner
- the ability to describe data and service assets as well as appropriate federation policies in the IDS vocabulary in order to allow for a dynamic matchmaking of skills and agents.
- the ability to define domain/use case-based ontologies which form the vocabulary used in the skill definitions.
- the ability to visualize and develop the ontologies and skills in appropriate SDKs and User Experience components.

### 1.3 ARCHITECTURE OVERVIEW

> _This section is non-normative_

This chapter gives an overview how the concept elaborated in previous chapter should be implemented. In this context generic building blocks were defined (see Figure 3) which can be implemented with different open source or COTS solutions. In the scope of Catena-X project these building blocks are instantiated with a reference implementation based on open source components (the Knowledge Agents KIT). The detailed architecture following this reference implementation can be found here: <https://catenax-ng.github.io/product-knowledge/docs/architecture>.

[![Architecture High-Level](/img/layer_architecture_small.png)](/img/layer_architecture.png)

Figure 3: KA building blocks (Solid-Lines Denote Standard-Affected Layers & Components)

In the following paragraphs, all building blocks relevant for this standard are introduced:

#### Semantic (Ontology) Models

Ontologies, as defined by W3C Web Ontology Language OWL 2 (<https://www.w3.org/OWL/>) standard, provide the core of the KA catalogue. OWL comes with several interpretation profiles (<https://www.w3.org/TR/owl2-profiles/>) for different types of applications. For model checking and data validation (not part of this standard), the Rule Logic (RL) profile is used. For query answering/data processing (part of this standard), the Existential Logic (EL) profile (on the Dataspace Layer) and the Query Logic (QL) profile (on the Binding Layer) is used. Furthermore, RDF Terse Triple Language TTL (<https://www.w3.org/TR/turtle/>) format is used to divide/merge large ontologies into/from modular domain ontology files.

Semantic Models are hosted in the Ontology Hub that is a central service to the dataspace.

#### Data Consumption Layer/Query Definition

This layer comprises all applications which utilize provided data and functions of business partners to achieve a direct business impact and frameworks which simplify the development of these applications. Thus, this layer focuses on using a released Semantic Model (or a use-case/role-specific excerpt thereof) as a vocabulary to build flexible queries (Skills) and integrating these Skills in data consuming apps. Skills can be easily integrated in these apps as stored procedure. Hence, skill and app development can be decoupled to increase efficiency of the app development process.

SPARQL 1.1 specification (<https://www.w3.org/TR/sparql11-query/>) is used as a language and protocol to search for and process data across different business partners. As a part of this specification,  the QUERY RESULTS JSON (<https://www.w3.org/TR/sparql11-results-json/>) and the QUERY RESULTS XML (<https://www.w3.org/TR/rdf-sparql-XMLres/>) formats are used to represent both the answer sets generated by SPARQL skills and the sets of input parameters that a SPARQL skill should be applied to. For answer sets, additional formats such as the QUERY RESULTS CSV and TSV (<https://www.w3.org/TR/sparql11-results-csv-tsv/>) format may be supported. Required is the ability to store and invoke SPARQL queries as parameterized procedures in the dataspace; this is a KA-specific extension to the SPARQL endpoint and is captured a concise Openapi specification in the following (<https://catenax-ng.github.io/product-knowledge/docs/development-view/api>). Also part of that specification is an extended response behaviour which introduces the warning status code “203” and a response header “cx_warning” bound to a JSON structure that lists abnormal events or trace information that appeared during the processing.

#### Dataspace Layer

The base Dataspace-building technology is the Eclipse Dataspace Connector (EDC) which should be extended to operate as a HTTP/S contracting & transfer facility for the SPARQL-speaking Matchmaking Agent. To resolve dataspace offers and addresses using the ontological vocabulary, the Matchmaking Agent keeps a default meta-graph, the Federated Catalogue, that is used to host the Semantic Model and that is regularly synchronized with the relevant dataspace information including the offers of surrounding business partners/EDCs.

The EDC interacts with the so-called Matchmaking Agent which is the first stage of SPARQL processing. It operates as the main invocation point to the Data Consuming Layer. Furthermore, It operates as the main bridging point between incoming EDC transfers (from an “Agent Source”) and the underlying Binding Layer. And it implements federation by delegating any outgoing SERVICE/GRAPH contexts to the EDC.

[![Dataspace Layer](/img/dataspace_layer_small.png)](/img/dataspace_layer.png)

Figure 4: Standard-Affected Dataspace Components

Since EDC and Matchmaking Agent are bidirectionally coupled, implementations could merge Data Plane and Matchmaking Agent into a single package, the so-called Agent Plane. Agent Planes and ordinary Data Planes can co-exist due to our design choices.

The so called Federated Catalogue is an RDF data storage facility for the Matchmaking Agent. It could be an in-memory triple store (that is restored via downloading TTL and configuration files upon restart) or an ordinary relational database that has been adapted to fit to the chosen Matchmaking Agent implementation. One example of such an interface is the RDF4J SAIL compliant to all RDF4J based SPARQL engines.

The Federated Catalogue should initially download the complete Semantic Model that has been released for the target environment from the Ontology Hub. It should also contain a list of business partners and their roles which form the surrounding dataspace neighborhood of the tenant. For that purpose, It could use GPDM and Self-Description Hub services in order to lookup EDC addresses and additional domain information (sites, geo addresses). It should then be frequently updated with “live” information by invoking the EDC data management API to regularly obtain catalogue information.
The portion of the Semantic Model describing these meta-data (Business Partners, Sites, Addresses, Use Cases, Use Case Roles, Connectors & Assets) is called the Common domain ontology and is mandatory for all releases/excerpts of the Semantic Model (<https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/common_ontology.ttl>).

#### Backend Systems

Legacy IT landscape of data space participants consisting of various backend systems, such as PLM, ERP, ObjectStores mostly located in the Enterprise Intranet and hosted/goverened by the business departments. Here, the actual data sources of all Catena-X participants is originated where they are served using custom, but mission-critical business or technological APIs in specific, transaction-oriented formats.

#### Virtualization Layer

The data virtualization layer fulfills the function of making the company internal, department-hosted data available for cross-company data exchange scenarios, e.g. via data lakes, data warehouses or other enterprise middleware. Instead of connecting each and every backend system separatly to an external data source/sink (such as Catena-X) it often makes sense to have this additional layer on top of backend systems which orchestrates data demand and supply across the systems. Depending on company IT architecture different technologies can be used to build up this layer.

#### Binding Layer

Finally, the missing link between the Dataspace Layer and the Virtualization Layer is the Binding Layer. Hereby rather than mapping the data between different formats (e.g. Data Tables in CSV Format to and from Data Graphs in the TTL format) which is a mostly resource-consuming data transformation process, binding rather rewrites the actual queries (e.g. SPARQL into SQL, SPARQL into GraphQL or REST). In order to make this query rewriting not too complicated, a restricted subset of SPARQL is envisaged.

### 1.4 CONFORMANCE

As well as sections marked as non-normative, all authoring guidelines, diagrams, examples, and notes
in this specification are non-normative. Everything else in this specification is normative.

The key words **MAY**, **MUST**, **MUST NOT**, **OPTIONAL**, **RECOMMENDED**, **REQUIRED**, **SHOULD**
and **SHOULD NOT** in this document document are to be interpreted as described in BCP 14 [RFC2119] [RFC8174]
when, and only when, they appear in all capitals, as shown here.

### 1.5 PROOF OF CONFORMITY

> _This section is non-normative_

All participants and their solutions will need to proof, that they are conform with the Catena-X standards.
To validate that the standards are applied correctly, Catena-X employs Conformity Assessment Bodies (CABs).
Please refer to the association homepage for the process of conformity assessment and certification.

The Conformity Assessment Criteria (and proposed Conformity Assessment Methods) will be listed in Chapter 2 for the respective building blocks
that are relevant for KA Enablement.

Corresponding to this standard, a test bed is provided under [https://catenax-ng.github.io/product-knowledge/docs/adoption-view/testbed] which covers most of the
following CACs and CAMs.

## 2. Conformity Assessment Criteria

> _This section is normantive_

### 2.1 CAC for EDC

<table>
<thead>
 <tr>
  <th>Component</th>
  <th>Normative Statement</th>
  <th>Proposed Method</th>
 </tr>
</thead>
<tbody>
 <tr>
  <td>EDC Control Plane</td>
  <td>MUST conform to the CX EDC HTTP Standard,<br/> specifically MUST support the “HttpProxy” transfer process type</td>
  <td>See CX-0018</td>
 </tr>
 <tr>
  <td>EDC Control Plane</td>
  <td>MUST support the “HttpProtocol” transfer process type which <br/> operates as the “HttpProxy” standard, but additionally memorizes <br/> the “type” property of the transferred asset in  <br/> the endpoint data reference properties (as property “protocol”). <br/> When recreating the data address, this attribute is replacing the <br/> original “HttpData” constant.</td>
  <td>
 Configuration Review<br/> EDC property<br/> edc.dataplane.selector.*<br/> destinationtypes<br/> should contain<br/> HttpProtocol<br/>  <br/> CAB offers TESTGRAPHASSET<br/> Assessed Party performs 02_ALL_EDC&gt;<br/> 020101_EDC to successfully initiate a transfer<div></div></td>
 </tr>
 <tr>
  <td>EDC Control Plane</td>
  <td>MUST register at least one KA-Enabled Data Plane</td>
  <td>Configuration Review<br/> EDC property <br/> dc.dataplane.selector.*<br/> sourcetypes<br/> should contain<br/> urn:cx:Protocol:w3c:Http#SPARQL<div></div></td>
 </tr>
 <tr>
  <td>EDC Control Plane</td>
  <td>SHOULD support multiple endpoint callback listeners.<br/> MUST register at least one Matchmaking Agent <br/> callback endpoint as listener</td>
  <td>Code/Configuration Review<br/> EDC property <br/> edc.receiver.http<div></div></td>
 </tr>
 <tr>
  <td>EDC Control Plane</td>
  <td>MAY support an extended validation endpoint for extended <br/> graph policies which need access to a runtime context</td>
  <td>Assessed Party demonstrates an endpoint which accepts a <br/> DAPS-signed graph policy backed claim token together <br/> with a JSON object representing the runtime context.<div></div></td>
 </tr>
 <tr>
  <td>EDC <br/> Data <br/> Plane</td>
  <td>MUST conform to the CX EDC HTTP Standard, <br/> specifically MUST support the “HttpProxy” transfer process type <br/> in combination with the “HttpData” asset type<div></div></td>
  <td/>
 </tr>
 <tr>
  <td>EDC <br/> Data <br/> Plane</td>
  <td>MUST support the “HttpProtocol” transfer process type in <br/> combination with the “urn:cx:Protocol:w3c:Http#SPARQL” <br/> and “urn:cx:Protocol:w3c:Http#SKILL” asset types.<br/> The registered Source implementation MUST support the “cx_header” parameter. <br/> MUST support the “header:Accepts” and “header:Host” asset address properties.<br/> MUST require the “proxyBody”, “proxyQueryParams” and <br/> “proxyMethod” asset address properties to be true.<br/> MUST require the “proxyPath” asset address properties to be false.<br/> MUST rewrite the query (as parameter or body)  <br/> to replace all occurrences of the asset:prop:id property <br/> by the “baseUrl” property<br/> MAY rewrite the query driven by additional asset address properties (“cx:shape”)<br/> MAY validate the query using an extended validation <br/> endpoint in the Control Plane and by deriving <br/> additional runtime context from parsing the query and the payload<br/> MUST delegate to the Matchmaking Agent</td>
  <td>Code/Configuration Review<br/> Assessed Party offers<br/> TESTGRAPHASSET<br/> CAB performs<br/> 02_ALL_EDC&gt;<br/> 020201_EDC to successfully perform a transfer<div></div></td>
 </tr>
</tbody>
</table>

### 2.2 CAC for Matchmaking Agent

<table>
<thead>
 <tr>
  <th>Component</th>
  <th>Normative Statement</th>
  <th>Proposed Method</th>
 </tr>
</thead>
<tbody>
 <tr>
  <td>Matchmaking Agent</td>
  <td>MUST support an endpoint callback conforming to the CX EDC HTTP</td>
  <td>See CX-0018<br/> Assessed Party performs<br/> 02_ALL_EDC&gt;<br/> 020301_CALLBACK to simulate an endpoint callback<div></div></td>
 </tr>
 <tr>
  <td>Matchmaking Agent</td>
  <td>MUST execute “Service &lt;url&gt;” contexts where the <br/> url starts with the “edc” or “edcs” schema, <br/> by parsing the sub-context or the url <br/> for an assetName (url#assetName or “Graph &lt;assetName&gt;”) <br/> and subsequently engage into a “HttpProtocol” <br/> negotiation/transfer process with the Control plane addressed <br/> by the url when replacing the “edc” scheme <br/> with “http” and the “edcs” scheme with “https” respectively<br/> MAY perform “Service &lt;url&gt;” calls where url <br/> is bound to multiple addresses simultaneously</td>
  <td>CAB offers TESTGRAPHASSET<br/> Assessed Party performs<br/> 02_ALL_EDC&gt;<br/> 020302_DELEGATE to demonstrate successful delegation<div></div></td>
 </tr>
 <tr>
  <td>Matchmaking Agent</td>
  <td>MUST support the “/agent” GET endpoint <br/> of the KA SPARQL Openapi specification</td>
  <td>CAB offers TESTSKILLASSET<br/> Assessed Party performs<br/> 02_ALL_EDC&gt;<br/> 020302_GET to successfully demonstrate invocation variants and error behaviour<div></div></td>
 </tr>
 <tr>
  <td>Matchmaking Agent</td>
  <td>MUST support the “/agent” POST endpoint of the <br/> KA SPARQL Openapi specification</td>
  <td>CAB offers TESTSKILLASSET<br/> Assessed Party performs<br/> 02_ALL_EDC&gt;<br/> 020303_POST to successfully demonstrate invocation variants and error behaviour<div></div></td>
 </tr>
 <tr>
  <td>Matchmaking Agent</td>
  <td>MUST support the “/agent/register” POST endpoint <br/> of the KA SPARQL Openapi specification</td>
  <td>Assessed Party performs<br/> performs<br/> 02_ALL_EDC&gt;<br/> 020304_SKILL to successfully register a skill<div></div></td>
 </tr>
</tbody>
</table>

### 2.3 CAC for Federated Data Catalogue

<table>
<thead>
 <tr>
  <th>Component</th>
  <th>Normative Statement</th>
  <th>Proposed Method</th>
 </tr>
</thead>
<tbody>
 <tr>
  <td>Federated Catalog</td>
  <td>MUST contain data instantiating the Common Domain Ontology <br/> of the Semantic Model related to business partners of the assessed tenant</td>
  <td>Assessed Party performs<br/> 02_ALL_EDC&gt;<br/> 020402_COMMON to validate the available instance data<div></div></td>
 </tr>
 <tr>
  <td>Federated Catalog</td>
  <td>MUST frequently update catalogue data instantiating <br/> the Common Domain Ontology of the Semantic Model</td>
  <td>Assessed Party performs<br/> 02_ALL_EDC&gt;<br/> 020403_SYNC to validate the available instance data<div></div></td>
 </tr>
</tbody>
</table>

### 2.4 CAC for Binding Agents

<table>
<thead>
 <tr>
  <th>Component</th>
  <th>Normative Statement</th>
  <th>Proposed Method</th>
 </tr>
</thead>
<tbody>
 <tr>
  <td>Data Binding Agent (Only relevant for Enablement Service Provider)</td>
  <td>MUST implement the DATA RESTRICTED KA SPARQL profile</td>
  <td>Assessed Party performs<br/> 03_PROVIDER&gt;<br/> 030101_DATA to demonstrate profile support<div></div></td>
 </tr>
 <tr>
  <td>Function Binding Agent (Only relevant for Enablement Service Provider)</td>
  <td>MUST implement the FUNCTION RESTRICTED KA SPARQL profile</td>
  <td>Assessed Party performs<br/> 03_ PROVIDER&gt;<br/> 030102_FUNCTION to demonstrate profile support<div></div></td>
 </tr>
</tbody>
</table>

### 2.5 CAC for Ontology Hub

<table>
<thead>
 <tr>
  <th>Component</th>
  <th>Normative Statement</th>
  <th>Proposed Method</th>
 </tr>
</thead>
<tbody>
 <tr>
  <td>Ontology Hub</td>
  <td>MUST conform to the CX EDC HTTP Standard,<br/> specifically MUST support the “HttpProxy” transfer process type</td>
  <td>See CX-0018</td>
 </tr>
</tbody>
</table>

## 3 REFERENCES

### 3.1 NORMATIVE REFERENCES

- CX–0018 Sovereign Data Exchange
- [OWL 2 Web Ontology Language Profiles (Second Edition)](https://www.w3.org/TR/owl2-profiles/)
- [SPARQL 1.1 Query Language](https://www.w3.org/TR/sparql11-query/)
- [Functional Requirements for Internet Resource Locators](https://www.rfc-editor.org/rfc/rfc1736)
- [Functional Requirements for Unique Resource Names](https://www.rfc-editor.org/rfc/rfc1737)
- [Uniform Resource Locators](https://www.rfc-editor.org/rfc/rfc1738)
- [Internationalized Resource Identifiers](https://www.rfc-editor.org/rfc/rfc3987)

## ANNEXES

The SPARQL Protocol And RDF Query Language is a query language and protocol for the Semantic Web. SPARQL provides powerful constructs to search, filter, traverse and even update globally dispersed information written in the Resource Description Framework. In particular, it operates very well with self-contained sources which have been modelled using the Web Ontology Language OWL2.

OWL2 provides several profiles (language restrictions and/or computational barriers) with decreasing degrees of complexity and expressivity: RL (rule logic), EL (existential logic) and QL (query logic). The lower the degree, the more reasoning engines are likely to support the given profile in practical applications.

In that tradition, this document proposes three profiles for SPARQL

- KA-BIND for binding large-volume (virtual) data lakes and API gateways to RDF processing
- KA-MATCH building on KA-BIND for orchestrating non-trivial computations on the individual and sovereign RDF processors
- KA-TRANSFER for tunneling KA-MATCH invocations through inter-company HTTP proxy infrastructure

These profiles are meant to standardize the usage of SPARQL as a scripting language in Dataspaces.

Dataspaces are a peer-to-peer technology and requires to form contract agreements between multiple parties based on the actual data chains.

In Catena-X, for example, a Dataspace that is based on IDS/GAIA-X infrastructure, these data chains follow the deep supply chains of the Automotive Industry in order to derive previously impossible use cases in the areas of Traceability, Distributed Simulation, etc.  

The profiles defined in this document are implemented in the KA API specification (<https://catenax-ng.github.io/product-knowledge/docs/development-view/api>)

[![Dataspace Layer](/img/sparql_profiles_small.png)](/img/sparql_profiles.png)

### KA-BIND

KA-BIND restricts SPARQL 1.1 (<https://www.w3.org/TR/sparql11-query/>) in the following manner

- POST-GET: the endpoint should support the http verbs POST and GET
- CONTENT-TYPE: the endpoint should support at least "application/sparql-result+json" (default) and "application/sparql-result+xml" media types in its responses (and resolve the request Accepts header accordingly). The endpoint should support the "application/sparql-query" media type.
- ONLY-SELECT: only the Query Form SELECT is supported
- OWL-QL: only interoperates with the OWL2 QL profile
- DEFAULT-GRAPH: operates only on the default graph: No graph references (no GRAPH contexts, no FROM or TO clauses)
- NO-FEDERATION: no federation, i.e. interaction with remote services (no SERVICE contexts)
- BOUND-PREDICATES: no variables in the predicate of triple patterns
- NO-LITERAL-SUBJECT: no literals in the subject of triple patterns
- BOUND-TYPE-OBJECT: if the predicate is rdf:type/a then the object cannot be a variable
- NO-INVERSE: no inverse predicates (InversePath)
- NO-TRANSITIVITY: no transitive predicates (OneOrMorePath, ZeroOrMorePath, ZeroOrOnePath)
- NO-NEGATION: no negated predicates (NegatedPath)
- NO-BLANK-SOURCE-NODE: no blank nodes in the source documents (but working with anonymous nodes in the query is still allowed)

### KA-MATCH

Let DRN be the subset of URN (and hence IRI) which denote assets in the Dataspace. Examples are

```console
urn:cx:GraphAsset#TelematicsOEM
urn:cx:SkillAsset#RemainingUsefulLife
```

GDRN is the subset of DRN which denote proper graph assets.

SDRN is the subset of DRN which denote skill assets.

Let DRL be the subset of URL (and hence IRI) which denote connector addresses in the Dataspace using the schemes edc or edcs.

If the DRL contains with an anchor part (#), we call the DRL qualified and that anchor part must url-encode a valid DRN.

If the DRL contains parameters, we call all parameter values which start with "@" the variable references.

Examples are

```console
edc://consumer-connector.private:8199
edcs://oem-connector.public.io#urn%3Acx%3AGraphAsset%23TelematicsOEM
edcs://supplier-connector.public.io#urn%3Acx%3ASkillAsset%23RemaniningUsefulLife?vin=@vehicle&troubleCode=@dtc
```

KA-MATCH restricts SPARQL (<https://www.w3.org/TR/sparql11-query/>) in the following manner

- LIMITED-FEDERATION: any SERVICE context which binds to a DRL
  - if the DRL is unqualified, it must have EXACTLY ONE GRAPH sub-context which points to a GDRN. You may use only KA-BIND inside of that GRAPH context.
  - If the DRL is qualified:
    - if it anchors a SDRN then the context must be empty, because the SERVICE represents a (multi-valued) skill call.  
    - it must NOT have ANY GRAPH sub-context. You may use only KA-BIND inside of the service context.
- OWL-EL: only interoperates with the OWL2 EL profile
- LIMITED-GRAPH: GRAPH references (FROM, TO or GRAPH contexts) must point to a GDRN or qualified DRL anchoring a GDRN.
- NO-LITERAL-SUBJECT: no literals in the subject of triple patterns

KA-MATCH extends SPARQL in the following manner

- POST-GET-OPTIONS: the endpoint should support the http verbs POST, GET and OPTIONS - the latter for the purpose to control cross-domain scripting (which is optional, so returning an error status is sufficient).
- POST-SKILL: There MUST be a sub-path "/skill" to the SPARQL endpoint which accepts a non-empty body of media type "application/sparql-query" and contains a valid  KA-MATCH SPARQL text.  It also requires a query parameter "asset" which is a valid SDRN. It returns a success code when these conditions are met and the text could be successfully stored. In that case, you may use the asset SDRN (for example as the anchor of a qualified DRL) in future GET and POST calls. The query text can contain variable references.
- ASSET-TARGET: In both the GET and POST Http Verbs, you may use the query parameter "asset" which should be set to some qualified DRL (global dataspace asset) or DRN (local asset). If the body of the request (POST) or the query parameter (POST or GET) is a valid SPARQL query (media type "application/sparql-query") then the asset MUST anchor a valid GDRN (in which case the query should be executed as if the TO/FROM clause would be set to the GDRN). Otherwise, the asset MUST anchor a valid SDRN (in which case the previously store query text from POST-SKILL is executed). We call the query text from either the query parameter (GET), the body (POST) or the skill asset lookup (GET and POST) the resolved query.
- PARAMETRIZED-QUERY: The resolved query may contain variable references (literals or iris starting with @ e.g., "@troubleCode"^^xsd:string or <@vin^^cx:Vehicle>). For each referenced variable, there must be either at least one correspondingly-named query parameter (GET, POST) or the media type of the body (POST) is one of "application/sparql-results+json" or "application/sparql-results+xml" and the variable is bound there. For variables bound as query parameters, there is the option to build tuple-based combinations by using a parenthesis as the prefix of a variable/parameter name "(" and a closing parenthesis ")" as a suffix of a substitution.
- QUERY-LANG: The query parameter "queryLn" can be used, but is currently fixed to SPARQL.

### KA-TRANSFER

KA-TRANSFER is a variant of KA-MATCH which allows to proxy the payloads over headerless or fixed-header protocols by implementing the following "WRAP-HEADERS" strategy:

| KA-MATCH Component | KA-MATCH Name   | KA-MATCH Component         | KA-MATCH Name | Description |
|--------------------|-----------------|----------------------------|---------------|-------------|
| Request Header     | Accept          | Request URL Query Parameter| cx_accepts    | This header is integral part of the protocol, since federating agents may require a particular result format in their internal processing. |
| Response Header    | cx_warnings     | Response multi-part body   | cx_warnings   | This header is integral part of the protocol in order to annotate and analyze a robust distributed processing which is always subject to unforeseen failures. |

### Check if these EDC statements should be normative. If yes include in table(s) above if not already there

#### EDC

Actually, the Eclipse Dataspace Connector (see Catena-X Standard CX-00001) consists of two components which both have to be extended (using the EDC extension mechanism) for KA enablement. The Control Plane hosts the actual management/negotiation engine and is usually a singleton that is exposing

- an internal (api-key secured) API for managing the control plane by administrative accounts/apps and the Matchmaking Agent
  - Manages Assets (=Internal Addresses including security and other contextual information into the Binding/Virtualization/Backend Layers together with External meta-data/properties of the Assets for discovery and self-description)
  - Manages Policies (=Conditions regarding the validity of Asset negotiations and interactions)
  - Manages Contract Definitions (=Offers are combinations of Assets and Policies and are used to build up a Catalogue)
- a public (DAPS-secured) IDS API for coordination with other control planes of other business partners to setup transfer routings between the data planes.
- state machines for monitoring (data) transfer processes which are actually executed by the (multiple, scalable) data plane(s). KA introduces a new transfer process type “HttpProtocol” which works like the standard “HttpProxy” transfer but enables sub-protocols of http/s (such as SPARQL) installing dedicated routing logic in the data plane(s) (see below)
- a validation engine which currently operates on static tokens/claims which are extracted from the transfer flow but may be extended with additional properties in order to check additional runtime information in the form of properties
- callback triggers for announcing transfer endpoints to the data plane to external applications, such as the Matchmaking Agent (or other direct EDC clients, frameworks and applications). We want to support multiple Matchmaking Agent instances per EDC for load-balancing purposes and we also like to allow for a bridged operation with other non-KA use cases, so it should be possible to configure several endpoint callback listeners per control plane.
The Data Plane (multiple instances) performs the actual data transfer tasks as instrumented by the control plane. The data plane exposes transfer-specific capabilities (Sinks and Sources) to adapt the actual endpoint/asset protocols (in the EDC standard: the asset type).
- Graph Assets use the asset type “urn:cx:Protocol:w3c:Http#SPARQL”. In their address part, the following properties are supported
  - “asset:prop:id” – The name under which the Graph will be offered. Should be a proper IRI/URN, such as urn:io.catenax.knowledge.dataspace:GraphAsset#TelematicsSupplier
  - “baseUrl” – The endpoint URL of the binding agent (see below). Should be a proper http/s SPARQL endpoint.
  - “proxyPath” – must be set to “false”
  - “proxyQueryParams” – must be set to “true”
  - “proxyBody” – must be set to “true”
  - “authKey” – optional authentication header, e.g. “X-Api-Key”
  - “authCode” – optional authentication value, such as an API key
  - “header:Host” – optional fixed Host header forwarded to the endpoint
  - “header:Accepts” – optional fixed Accepts header forwarded to the endpoint, e.g., “application/sparql-results+json”
- Skill Assets use the asset type “urn:cx:Protocol:w3c:Http#SKILL”. In their address part, the following properties are supported
  - “asset:prop:id” – The name under which the Skill will be offered. Should be a proper IRI/URN, such as urn:io.catenax.knowledge.dataspace:SkillAsset#TelematicsOEM
  - “baseUrl” – should be empty or will be ignored
  - “query” – A valid and parameterized SPARQL query
  - “proxyPath” – must be set to “false”
  - “proxyQueryParams” – must be set to “true”
  - “proxyBody” – must be set to “false”
- In their description part, Skill Assets and Graph Assets can have the following properties:
  - “asset:prop:id” – Equal to the corresponding field in the internal address.
  - “cx:hasRole” – An RDF description listing the Use case Roles that this asset belongs to, e.g. “<urn:io.catenax.knowledge.dataspace:UseCaseRole#TelematicsOEM>”
  - “asset:prop:name” – Title of the asset in the default language.
  - “asset:prop:name@de” – Title of the asset in German (or other languages accordingly.
  - “asset:prop:description”, “asset:prop:name@de”, … - Description of the Asset
  - “asset:prop:version” – A version IRI which is a download URI for the Asset Desccription as a separate file
  - “asset:prop:contenttype” – A valid Content-Type constraint to list the available response formats, e.g. “application/sparql-results+json, application/sparql-results+xml”
  - “rdf:type” – Iri of the Asset Type, “<urn:io.catenax.knowledge.dataspace:GraphAsset>” for graph assets and “<urn:io.catenax.knowledge.dataspace:SkillAsset>” for skill assets.
  - “rdfs:isDefinedBy” – An RDF description listing the Use case ontologies that this asset belongs to, e.g., “<urn:io.catenax.knowledge.dataspace:UseCase#Telematics>”
  - “cx:protocol” – should be set to “<urn:cx:Protocol:w3c:Http#SPARQL>”
  - “cx:shape” – contains a SHACL constraint description which describes the contents of the Graph Asset or the SPARQL text of the query (in case this is a “free” Skill)
  - “cx:isFederated” – a Boolean indicating whether this asset should appear in the federated data catalogue (and hence can be dynamically resolved)
- For both Graph and Skill Assets, appropriate Sink and Source implementations have to be registered which operate just as the standard HttpSink and HttpSource, but cater for some additional peculiarities. In particular, the “AgentSource”
  - should unwrap the original “Accepts” header from the payload that is enclosed within the “cx_accepts” parameter
  - complete the payload with any additional headers (and the query parameter) as given in the assets address properties.
  - May parse the query and validate the given data address using additional runtime information from the query, the header, the parameters and extended  policies with the help of the extended control plane.
  - rewrite the resulting SPARQL query parameter/body by replacing any occurrence of the Asset-URI “GRAPH <?assetUri>” with the actual URL of the asset baseUrl (SERVICE <?baseUrl>).
  - May rewrite the query using the “cx:shape” property of the GraphAsset in order to enforce particular constraints.
  - Delegate the resulting call to the Matchmaking Agent.

The Matchmaking Agent

- Should  perform a realm-mapping from the tenant domain (Authentication Scheme, such as API-Key and Oauth2) into the dataspace domain (EDC tokens)
- Should use the EDC management API in order to negotiate outgoing “HttpProtocol” transfers. It may use parallelism and asynchronity to perform multiple such calls simultaneously. It will wrap any inbound “Accept” header requirements as an additional “cx_accept” parameter to the transfer sink.
- Should operate as a endpoint callback listener, such that the setup transfers can invoke the data plane
- Uses and Maintains the Federated Catalogue as an RDF store.
- Should be able to access Binding Agents by means of “SERVICE” contexts in the SPARQL standard. Hereby, the Matchmaking Agent should be able to restrict the type of sub-queries that are forwarded. For practicability purposes, Binding Agents need only support a subset of SPARQL and OWL (no embedded GRAPH/SERVICE contexts, no transitive closures and inversion, no object variables in rdf:type, no owl:sameAs lookups, …).

### Move to Github documentation

#### Test Scripts

The CAB MAY use a set of predefined API interactions to run against its own dataspace tenant or let the assessed party run these scripts depending on the assessment method. The scripts  are hierarchically organized in a POSTMAN Collection and can be found under <https://elements.getpostman.com/redirect?entityId=2757771-0ad1b7a6-734c-4289-9221-667fc56a21da&entityType=collection>

#### Test Graph Assets

The CAB MAY use the following Asset Description, Policy Definition and Contract Definition in its assessment method. The CAB MAY deploy these objects in its own dataspace tenant or let the assessed party deploy these objects depending on the assessment method.

```csharp
{    “asset": {
        "properties": {
            "asset:prop:id": "urn:cx:Graph:oem:Diagnosis2022",
            "asset:prop:contract": "<urn:cx:Graph:oem>",
            "asset:prop:name": "Diagnostic Trouble Code Catalogue Version 2022",
            "asset:prop:description": "A sample graph asset/offering referring to a specific diagnosis resource.",
            "asset:prop:version": "0.7.4-SNAPSHOT",
            "asset:prop:contenttype": "application/json, application/xml",
            "rdf:type": "<{{cxOntologyRoot}}/cx_ontology.ttl#GraphAsset>",
            "rdfs:isDefinedBy": "<{{cxOntologyRoot}}/diagnosis_ontology.ttl>",
            "cx:protocol": "<urn:cx:Protocol:w3c:Http#SPARQL>",
            "cx:shape": “[ rdf:type sh:NodeShape ;\n  sh:targetClass cx:DTC ;\n  sh:property [\n        sh:path cx:provisionedBy ;\n        sh:hasValue <urn:bpn:legal:BPNL00000003COJN> ;\n    ] ;\n  sh:property [\n        sh:path cx:Version ;\n        sh:hasValue 0^^xsd:long ;\n    ] ;\n  sh:property [\n        sh:path cx:affects ;\n        sh:class [ rdf:type sh:NodeShape ;\n  sh:targetClass cx:DiagnosedPart ;\n  sh:property [\n        sh:path cx:provisionedBy ;\n        sh:hasValue <urn:bpn:legal:BPNL00000003COJN> ;\n    ]]] ;\n",
            "cx:isFederated": true
        }},
    "dataAddress": {
        "properties": {
            "asset:prop:id": "urn:cx:Graph:oem:Diagnosis2022",
            "baseUrl": "{{oemProviderAgent}}/sparql",
            "type": "urn:cx:Protocol:w3c:Http#SPARQL",
            "proxyPath": "false",
            "proxyMethod": "true",
            "proxyQueryParams": "true",
            "proxyBody": "true",
            "authKey": "{{oemBackendAuthKey}}",
            "authCode": "{{oemBackendAuthCode}}"
        }
    }
}

{
  "id": "urn:cx:Policy:oem",
  "policy": {
    "permissions": [
        {
            "action": {
                "type": "USE"
            },
            "edctype": "dataspaceconnector:permission"
        }
    ],
    "@type": {
        "@policytype": "set"
    }
  }
}


{
  "id":"urn_cx_Graph_oem",
  "accessPolicyId": "urn:cx:Policy:oem",
  "contractPolicyId": "urn:cx:Policy:oem",
  "criteria": [ {
      "operandLeft": "asset:prop:contract",
      "operator":"=",
      "operandRight":"<urn:cx:Graph:oem>"
  }]
}
```

#### Test Skill Asset

The CAB MAY use the following Asset Description and Contract Definition in combination with the Policy Definition of 2.2 in its assessment method. The CAB MAY deploy these objects in its own dataspace tenant or let the assessed party deploy these objects depending on the assessment method.

```csharp
{
  "asset": {
    "properties": {
      "asset:prop:id": "urn:cx:Skill:oem:HealthIndication",
      "asset:prop:contract": "<urn:cx:Skill:oem>",
      "asset:prop:name": "Health Indication Skill",
      "asset:prop:description": "Obtains Health-Indication Score for Particular Vehicles Based on Telematics Data",
      "asset:prop:version": "0.7.4-SNAPSHOT",
      "asset:prop:contenttype": "application/json, application/xml",
      "cx:protocol": "<urn:cx:Protocol:w3c:Http#SPARQL>",
      "rdf:type":"<{{cxOntologyRoot}}/cx_ontology.ttl#SkillAsset>",
      "rdfs:isDefinedBy": "<{{cxOntologyRoot}}/common_ontology.ttl>,<{{cxOntologyRoot}}/diagnosis_ontology.ttl>,<{{cxOntologyRoot}}/part_ontology.ttl>",
      "cx:isFederated": true
    }
  },
  "dataAddress": {
    "properties": {
      "asset:prop:id": "urn:cx:Skill:oem:HealthIndication",
      "type": "urn:cx:Protocol:w3c:Http#SKILL#SPARQL",
      "query": “SELECT ?subject ?predicate ?object WHERE [ ?subject ?predicate ?object }",
      "proxyPath": "false",
      "proxyMethod": "false",
      "proxyQueryParams": "true",
      "proxyBody": "false"
    }
  }
}


{
  "id":"urn_cx_Skill_oem",
  "accessPolicyId": "urn:cx:Policy:oem",
  "contractPolicyId": "urn:cx:Policy:oem",
  "criteria": [ {
      "operandLeft": "asset:prop:contract",
      "operator":"=",
      "operandRight":"<urn:cx:Skill:oem>"
  }]
}
```
