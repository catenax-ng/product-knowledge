# Catena-X Knowledge Agents (Hey Catena!) EDC Agent Plane

This folder hosts the [Agent (Data) Plane for the Eclipse Dataspace Connector (EDC)](https://projects.eclipse.org/projects/technology.dataspaceconnector).

## Architecture

The Agent Data Plane is a variant/extension to the Http (Proxy) Data Plane which
- has a direct endpoint for submitting (federated) queries in the supported inference languages (currently: SparQL)
- may negotiate further agreements for delegating sub-queries on the fly
- implements special Sinks and Sources for dealing with specific endpoint protocols, such as SparQL-Over-Http.

The Agent Data Plane currently relies on Apache Jena Fuseki as the SparQL engine.

### Security

There are three types of exposed interfaces in the data plane:
* Interaction with the tenant (API) is usually shielded with a data plane api key (but may include oauth2 against a consumer-specific SSO)
* Interaction with the control plane (Management, Callback) uses the data plane api key
* Interaction with other data planes (Transfer) uses the "ordinary" synchronous transfer with the DAPS token mechanism

There are three types of called interfaces in the data plane
* Interaction with the control plane uses the control plane api key
* Interaction with the persistent storage layer of the embedded SparQL engine uses filesystem mounting and permissions
* Interaction with backend agents uses their individual security settings (typically given in the private data address of the assets, in addition to the DAPS token attachements)

## Building

You could invoke the following command to compile and test the EDC Agent extensions

```console
mvn -s ../../../settings.xml install
```

## Deployment & Usage

### Containerizing 

You could invoke the following command to compile and test the EDC Agent extensions

```console
mvn -s ../../../settings.xml install -Pwith-docker-image
```

Alternatively, the docker image of the agent data plane is built using

```console
docker build -t ghcr.io/catenax-ng/product-knowledge/dataspace/agentplane-azure-vault:latest -f src/main/docker/Dockerfile .
```

The image contains
* an EDC Data Plane with a secret store tailored to the Azure Vault
* Apache Jena Fuseki as a SparQL Server

To run the docker image, you could invoke this command

```console
docker run -p 8082:8082 \
  -v $(pwd)/resources/agent.ttl:/app/agent.ttl \
  -v $(pwd)/resources/dataspace.ttl:/app/dataspace.ttl \
  -v $(pwd)/resources/dataplane.properties:/app/configuration.properties \
  -v $(pwd)/resources/opentelemetry.properties:/app/opentelemetry.properties \
  -v $(pwd)/resources/logging.properties:/app/logging.properties \
  ghcr.io/catenax-ng/product-knowledge/dataspace/agentplane-azure-vault:latest
````

Afterwards, you should be able to access the [local SparQL endpoint](http://localhost:8082/api/agent) via
the browser or by directly invoking a query

```console
curl --request GET 'http://localhost/api/agent?asset=urn:graph:cx:Dataspace&query=SELECT ?senseOfLife WHERE { VALUES (?senseOfLife) { ("42"^^xsd:int) } }' \
--header 'X-Api-Key: foo'
```

For a list of environment variables to configure the behaviour of the data plane, we refer to [the EDC documentation](https://github.com/catenax-ng/product-edc).

The following is a list of configuraton objects and properties that you might set in the corresponding mounted config files

| CONFIG FILE | SETTING        | Required  | Example                                                                | Description                          | List |
|---          |---	           |---	       |---	                                                                    |---                                   | ---  |
| /app/configuration.properties| cx.agent.asset.default           |           | urn:graph:cx:Dataspace  | Name of the default (local) asset                |      | 
| /app/configuration.properties| cx.agent.asset.file           |           | dataspace.ttl  | Name of the initial state file of the default (local) asset       |      | 
| /app/configuration.properties| cx.agent.accesspoint.name           |           | api  | Internal name in Fuseki for the agent endpoint                   |      | 
| /app/agent.ttl               | x          |                                                          | Fuseki engine configuration                       | X    |
| /app/dataspace.ttl          |           |                                                            | Initial state of triple store  | X    |
| /app/logging.properties     |           |                                                            | Logging configuration | X    |
| /app/opentelemetry.properties     |           |                                                            | Telemetry configuration | X    |


## Notice

* see copyright notice in the top folder
* see license file in the top folder
* see authors file in the top folder
