# Catena-X Knowledge Agents (Hey Catena!) EDC Agent Plane (Hashicorp Vault)

This folder hosts the [Default Agent (Data) Plane with Hashicorp Vault for the Eclipse Dataspace Connector (EDC)](https://projects.eclipse.org/projects/technology.dataspaceconnector).

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
docker build -t ghcr.io/catenax-ng/product-knowledge/dataspace/agentplane-hashicorp:latest -f src/main/docker/Dockerfile .
```

The image contains
* an EDC Data Plane for synchronous Http transfers with a secret store tailored to the Hashicorp Vault
* supports HttpData sources (such as used by AAS submodels)
* supports possibly multiple Http sub-protocols, currently
  * urn:cx:Protocol:w3c:Http#SPARQL for Graph-Based sources by means of the Apache Jena Fuseki engine
* allows to build up a graph-based federated data catalogue

To run the docker image, you could invoke this command

```console
docker run -p 8082:8082 \
  -v $(pwd)/resources/agent.ttl:/app/agent.ttl \
  -v $(pwd)/resources/dataspace.ttl:/app/dataspace.ttl \
  -v $(pwd)/resources/dataplane.properties:/app/configuration.properties \
  -v $(pwd)/resources/opentelemetry.properties:/app/opentelemetry.properties \
  -v $(pwd)/resources/logging.properties:/app/logging.properties \
  ghcr.io/catenax-ng/product-knowledge/dataspace/agentplane-hashicorp:latest
````

Afterwards, you should be able to access the [local SparQL endpoint](http://localhost:8082/api/agent) via
the browser or by directly invoking a query

```console
curl --request GET 'http://localhost/api/agent?asset=urn:graph:cx:Dataspace&query=SELECT ?senseOfLife WHERE { VALUES (?senseOfLife) { ("42"^^xsd:int) } }' \
--header 'X-Api-Key: foo'
```

For a list of environment variables to configure the behaviour of the data plane, we refer to [the EDC documentation](https://github.com/catenax-ng/product-edc).

The following is a list of configuraton objects and properties that you might set in the corresponding mounted config files

| CONFIG FILE                   | SETTING                           | Required | Example                                                        | Description                                                                                         | List |
|-------------------------------|-----------------------------------|----------|----------------------------------------------------------------|-----------------------------------------------------------------------------------------------------|------|
| /app/configuration.properties | cx.agent.asset.default            |          | urn:graph:cx:Dataspace                                         | Name of the default (local) asset                                                                   |      | 
| /app/configuration.properties | cx.agent.asset.file               |          | dataspace.ttl                                                  | Name of the initial state file of the default (local) asset                                         |      | 
| /app/configuration.properties | cx.agent.accesspoint.name         |          | api                                                            | Internal name in Fuseki for the agent endpoint                                                      |      | 
| /app/configuration.properties | cx.agent.controlplane.url         | X        | http://oem-control-plane:8081/data                             | Data Management Endpoint of the consuming control plane                                             |      | 
| /app/configuration.properties | edc.api.control.auth.apikey.key   | (X)      | X-Api-Key                                                      | Authentication Header for consuming control plane                                                   |      | 
| /app/configuration.properties | edc.api.control.auth.apikey.value | (X)      |                                                                | Authentication Secret for consuming control plane                                                   |      | 
| /app/configuration.properties | cx.agent.dataspace.synchronization |          | -1/60000                                                       | If positive, number of seconds between each catalogue synchronization attempt                       |      | 
| /app/configuration.properties | cx.agent.dataspace.remotes        |          | http://consumer-edc-control:8282,http://tiera-edc-control:8282 | Comma-separated list of Business Partner Control Plane Urls (which host the IDS catalogue endpoint) |      | 
| /app/configuration.properties | cx.agent.sparql.verbose           |          | false                                                          | Controls the verbosity of the SparQL Engine)                                                        |      | 
| /app/configuration.properties | cx.agent.threadpool.size          |          | 4                                                              | Number of threads for batch/synchronisation processing                                              |      | 
| /app/configuration.properties | cx.agent.federation.batch.max     |          | 9223372036854775807                                            | Maximal number of tuples to send in one query                                                       |      | 
| /app/configuration.properties | cx.agent.negotiation.poll         |          | 1000                                                           | Number of seconds between negotiation status checks                                                 |      | 
| /app/configuration.properties | cx.agent.negotiation.timeout      |          | 30000                                                          | Number of seconds after which a pending negotiation is regarded as stale                            |      | 
| /app/agent.ttl                |                                   | x        | Fuseki engine configuration                                    | X                                                                                                   |
| /app/dataspace.ttl            |                                   |          | Initial state of triple store                                  | X                                                                                                   |
| /app/logging.properties       |                                   |          | Logging configuration                                          | X                                                                                                   |
| /app/opentelemetry.properties |                                   |          | Telemetry configuration                                        | X                                                                                                   |


## Notice

* see copyright notice in the top folder
* see license file in the top folder
* see authors file in the top folder
