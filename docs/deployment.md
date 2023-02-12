---
sidebar_position: 3
title: Deployment (MVP)
---

Knowledge Agents is a federated technology, so there is no central component setup to take into account.
Instead, the Semantic Dataspace is formed by the individual business partners extending/configuring their 
connectors and enabling their backend systems and/or datalakes. The deployment depends hereby on the
role that the business partner takes.

## Dataspace Partner Roles

![Semantic Dataspace Roles](/img/dataspace_roles.png)

### Role: As A Consumer

As a consumer, you just need to:
- enable your dataspace connector to initiate/delegate the required Agent protocols (here: SparQL-over-Http).
- (optionally) mount your connector as a remote repository into your enterprise graph infrastructure.

### Role: As A Skill Provider

As a skill provider, you need to 
- enable your dataspace connector to transfer/delegate the required Agent protocols.
- (optionally) employ multiple data planes in case you want to expose hosted skills (skill assets that operate as stored procedures
and which require computational resources at the provider side) instead of distributed skills (skill assets that are offered as query texts/files and which are executed at the consumer side).

### Role: As A Provider

As a provider, you need to 
- enable your dataspace connector to receive/internalize the required Agent protocols. 

Depending on the kind of provisioning, you will setup additional internal "agents" (endpoints).

#### Sub-Role: As A Data Provider

As a data provider, you want to 
- bind your data sources to knowledge graphs following the Catena-X ontology. Therefore, a provisioning agent
should be setup on top of a data virtualization/database layer.

#### Sub-Role: As A Function Provider

As a function provider, you want to 
- bind your API to a special knowledge graph structure. Therefore, a remoting agent should be setup.

## Deployment of the Dataspace Connector

For enabling your Dataspace Connector (or rather: its control plane and its data plane(s)) to speak Agent protocols, you can opt for one of three choices.

### Option 1: Include Knowledge Agents into your own EDC Build

Version 0.6.4-SNAPSHOT of Knowledge Agents is compatible with Catena-X EDC Release 0.1.2
Version 0.7.2-SNAPSHOT of Knowledge Agents is compatible with Catena-X EDC Release 0.1.4 (unpublished)
Version 0.7.>=3-SNAPSHOT of Knowledge Agents is compatible with Catena-X EDC Release >=0.2.0

Add the following dependency to your final control plane pom:

```xml
 <dependency>
    <groupId>io.catenax.knowledge.dataspace.edc.control-plane</groupId>
    <artifactId>control-plane-transfer</artifactId>
    <version>0.7.4-SNAPSHOT</version>
 </dependency>
```

Add the following dependency to your final data plane pom:

```xml
  <dependency>
    <groupId>io.catenax.knowledge.dataspace.edc.control-plane</groupId>
    <artifactId>agent-plane-protocol</artifactId>
    <version>0.7.4-SNAPSHOT</version>
  </dependency>
```

Add the following to the repositories section of your master pom (and remember to put your github access token to the settings.xml):

```xml
  <repository>
    <id>github-ka</id>
    <name>Catena-X Knowledge Agents Maven Repository</name>
    <url>https://maven.pkg.github.com/catenax-ng/product-knowledge</url>
   </repository>
```

### Option 2: Drop an additional extension jar into your EDC images

Version 0.6.4-SNAPSHOT of Knowledge Agents is compatible with Catena-X EDC Release 0.1.2
Version 0.7.2-SNAPSHOT of Knowledge Agents is compatible with Catena-X EDC Release 0.1.4 (unpublished)
Version 0.7.>=3-SNAPSHOT of Knowledge Agents is compatible with Catena-X EDC Release >=0.2.0

Download the jar from the following location and add it to the lib/ext folder of your EDC control plane installation

- [Control Plane Agent Transfer Package](https://github.com/catenax-ng/product-knowledge/packages/1776419)

Download the jar from the following location and add it to the lib/ext folder of your EDC data plane installation

- [Data Plane Agent Protocol Package](https://github.com/catenax-ng/product-knowledge/packages/1781577)

If using a docker environment, these files could be simply mounted under /app/lib/ext

### Option 3: Use the ready-made Agent-enbled EDC images

Version 0.6.4-SNAPSHOT of Knowledge Agents is built against Catena-X EDC Release 0.1.2

- [Agent-Enabled In-Memory Control Plane using Azure Vault](ghcr.io/catenax-ng/product-knowledge/controlplane-memory:0.6.4-SNAPSHOT)
- [Agent-Enabled Data Plane (Http-Only) using Azure Vault](ghcr.io/catenax-ng/product-knowledge/agentplane-azurevault:0.6.4-SNAPSHOT)

Version 0.7.2-SNAPSHOT of Knowledge Agents is built against Catena-X EDC Release 0.1.4 (unpublished)

- [Agent-Enabled In-Memory Control Plane using Azure Vault](ghcr.io/catenax-ng/product-knowledge/controlplane-memory:0.7.2-SNAPSHOT)
- [Agent-Enabled Data Plane (Http-Only) using Azure Vault](ghcr.io/catenax-ng/product-knowledge/agentplane-azurevault:0.7.2-SNAPSHOT)

Version 0.7.>3-SNAPSHOT of Knowledge Agents is built against Catena-X EDC Release >=0.2.0

- [Agent-Enabled In-Memory Control Plane using Azure Vault](ghcr.io/catenax-ng/product-knowledge/controlplane-memory:0.7.4-SNAPSHOT)
- [Agent-Enabled Data Plane (Http-Only) using Azure Vault](ghcr.io/catenax-ng/product-knowledge/agentplane-azurevault:0.7.4-SNAPSHOT)

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

## Deployment of the Provisioning Agent

### Using the Preconfigured Docker Image

The provisioning agent uses a version of Ontop VKP:

- [Provisioning Agent based on Ontop VKP](ghcr.io/catenax-ng/product-knowledge/provisioning-agent:0.7.4-SNAPSHOT)

### Deployment using a Helm umbrella chart

We have published a helm chart which can be used as a sub-chart in a more complex umbrella.

Add the KA helm repo for that purpose:

```console
helm repo add catenax-knowledge https://catenax-ng.github.io/product-knowledge/infrastructure
```

Add an (aliased) dependency to your umbrella chart:

```yaml
dependencies:
  - name: provisioning-agent
    repository: https://catenax-ng.github.io/product-knowledge/infrastructure
    version: 0.7.4-SNAPSHOT
    alias: oem-provider-agent
```

and update the dependencies

```console
helm dependencies update
```

You may now configure the deployment instances in your values.yaml in more detail (see the documentation of the [provisioning agent chart](https://github.com/catenax-ng/product-knowledge/tree/feature/KA-188-extract-sub-charts/infrastructure/charts/provisioning-agent)).

Note that the entries under bindings represent the individual mappings/endpoints which bind to your data source. 

```yaml

# -- Configures the OEM provider agent
oem-provider-agent: 
  nameOverride: oem-provider-agent
  fullnameOverride: oem-provider-agent
  # -- Ontologies need extended memory, for each CX endpoint add ~300MB 
  resources: 
    requests:
      cpu: 0.5
      memory: "1.5Gi"
    limits:
      cpu: 0.5
      memory: "1.5Gi"
  bindings:
    # mute the default Diagnosic Trouble Code sample endpoint 
    dtc: null
    # Add a sample Telematics endpoint
    telematics: 
      port: 8080
      path: /(.*)
      settings: 
        jdbc.url: 'jdbc:postgresql://rawdatadb:5432/rawdata'
        jdbc.user: <path:secret#username>
        jdbc.password: <path:secret#password>
        jdbc.driver: 'org.postgresql.Driver'      
      ontology: cx-ontology.xml
      mapping: |-
        [PrefixDeclaration]
        uuid:		urn:uuid:
        bpnl:		bpn:legal:
        oem:    urn:oem:
        cx:			https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/cx_ontology.ttl#
        owl:		http://www.w3.org/2002/07/owl#
        rdf:		http://www.w3.org/1999/02/22-rdf-syntax-ns#
        xml:		http://www.w3.org/XML/1998/namespace
        xsd:		http://www.w3.org/2001/XMLSchema#
        obda:		https://w3id.org/obda/vocabulary#
        rdfs:		http://www.w3.org/2000/01/rdf-schema#
        json:   https://json-schema.org/draft/2020-12/schema#

        [MappingDeclaration] @collection [[
        mappingId	vehicles
        target		<{vehicle_id}> rdf:type cx:Vehicle ; cx:partProductionDate {production_date}^^xsd:date; cx:vehicleIdentificationNumber {van}^^xsd:string; cx:isProducedBy bpnl:{localIdentifiers_manufacturerId} .
        source		SELECT vehicle_id, production_date, van, 'BPNL00000003AYRE' as localIdentifiers_manufacturerId FROM vehicles

        mappingId	parts
        target		<{gearbox_id}> rdf:type cx:AssemblyGroup ; cx:partName {partTypeInformation_nameAtManufacturer}^^xsd:string; cx:isProducedBy bpnl:{localIdentifiers_manufacturerId} .
        source		SELECT gearbox_id, 'Differential Gear' as partTypeInformation_nameAtManufacturer, 'BPNL00000003B2OM' as localIdentifiers_manufacturerId FROM vehicles

        mappingId	vehicleparts
        target		<{gearbox_id}> cx:isPartOf <{vehicle_id}> .
        source		SELECT vehicle_id, gearbox_id FROM vehicles

        mappingId   partLoadSpectrum
        target		<{gearbox_id}> cx:hasLoadSpectrum oem:{newest_telematics_id}/{index} .
        source		SELECT gearbox_id, newest_telematics_id,  index FROM vehicles, (VALUES (0), (1), (2)) AS spectrum(index)

        mappingId   loadspectrum
        target      oem:{id}/{index} rdf:type cx:LoadSpectrum; cx:loadSpectrumId {metadata_projectDescription}^^xsd:string; cx:loadSpectrumName {header_countingValue}^^xsd:string; cx:loadSpectrumDescription {name}^^xsd:string; rdf:type cx:VehicleCurrentState; cx:vehicleOperatingHours {metadata_status_operatingHours}^^xsd:int; cx:vehicleCurrentStateDateTime {metadata_status_date}^^xsd:dateTime; cx:vehicleCurrentMileage {metadata_status_mileage}^^xsd:int; cx:loadSpectrumType {header_channels}^^xsd:string; cx:hasLoadSpectrumValues oem:{id}/{index}/0.
        source		SELECT id, index, name, load_spectra::jsonb->index->'metadata'->>'projectDescription' as metadata_projectDescription, load_spectra::jsonb->index->'header'->>'countingValue' as header_countingValue, floor((load_spectra::jsonb->index->'metadata'->'status'->>'operatingHours')::numeric)::integer as metadata_status_operatingHours, replace(load_spectra::jsonb->index->'metadata'->'status'->>'date','Z','.000Z') as metadata_status_date, load_spectra::jsonb->index->'metadata'->'status'->>'mileage' as metadata_status_mileage, load_spectra::jsonb->index->'header'->'channels' as header_channels FROM (VALUES (0,'GearSet'), (1,'GearOil'), (2,'Clutch')) AS spectrum(index,name), telematics_data

        mappingId   loadspectrumChannel
        target      oem:{id}/{index}/0 rdf:type cx:LoadSpectrumValues; cx:loadSpectrumChannelIndex {body_classes}^^xsd:string; cx:loadSpectrumCountingUnit {header_countingUnit}^^xsd:string; cx:loadSpectrumCountingMethod {header_countingMethod}^^xsd:string; cx:loadSpectrumChannelValues {body_counts}^^xsd:string.
        source		SELECT id, index, load_spectra::jsonb->index->'metadata'->>'componentDescription' as metadata_componentDescription, jsonb_extract_path(load_spectra::jsonb->index,'body','classes','0','classList','0') as body_classes, load_spectra::jsonb->index->'header'->>'countingUnit' as header_countingUnit, load_spectra::jsonb->index->'header'->>'countingMethod' as header_countingMethod, jsonb_extract_path(load_spectra::jsonb->index,'body','counts','countsList','0') as body_counts FROM (VALUES (0), (1), (2)) AS spectrum(index), telematics_data

        mappingId   vehicleAdaptionValues
        target		<{vehicle_id}> cx:hasAdaption oem:{newest_telematics_id} .
        source		SELECT vehicle_id, newest_telematics_id FROM vehicles

        mappingId   adaptionValues
        target		oem:{id} rdf:type cx:Adaption; rdf:type cx:VehicleCurrentState; cx:vehicleOperatingHours {adaption_status_operatingHours}^^xsd:int; cx:vehicleCurrentStateDateTime {adaption_status_date}^^xsd:dateTime; cx:vehicleCurrentMileage {adaption_status_mileage}^^xsd:int; cx:hasValues {adaption_values}^^json:Object .
        source		SELECT id, replace(adaption_values::jsonb->0->'status'->>'date','Z','.000Z') as adaption_status_date, floor((adaption_values::jsonb->0->'status'->>'operatingHours')::numeric)::integer as adaption_status_operatingHours, adaption_values::jsonb->0->'status'->>'mileage' as adaption_status_mileage, adaption_values::jsonb->0->'values' as adaption_values FROM public.telematics_data
        ]]  
```

When the endpoint is running, it can be published through the associated connector using the following REST call:

```
curl --location --request POST 'https://supplier-data-plane.public/data/assets' \
--header 'X-Api-Key: <apikey>' \
--header 'Content-Type: application/json' \
--data-raw '{
  "asset": {
    "properties": {
      "asset:prop:id": "urn:cx:Graph:oem:BehaviourTwin",
      "asset:prop:contract": "urn:cx:Graph:oem",
      "asset:prop:name": "OEM portion of the Behaviour Twin RUL/HI Testdataset.",
      "asset:prop:description": "A graph asset/offering mounting Carena-X Testdata for Behaviour Twin.",
      "asset:prop:version": "20230124_testdata_new_bamm",
      "asset:prop:contenttype": "application/json, application/xml",
      "rdf:type":"<https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/cx_ontology.ttl#GraphAsset>",
      "rdfs:isDefinedBy": "<https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/load_spectrum_ontology.ttl>",
      "cx:protocol": "<urn:cx:Protocol:w3c:Http#SPARQL>",
      "cx:shape": "[ rdf:type sh:NodeShape ;\n  sh:targetClass cx:LoadSpectrum ;\n  sh:property [\n        sh:path cx:provisionedBy ;\n        sh:hasValue <bpn:legal:BPNL00000003AYRE> ;\n    ] ;\n  sh:property [\n        sh:path cx:Version ;\n        sh:hasValue 0^^xsd:long ;\n    ] ;\n  sh:property [\n        sh:path cx: ;\n        sh:class [ rdf:type sh:NodeShape ;\n  sh:targetClass cx:VehicleComponent ;\n  sh:property [\n        sh:path cx:isProducedBy ;\n        sh:hasValue <bpn:legal:BPNL00000003B2OM> ;\n    ] ] ];\n",
      "cx:isFederated": true
    }
  },
  "dataAddress": {
    "properties": {
      "asset:prop:id": "urn:cx:Graph:oem:BehaviourTwin",
      "baseUrl": "http://oem-provider-agent:8080/sparql",
      "type": "urn:cx:Protocol:w3c:Http#SPARQL",
      "proxyPath": "false",
      "proxyMethod": "true",
      "proxyQueryParams": "true",
      "proxyBody": "true",
      "authKey": "Authorization",
      "authCode": "<ingressauth>"
    }
  }
}'
```

## Deployment of the Remoting Agent

### Using the Preconfigured Docker Image

The remoting agent uses a version of RDF4J:

- [Remotin Agent based on RDF4J](ghcr.io/catenax-ng/product-knowledge/remoting-agent:0.7.4-SNAPSHOT)

### Deployment using a Helm umbrella chart

We have provided a helm chart which can be used as a sub-chart in a more complex umbrella.

Add the KA helm repo for that purpose:

```console
helm repo add catenax-knowledge https://catenax-ng.github.io/product-knowledge/infrastructure
```

Add aliased dependencies to your umbrella chart:

```yaml
dependencies:
  - name: remoting-agent
    repository: https://catenax-ng.github.io/product-knowledge/infrastructure
    version: 0.7.4-SNAPSHOT
    alias: supplier-remoting-agent
```

and update the dependencies

```console
helm dependencies update
```

You may now configure the deployment instances in your values.yaml in more detail (see the documentation of the [remoting agent chart](https://github.com/catenax-ng/product-knowledge/tree/feature/KA-188-extract-sub-charts/infrastructure/charts/remoting-agent)).

Note that the entries under the repositories object represent the individual bindings/endpoints which bind to your API

```yaml
# The supplier remoting agent
supplier-remoting-agent: 
  nameOverride: supplier-remoting-agent
  fullnameOverride: supplier-remoting-agent
  repositories:
    health: |-
      #
      # Rdf4j configuration for a health-specific remoting
      #
      @prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>.
      @prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>.
      @prefix rep: <http://www.openrdf.org/config/repository#>.
      @prefix sr: <http://www.openrdf.org/config/repository/sail#>.
      @prefix sail: <http://www.openrdf.org/config/sail#>.
      @prefix sp: <http://spinrdf.org/sp#>.
      @prefix xsd: <http://www.w3.org/2001/XMLSchema#> .
      @prefix json: <https://json-schema.org/draft/2020-12/schema#> .
      @prefix dcterms: <http://purl.org/dc/terms/> .
      @prefix cx-fx: <https://github.com/catenax-ng/product-knowledge/ontology/fx.ttl#>.
      @prefix cx-health: <https://github.com/catenax-ng/product-knowledge/ontology/health.ttl#>.
      @prefix cx-rt: <urn:io.catenax.knowledge.agents.remoting#>.

      [] rdf:type rep:Repository ;
        rep:repositoryID "health" ;
        rdfs:label "Health Prognosis Functions" ;
        rep:repositoryImpl [
            rep:repositoryType "openrdf:SailRepository" ;
            sr:sailImpl [
              sail:sailType "io.catenax.knowledge:Remoting" ;
              cx-fx:supportsInvocation cx-health:HealthIndication;
            ]
        ].

      cx-health:HealthIndication rdf:type cx-fx:Function;
        dcterms:description "Health Indication is an evaluation function operating on batches of load collectives and adaptive values."@en ;
        dcterms:title "Health Indication" ;
        cx-fx:targetUri "http://service-backend:5005/api/hi";
        cx-fx:invocationMethod "POST-JSON-MF";
        cx-fx:batch "100"^^xsd:long;
        cx-fx:inputProperty "hi_input.healthIndicatorInputs";
        cx-fx:invocationIdProperty "requestRefId";
        cx-fx:input cx-health:requestComponentId;
        cx-fx:input cx-health:classifiedLoadCollectiveProjectDescription;
        cx-fx:input cx-health:classifiedLoadCollectiveComponentDescription;
        cx-fx:input cx-health:classifiedLoadCollectiveCountingValue;
        cx-fx:input cx-health:classifiedLoadCollectiveCountingMethod;
        cx-fx:input cx-health:classifiedLoadCollectiveCountingUnit;
        cx-fx:input cx-health:classifiedLoadCollectiveChannels;
        cx-fx:input cx-health:classifiedLoadCollectiveCounts;
        cx-fx:input cx-health:classifiedLoadCollectiveClasses;
        cx-fx:input cx-health:adaptionValueVersion;
        cx-fx:input cx-health:adaptionValueTimestamp;
        cx-fx:input cx-health:adaptionValueMileage;
        cx-fx:input cx-health:adaptionValueOperatingTime;
        cx-fx:input cx-health:adaptionValueList;
        cx-fx:result cx-health:HealthIndicator.

      cx-health:HealthIndicator rdf:type cx-fx:Result;
        dcterms:description "Health Indicator is part of a indicator batch."@en ;
        dcterms:title "Health Indicator" ;
        cx-fx:outputProperty "healthIndicatorOutputs";
        cx-fx:resultIdProperty "componentId";
        cx-fx:correlationInput cx-health:requestComponentId;
        cx-fx:output cx-health:indicatorVersion;
        cx-fx:output cx-health:responseComponentId;
        cx-fx:output cx-health:healthIndicatorValues.

      cx-health:requestComponentId rdf:type cx-fx:Argument;
        dcterms:description "A Health Indicator Input relates to a component."@en ;
        dcterms:title "Health Indicator Component Id";
        cx-fx:argumentName "componentId".

      cx-health:classifiedLoadCollectiveProjectDescription rdf:type cx-fx:Argument;
        dcterms:description "A Load Collective has a project description."@en ;
        dcterms:title "Classified Load Collective Project Description";
        cx-fx:mandatory "false"^^xsd:boolean;
        cx-fx:argumentName "classifiedLoadCollective.metadata.projectDescription".

      cx-health:classifiedLoadCollectiveComponentDescription rdf:type cx-fx:Argument;
        dcterms:description "A Load Collective has a component description."@en ;
        dcterms:title "Classified Load Collective Component Description";
        cx-fx:argumentName "classifiedLoadCollective.metadata.componentDescription".

      cx-health:classifiedLoadCollectiveCountingValue rdf:type cx-fx:Argument;
        dcterms:description "A Load Collective has a value for the counting dimension."@en ;
        dcterms:title "Classified Load Collective Counting Value";
        cx-fx:mandatory "false"^^xsd:boolean;
        cx-fx:argumentName "classifiedLoadCollective.header.countingValue".

      cx-health:classifiedLoadCollectiveCountingUnit rdf:type cx-fx:Argument;
        dcterms:description "A Load Collective has a unit for the counting dimension."@en ;
        dcterms:title "Classified Load Collective Counting Unit";
        cx-fx:argumentName "classifiedLoadCollective.header.countingUnit".

      cx-health:classifiedLoadCollectiveCountingMethod rdf:type cx-fx:Argument;
        dcterms:description "A Load Collective has a method for the counting dimension."@en ;
        dcterms:title "Classified Load Collective Counting Method";
        cx-fx:argumentName "classifiedLoadCollective.header.countingMethod".

      cx-health:classifiedLoadCollectiveChannels rdf:type cx-fx:Argument;
        dcterms:description "A Load Collective has descriptors for all channels."@en ;
        dcterms:title "Classified Load Collective Channels";
        cx-fx:argumentName "classifiedLoadCollective.header.channels".

      cx-health:classifiedLoadCollectiveCounts rdf:type cx-fx:Argument;
        dcterms:description "A Load Collective has a body with the raw measurements."@en ;
        dcterms:title "Classified Load Collective Counts";
        cx-fx:argumentName "classifiedLoadCollective.body.counts".

      cx-health:classifiedLoadCollectiveClasses rdf:type cx-fx:Argument;
        dcterms:description "A Load Collective has a body with the class indices."@en ;
        dcterms:title "Classified Load Collective Classes";
        cx-fx:argumentName "classifiedLoadCollective.body.classes".

      cx-health:adaptionValueVersion rdf:type cx-fx:Argument;
        dcterms:description "A Health Indicator Adaption needs a version."@en ;
        dcterms:title "Adaption Value List Version";
        cx-fx:argumentName "adaptionValueList.version".

      cx-health:adaptionValueTimestamp rdf:type cx-fx:Argument;
        dcterms:description "A Health Indicator Adaption needs a timestamp."@en ;
        dcterms:title "Adaption Value List Timestamp";
        cx-fx:argumentName "adaptionValueList.timestamp".

      cx-health:adaptionValueMileage rdf:type cx-fx:Argument;
        dcterms:description "A Health Indicator Adaption needs a mileage of the embedding vehicle."@en ;
        dcterms:title "Adaption Value List Mileage";
        cx-fx:argumentName "adaptionValueList.mileage_km".

      cx-health:adaptionValueOperatingTime rdf:type cx-fx:Argument;
        dcterms:description "A Health Indicator Adaption needs an operating time of the embedding vehicle."@en ;
        dcterms:title "Adaption Value List Operating Time";
        cx-fx:argumentName "adaptionValueList.operatingtime_s".

      cx-health:adaptionValueList rdf:type cx-fx:Argument;
        dcterms:description "A Health Indicator Adaption needs an array of adaption values."@en ;
        dcterms:title "Adaption Value List Values";
        cx-fx:argumentName "adaptionValueList.values".

      cx-health:indicatorVersion rdf:type cx-fx:ReturnValue;
        dcterms:description "Version of the health indicator prognosis."@en ;
        dcterms:title "Health Indicator Prognosis Version" ;
        cx-fx:valuePath "version";
        cx-fx:dataType xsd:string.

      cx-health:responseComponentId rdf:type cx-fx:ReturnValue;
        dcterms:description "Component Id of the health indicator prognosis."@en ;
        dcterms:title "Health Indicator Prognosis Component Id" ;
        cx-fx:valuePath "componentId";
        cx-fx:dataType xsd:string.

      cx-health:healthIndicatorValues rdf:type cx-fx:ReturnValue;
        dcterms:description "Health Indicator Values are percentages."@en ;
        dcterms:title "Health Indicator Values" ;
        cx-fx:valuePath "healthIndicatorValues";
        cx-fx:dataType json:Object.
```

When the endpoint is running, it can be published through the associated connector using the following REST call:

```
curl --location --request POST 'https://supplier-data-plane.public/data/assets' \
--header 'X-Api-Key: <apikey>' \
--header 'Content-Type: application/json' \
--data-raw '{
  "asset": {
    "properties": {
      "asset:prop:id": "urn:cx:Graph:tierA:HealthIndicatorGearbox",
      "asset:prop:contract": "urn:cx:Graph:tierA",
      "asset:prop:name": "Health Indications Service for Gearboxes",
      "asset:prop:description": "Another sample graph asset/offering referring to a specific prognosis resource.",
      "asset:prop:version": "0.7.4-SNAPSHOT",
      "asset:prop:contenttype": "application/json, application/xml",
      "rdf:type":"<https://github.com/catenax-ng/product-knowledge/ontology/common_ontology.ttl#GraphAsset>",
      "rdfs:isDefinedBy": "<https://github.com/catenax-ng/product-knowledge/ontology/health.ttl>",
      "cx:protocol": "urn:cx:Protocol:w3c:Http#SPARQL",
      "cx:shape": "[ rdf:type sh:NodeShape ;\n  sh:targetClass cx-health:HealthIndication ;\n  sh:property [\n        sh:path cx:provisionedBy ;\n        sh:hasValue <urn:bpn:legal:BPNL00000003CPIY> ]].\n",
      "cx:isFederated": true
    }
  },
  "dataAddress": {
    "properties": {
      "asset:prop:id": "urn:cx:Graph:tierA:HealthIndicatorGearbox",
      "baseUrl": "http://supplier-remoting-agent:8081/rdf4j-server/repositories/health",
      "type": "urn:cx:Protocol:w3c:Http#SPARQL",
      "proxyPath": "false",
      "proxyMethod": "true",
      "proxyQueryParams": "true",
      "proxyBody": "true",
      "authKey": "Authorization",
      "authCode": "<ingresskey>"
    }
  }
}'
```
