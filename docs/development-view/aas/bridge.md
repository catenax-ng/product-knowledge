---
sidebar_position: 1
title: AAS Bridge
---

This section describes modules and components which are able to bridge
the [Semantic Web](https://www.w3.org/standards/semanticweb/) technology of
Knowledge Agents with the [Industrial Digital Twin Association's](https://industrialdigitaltwin.org/)
[Asset Administration Shell (AAS)](https://industrialdigitaltwin.org/wp-content/uploads/2023/04/IDTA-01002-3-0_SpecificationAssetAdministrationShell_Part2_API.pdf)
standard.

For more information see

* Our [Adoption](../adoption-view/intro) guideline
* The [Layers & Modules Architecture](../modules)
* Our [Reference Implementation](reference)
* The [Deployment](../operation-view/deployment) guide

Actually, we are talking about two bridges, one which bridges AAS information that is described in Catena-X aspect schemas
into the Catena-X domain ontologies (the AAS-KA Bridge). And one bridge which is able to emulate
shells and submodels out of a given (federated) virtual graph.

[![AAS Bridge(s)](/img/aas_bridge_small.png)](/img/aas_bridge.png)

As the result, we are able to provide both SPARQL-based Graph Assets as well as AAS-based Submodel Assets based on the same
data sources.

## AAS KA Bridge

There are two main components whose interplay implements the AAS-KA bridge:

* A flexible SQL/JSON engine, such as Dremio or in parts also Postgresql which is able to mount raw data in various formats from remote filesystems and APIs. This engine is used to build flat relational views onto the hierarchical AAS/Schema structure. Typically there will be one table/view per shell type and submodel schema. As an example, see these [scripts](https://github.com/catenax-ng/product-knowledge/tree/main/infrastructure/resources/dremio)
* A graph engine that is able to bind/translate SPARQL queries into SQL. As an example, see these [bindings](https://github.com/catenax-ng/product-knowledge/tree/main/infrastructure/oem/resources/trace.obda)

## KA-AAS Bridge

The KA-AAS Bridge is built using FAAAST framework. For each shell type/submodel there will be a combination of

* a SPARQL query extracting "flat" information out of the virtual graph
* a shell/submodel template which populates the query results into the AAS representation.
