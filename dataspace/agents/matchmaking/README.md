# Catena-X Knowledge Agents (Hey Catena!) Matchmaking and Inference Agent

This is a folder providing a FOSS implementations of a Hey Catena! agent for consumer-side deployment which will just delegate/federate skills.

Currently, a plain Apache Jena Fuseki is used for federation (no matchmaking). This will change in the near future and this folder will become active.

## What is Matchmaking

A query/computation engine is federating if parts of the query maybe (recursively) dumped off to separate query/computation engines collocated in the same environment/dataspace.

Usually, there will be an explicit construct in the query language which determines (or even: infers) the required computation target. This is useful when the targets of the computations are unique in the sense that they can be listed/lookedup in advance.

But there maybe cases in which 
* the query designed has no full overview over the dataspace
* the dataspace is rapidly changing
* there are several computation engines providing similar assets, but with a slightly differently profile (contract conditions, intersecting content, performance, ...)
* the integration (union, join) of individual federated computations is costly by itself.

In these cases, so-called Matchmaking agents come into play. They introduce several measures to improve the behaviour of more complex dataspaces:
* Federation decisions in the query (hence a so-called query rewrite) will be made using advanced meta-data and optimization algorithms. This means that the user of such a matchmaking agent will be able to pose a technically simple (but not necessarily business-wise) query which is then elaborated by the dataspace in an optimal fashion.
* the matchmaking agent comes with its additional computing power.
* the matchmaking agent may negotiate with the most common and critical provider agents to migrate a part of their data/functions to the matchmaking agent in order to be able to do most optimal data integration strategies (local union/join, predicate-push, ...)

## Notice

* see copyright notice in the top folder
* see license file in the top folder
* see authors file in the top folder





