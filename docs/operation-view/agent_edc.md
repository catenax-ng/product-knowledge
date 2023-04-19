---
sidebar_position: 2
title: Agent-Enabled EDC
---

This document describes deployment for an Agent-Enabled EDC.

For more information see

* Our [Adoption](../adoption-view/intro) guideline
* The [Architecture](../development-view/architecture) documentation
* The [Deployment](deployment) overview
* A [Data Sovereignity & Graph Policy](policy) discussion

For enabling your Dataspace Connector (or rather: its control plane and its data plane(s)) to speak Agent protocols, you can opt for one of three choices.

## Option 1: Include Knowledge Agents into your own EDC Build

see ]Compiling Against the Agent KIT](../development-view/compile)

## Option 2: Drop an additional extension jar into your EDC images

Version 0.6.4-SNAPSHOT of Knowledge Agents is compatible with Catena-X EDC Release 0.1.2
Version 0.7.2-SNAPSHOT of Knowledge Agents is compatible with Catena-X EDC Release 0.1.4 (unpublished)
Version 0.7.4-SNAPSHOT of Knowledge Agents is compatible with Catena-X EDC Release 0.2.0
Version 0.8.>=5-SNAPSHOT of Knowledge Agents is compatible with Catena-X EDC Release >=0.3.0

Download the jar from the following location and add it to the lib/ext folder of your EDC control plane installation

* [Control Plane Agent Transfer Package](https://github.com/catenax-ng/product-knowledge/packages/1776419)

Download the jar from the following location and add it to the lib/ext folder of your EDC data plane installation

* [Data Plane Agent Protocol Package](https://github.com/catenax-ng/product-knowledge/packages/1781577)

If using a docker environment, these files could be simply mounted under /app/lib/ext

## Option 3: Use the ready-made Agent-enbled EDC images

Version 0.6.4-SNAPSHOT of Knowledge Agents is built against Catena-X EDC Release 0.1.2

* [Agent-Enabled In-Memory Control Plane using Azure Vault](ghcr.io/catenax-ng/product-knowledge/controlplane-memory:0.6.4-SNAPSHOT)
* [Agent-Enabled Data Plane (Http-Only) using Azure Vault](ghcr.io/catenax-ng/product-knowledge/agentplane-azurevault:0.6.4-SNAPSHOT)

Version 0.7.2-SNAPSHOT of Knowledge Agents is built against Catena-X EDC Release 0.1.4 (unpublished)

* [Agent-Enabled In-Memory Control Plane using Azure Vault](ghcr.io/catenax-ng/product-knowledge/controlplane-memory:0.7.2-SNAPSHOT)
* [Agent-Enabled Data Plane (Http-Only) using Azure Vault](ghcr.io/catenax-ng/product-knowledge/agentplane-azurevault:0.7.2-SNAPSHOT)

Version 0.7.4-SNAPSHOT of Knowledge Agents is built against Catena-X EDC Release 0.2.0

* [Agent-Enabled In-Memory Control Plane using Azure Vault](ghcr.io/catenax-ng/product-knowledge/controlplane-memory:0.7.4-SNAPSHOT)
* [Agent-Enabled Data Plane (Http-Only) using Azure Vault](ghcr.io/catenax-ng/product-knowledge/agentplane-azurevault:0.7.4-SNAPSHOT)

Version 0.8.5-SNAPSHOT of Knowledge Agents will be built against Catena-X EDC Release 0.3.0

* [Agent-Enabled In-Memory Control Plane using Azure Vault](ghcr.io/catenax-ng/product-knowledge/controlplane-memory:0.8.5-SNAPSHOT)
* [Agent-Enabled Data Plane (Http-Only) using Azure Vault](ghcr.io/catenax-ng/product-knowledge/agentplane-azurevault:0.8.5-SNAPSHOT)

### Deployment using a Helm umbrella chart

In each case, we have adopted two helm charts which can be used as sub-charts in a more complex umbrella.

Add the KA helm repo for that purpose:

```console
helm repo add catenax-knowledge https://catenax-ng.github.io/product-knowledge/infrastructure
```

Add aliased dependencies to your umbrella chart:

```yaml
dependencies:
  - name: agent-control-plane
    repository: https://catenax-ng.github.io/product-knowledge/infrastructure
    version: 0.7.4-SNAPSHOT
    alias: supplier-control-plane
  - name: agent-data-plane
    repository: https://catenax-ng.github.io/product-knowledge/infrastructure
    version: 0.7.4-SNAPSHOT
    alias: supplier-data-plane
```

and update the dependencies

```console
helm dependencies update
```

You may now configure the deployment instances in your values.yaml in more detail (see the documentation of the [agent control plane chart](https://github.com/catenax-ng/product-knowledge/tree/feature/KA-188-extract-sub-charts/infrastructure/charts/agent-control-plane) and [agent data plane chart](https://github.com/catenax-ng/product-knowledge/tree/feature/KA-188-extract-sub-charts/infrastructure/charts/agent-data-plane)).

```yaml
# Common Api-Key Settings
auth: &auth
 key: X-Api-Key
 value: <apikey>

# Access to the Vault
vault: &vault
 name: "<name>"
 tenantid: "<tenantid>"
 clientid: "<clientid>"
 clientsecret: "<clientsecret>"

# Common Oauth Settings to Connect the Dataspace
daps: &daps
  clientid: <dapsclientid>
  providerAudience: idsc:IDS_CONNECTORS_ALL
  providerJwksUrl: https://daps.public/.well-known/jwks.json
  tokenUrl: https://daps.public/token

# The Supplier Providing Control plane
supplier-control-plane: 
  nameOverride: supplier-control-plane
  fullnameOverride: supplier-control-plane
  vault: *vault
  oauth: 
    <<: *daps
    privateKeyAlias: supplier-daps-key
    publicKeyAlias: supplier-daps-crt
    endpointAudience: http://supplier-control-plane:8282/api/v1/ids/data
  transfer:
    proxy:
      token:
        signerPrivateKeyAlias: supplier-daps-key
        verifierPublicKeyAlias: supplier-daps-crt
  configuration:
    properties: |-
      edc.hostname=edc-control.public
      edc.ids.id=urn:connector:edc:supplier
      edc.ids.title=Supplier Dataspace Connector
      edc.ids.description=Providing Eclipse Dataspace Connector for Knowledge Agents Supplier
      edc.ids.endpoint=https://edc-control.public/api/v1/ids
      edc.ids.validation.referringconnector=false
      edc.ids.maintainer=http://your.company
      edc.ids.curator=http://your.company
      edc.ids.catalog.id=urn:catalog:catenax
      edc.ids.security.profile=base
      ids.webhook.address=http://edc-control.public
      edc.data.encryption.algorithm=NONE
      edc.receiver.http.endpoint=https://apiwrapper.local/callback/endpoint-data-reference
  dataplanes: 
    agentplane:
      url: http://edc-data.intern/
      publicurl: https://edc-data.public/api/public
      callback: 
        url: http://edc-data.intern/callback/endpoint-data-reference
        auth: *auth      

# The Supplier Data plane
supplier-data-plane: &supplierdataplane
  nameOverride: supplier-data-plane
  fullnameOverride: supplier-data-plane
  vault: *vault
  oauth: 
    <<: *daps
    privateKeyAlias: supplier-daps-key
    publicKeyAlias: supplier-daps-crt
    endpointAudience: http://supplier-control-plane:8282/api/v1/ids/data
  token:
    validationEndpoint: http://dlr-agent-control:8182/validation/token
  configuration:
    properties: |-
      edc.hostname=edc-data.public
  assets:
    dataspace.ttl: resources/dataspace.ttl
  agent:
    # -- Data API Url of the associated Control Plane
    controlPlaneDataUrl: http://supplier-control-plane:8181/data
    # -- Initial Definition of the default graph, path to a mounted resource containing a turtle file
    defaultGraph: 
      content: dataspace.ttl
      name: api
    # Configures the Federated Data Catalogue
    federation: 
      # -- Enable synchronization by specifying the number of milliseconds
      synchronization: 60000
      # -- A List of Base Urls Hinting to the IDS Apis of business partners
      connectors: 
        - https://business-partner-edc.public

```

And be sure to replace the charts/agent-data-plane/resources/dataspace.ttl with the
initial graph data for your dataspace, such as in the [Catena-X Integration Default Graph](https://raw.githubusercontent.com/catenax-ng/product-knowledge/feature/KA-188-extract-sub-charts/infrastructure/resources/dataspace.ttl)
