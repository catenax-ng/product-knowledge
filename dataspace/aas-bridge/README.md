## AAS-Bridge

The AAS-Bridge exposes information from the Knowledge Graph via the APIs of the Asset Administration Shell. It builds
upon the FAAAST Framework and the AAS4J-Transformation-Library.

Please note that this project is highly experimental, unstable and feature-incomplete.

### Configuration

By default, the AAS-Bridge has four Mapping Configurations included - one for each submodel. A mapping configuration 
must be provided by the User on startup as part of the PersistenceInKnowledge implementation of the FAAAST-Persistence
API. It consists of three files:
- A sparql-query that fetches all data from the graph adhering to the structure.
- A sparql-query that only queries for all data relating to a particular identifier.
- The MappingSpecification how to translate that query-response into AAS.
- The semanticId of the Submodel built from the respective MappingSpecification.

#### Mapping Specification

The AAS-Bridge makes a couple of assumptions about the content of the MappingSpecification:
1. The @namespaces- AND the @variables-section of the @header both hold the semanticId of the Submodel that is to
be transformed
2. IDs of submodel-instances must always start with the semanticId of the submodel followed by "/" and the identifier of
the asset. How this can be achieved via configuration is demonstrated in the examples' @header-@definitions-section
under `genSubmodelId`.
3. If not provided explicitly, the function `AasUtils.loadConfigsFromResources()` will search the AAS-Bridge's resources
folder for a set of the necessary data. The folder- and naming-convention must be adhered to strictly.