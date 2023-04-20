export const ASSETS = {
  head: {
    vars: [
      'connector',
      'asset',
      'name',
      'description',
      'type',
      'version',
      'contentType',
      'shape',
      'isDefinedBy',
    ],
  },
  results: {
    bindings: [
      {
        connector: {
          type: 'uri',
          value:
            'edcs://knowledge.int.demo.catena-x.net/oem-edc-control/BPNL00000003COJN',
        },
        asset: {
          type: 'uri',
          value: 'urn:cx:Graph:oem:Diagnosis2022',
        },
        name: {
          type: 'literal',
          value: 'Diagnostic Trouble Code Catalogue Version 2022',
        },
        description: {
          type: 'literal',
          value:
            'A sample graph asset/offering referring to a specific diagnosis resource.',
        },
        type: {
          type: 'uri',
          value:
            'https://github.com/catenax-ng/product-knowledge/ontology/common_ontology.ttl#GraphAsset',
        },
        version: {
          type: 'literal',
          value: '0.5.5-SNAPSHOT',
        },
        contentType: {
          type: 'literal',
          value: 'application/json, application/xml',
        },
        shape: {
          type: 'literal',
          value:
            '@prefix : <urn:cx:Graph:oem:Diagnosis2022> .\n@prefix cx: <https://github.com/catenax-ng/product-knowledge/ontology/cx.ttl#> .\n@prefix cx-diag: <https://github.com/catenax-ng/product-knowledge/ontology/diagnosis.ttl#> .\n@prefix owl: <http://www.w3.org/2002/07/owl#> .\n@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .\n@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .\n@prefix sh: <http://www.w3.org/ns/shacl#> .\n\nOemDTC rdf:type sh:NodeShape ;\n  sh:targetClass cx-diag:DTC ;\n  sh:property [\n        sh:path cx:provisionedBy ;\n        sh:hasValue <https://github.com/catenax-ng/product-knowledge/ontology/cx.ttl#BusinessPartner/BPNL00000003COJN> ;\n    ] ;\n  sh:property [\n        sh:path cx-diag:Version ;\n        sh:hasValue 0^^xsd:long ;\n    ] ;\n  sh:property [\n        sh:path cx-diag:Affects ;\n        sh:class OemDiagnosedParts ;\n    ] ;\n\nOemDiagnosedParts rdf:type sh:NodeShape ;\n  sh:targetClass cx-diag:DiagnosedPart ;\n  sh:property [\n        sh:path cx:provisionedBy ;\n        sh:hasValue <https://github.com/catenax-ng/product-knowledge/ontology/cx.ttl#BusinessPartner/BPNL00000003COJN> ;\n    ] ;\n',
        },
        isDefinedBy: {
          type: 'literal',
          value:
            '<https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/common_ontology.ttl>,<https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/error_ontology.ttl>,<https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/diagnosis_ontology.ttl>',
        },
      },
      {
        connector: {
          type: 'uri',
          value:
            'edcs://knowledge.int.demo.catena-x.net/consumer-edc-control/BPNL00000003CQI9',
        },
        asset: {
          type: 'uri',
          value: 'urn:cx:Skill:consumer:TroubleCodeSearch',
        },
        name: {
          type: 'literal',
          value:
            'Investigate Possible Trouble Codes per Vehicle and AssemblyGroupy',
        },
        description: {
          type: 'literal',
          value: 'Another sample skill asset/offering implemented via SparQL.',
        },
        type: {
          type: 'uri',
          value:
            'https://github.com/catenax-ng/product-knowledge/ontology/common_ontology.ttl#SkillAsset',
        },
        version: {
          type: 'literal',
          value: '0.6.5-SNAPSHOT',
        },
        contentType: {
          type: 'literal',
          value: 'application/json, application/xml',
        },
        shape: {
          type: 'literal',
          value:
            'PREFIX xsd:           <http://www.w3.org/2001/XMLSchema#>\nPREFIX rdf:           <http://www.w3.org/1999/02/22-rdf-syntax-ns#>\nPREFIX rdfs:          <http://www.w3.org/2000/01/rdf-schema#>\nPREFIX cx:            <https://github.com/catenax-ng/product-knowledge/ontology/cx.ttl#>\nPREFIX cx-diag:       <https://github.com/catenax-ng/product-knowledge/ontology/diagnosis.ttl#>\n\n##############################################################################################\n#              Catena-X Knowledge Agents Sample Federated Search Skill                       #\n#                     Implements Trouble-Code Search based on VINs                           #\n##############################################################################################\n# Preconditions:                                                                             #\n# - A Contract Offering from OEM (e.g. BMW) to CONSUMER (e.g. ADAC)                          #\n#   - VIN-VAN Conversion                                                                     #\n#   - DTC Analysis/Resolution (including the READING of Version and Description)             #\n##############################################################################################\n\nSELECT ?problemArea ?vin ?codeNumber ?description ?version WHERE {\n\n    ####\n    # Three parameters to the custom search\n    ####\n    VALUES (?vin ?problemArea ?minVersion) {("@vin"^^xsd:string "@problemArea"^^xsd:string "@minVersion"^^xsd:long)}\n\n    ####\n    # Lookup the responsible OEM(s)\n    ####\n    ?oem cx:isIssuerOfVehicleIdentificationNumber ?vin;\n         cx:hasConnector ?oemConnector.\n    ?oemConnector cx:offersAsset ?diagnoseAsset.\n    ?diagnoseAsset rdfs:isDefinedBy "https://github.com/catenax-ng/product-knowledge/ontology/diagnosis_ontology.ttl"^^xsd:string.\n\n    ####\n    # Delegate to the revelant connector(s) and asset(s)\n    ####\n    SERVICE ?oemConnector {\n        GRAPH ?diagnoseAsset {\n\n            ?Dtc rdf:type cx-diag:DTC;\n                 cx-diag:Code ?codeNumber;\n                 cx-diag:Description ?description;\n                 cx-diag:Version ?version.\n\n            FILTER ( CONTAINS(?description, ?problemArea) && ?version >= ?minVersion)\n       \n        } # Graph Asset\n    } # Remote Connector\n} # Search',
        },
        isDefinedBy: {
          type: 'literal',
          value:
            '<https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/common_ontology.ttl>,<https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/diagnosis_ontology.ttl>,<https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/error_ontology.ttl>',
        },
      },
      {
        connector: {
          type: 'uri',
          value:
            'edcs://knowledge.int.demo.catena-x.net/consumer-edc-control/BPNL00000003CQI9',
        },
        asset: {
          type: 'uri',
          value: 'urn:cx:Skill:consumer:Lifetime',
        },
        name: {
          type: 'literal',
          value: 'Remaining Useful Lifetime Skill for Vehicles',
        },
        description: {
          type: 'literal',
          value: 'A sample skill asset/offering implemented via SparQL.',
        },
        type: {
          type: 'uri',
          value:
            'https://github.com/catenax-ng/product-knowledge/ontology/common_ontology.ttl#SkillAsset',
        },
        version: {
          type: 'literal',
          value: '0.5.5-SNAPSHOT',
        },
        contentType: {
          type: 'literal',
          value: 'application/json, application/xml',
        },
        shape: {
          type: 'literal',
          value:
            'PREFIX xsd:           <http://www.w3.org/2001/XMLSchema#> \nPREFIX rdf:           <http://www.w3.org/1999/02/22-rdf-syntax-ns#>\nPREFIX rdfs:          <http://www.w3.org/2000/01/rdf-schema#>\nPREFIX cx:            <https://github.com/catenax-ng/product-knowledge/ontology/cx.ttl#>\nPREFIX cx-diag:       <https://github.com/catenax-ng/product-knowledge/ontology/diagnosis.ttl#>\nPREFIX cx-telematics: <https://github.com/catenax-ng/product-knowledge/ontology/telematics.ttl#>\nPREFIX cx-lifetime:   <https://github.com/catenax-ng/product-knowledge/ontology/lifetime.ttl#>\n\n##############################################################################################\n#                  Catena-X Knowledge Agents Sample Federated Skill                          #\n#                         Realizes a 5-Step Business Process                                 #\n#            "Remaining Useful Life Prognosis based on Diagnosis TroubleCodes"               #\n##############################################################################################\n# Preconditions:                                                                             #\n# - A Contract Offering from OEM (e.g. BMW) to CONSUMER (e.g. ADAC)                          #\n#   - VIN-VAN Conversion                                                                     #\n#   - DTC Analysis/Resolution (including the READING of PartType and Description)            #\n#   - Serial Part & SUPPLIER Lookup                                                          #\n# - A Contract Offering from SUPPLIER (e.g. ZF) to OEM                                       #\n#   - Telematics data (including the PROPAGATION of LoadSpectrum)                            #\n#   - RUL Prognosis Invocation (including the DISTRIBUTION of RUL results)                   #\n##############################################################################################\n\n####\n# 5. Project the actual output of the Skill on CONSUMER side\n####\nSELECT  ?van ?description ?serializedPartName ?distance ?time ?vin ?troubleCode WHERE {\n\n    ####\n    # 1. The CONSUMER detects a trouble code on a car in his fleet\n    ####\n    VALUES (?vin ?troubleCode) { ("@vin"^^xsd:string "@troubleCode"^^xsd:string) }.\n    \n    ####\n    # 2. The CONSUMER looks up the OEM (connector) associated to the VIN \n    #    using the Federated Data Catalogue  (Catalogue=Default Graph)\n    ####\n    ?oem cx:isIssuerOfVehicleIdentificationNumber ?vin;\n         cx:hasConnector ?oemConnector.\n\n    ?oemConnector cx:offersAsset ?diagnoseAsset.\n    ?diagnoseAsset rdfs:isDefinedBy "https://github.com/catenax-ng/product-knowledge/ontology/diagnosis_ontology.ttl"^^xsd:string.\n\n    ####\n    # 3. The CONSUMER delegates the following logic to the OEM (connector)\n    ####\n    SERVICE ?oemConnector { \n\n        ####\n        # 3.1 The OEM (e.g. BMW) anomyzes the VIN into an anomymous (VAN) node\n        #.    and gets some master data with it \n        ####\n        ?van cx:isAnonymousVehicle ?vin;\n             cx:hasRegistration ?registration.\n\n        ####\n        # 3.2 The OEM analyzes the DTC-affected part type (Diagnosis Graph)\n        ####\n        GRAPH ?diagnoseAsset {\n\n           ?Dtc rdf:type cx-diag:DTC; \n                cx-diag:Code ?troubleCode;\n                cx-diag:affects [ cx-diag:EnDenomination ?partType ]; \n                cx-diag:Description ?description.\n        \n        } # OEM#Diagnosis context\n\n        ####\n        # 3.3 The OEM obtains fresh telematics/load-spectrum data for the vehicle\n        #     focussed to the problematic partType (Telematics Graph) \n        ####\n        ?van cx-telematics:latestMileageReceived ?mileage;\n             cx-telematics:latestDetailReceived ?telematicsDetail.\n        ?telematicsDetail cx-diag:hasPartType ?partType;\n                          cx-diag:hasLoadSpectrum ?loadSpectrum.\n\n        ####\n        # 3.4 The OEM looks up the serialized part of the VAN (Traceability Graph)\n        #     and the supplier address in the dataspace\n        ####\n        ?serializedPart cx:isComponentOf+ ?van;\n                        cx:hasPartType ?partType;\n                        cx:hasName ?serializedPartName;\n                        cx:hasSupplier [\n                            cx:hasConnector ?tieraConnector\n                        ].           \n\n        ?tieraConnector cx:offersAsset ?prognosisAsset.\n        ?prognosisAsset rdfs:isDefinedBy "https://github.com/catenax-ng/product-knowledge/ontology/lifetime.ttl#"^^xsd:string.\n\n        ####\n        # 4. The OEM (and not the CONSUMER) delegates to the SUPPLIER (connector)\n        #    which means that load spectrum data etc is only exchanged using their\n        #    contract and between their connectors.\n        ####\n        SERVICE ?tieraConnector { \n\n            ####\n            # 4.1 The SUPPLIER adds additional measurement information\n            ####\n            ?telematicsDetail cx-telematics:hasFile ?loadSpectrumFile;\n                              cx-telematics:hasHeader ?loadSpectrumHeader.\n\n            ####\n            # 4.2 The SUPPLIER invokes a prognosis model associated the part type using the load-spectrum data\n            ####\n            GRAPH ?prognosisAsset {\n\n                ?invocation rdf:type cx-lifetime:LifetimePrognosis;\n                    \n                    # <--General vehicle info\n                    cx-lifetime:loadCollectiveMileage ?mileage;\n                    cx-lifetime:loadCollectiveRegistrationDate ?registration;\n\n                    # <--Part Info from the OEM\n                    cx-lifetime:loadCollectiveComponent ?serializedPartName;\n                    cx-lifetime:loadCollectiveBody ?loadSpectrum;\n                    \n                    # <--Additional info from the SUPPLIER\n                    cx-lifetime:loadCollectiveFile ?loadSpectrumFile;\n                    cx-lifetime:loadCollectiveHeader ?loadSpectrumHeader; \n                    \n                    # -->the actual prognosis output\n                    cx-lifetime:remainingDistance ?distance; \n                    cx-lifetime:remainingTime ?time.\n            \n            } # SUPPLIER#Prognosis context\n        \n        } # SUPPLIER context\n\n    } # OEM context\n\n   # now we do reporting/operationalising on the CONSUMER side\n} ORDER BY ?remainingDistance LIMIT 5',
        },
        isDefinedBy: {
          type: 'literal',
          value:
            '<https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/diagnosis_ontology.ttl>,<https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/vehicle_lifecycle_ontology.ttl>,<https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/cx_ontology.ttl>',
        },
      },
      {
        connector: {
          type: 'uri',
          value:
            'edcs://knowledge.int.demo.catena-x.net/consumer-edc-control/BPNL00000003CQI9',
        },
        asset: {
          type: 'uri',
          value: 'urn:cx:Skill:consumer:MaterialIncident',
        },
        name: {
          type: 'literal',
          value:
            'Analyse Sources and Impact of Geographically Fenced Material Incidents',
        },
        description: {
          type: 'literal',
          value: 'Another sample skill asset/offering implemented via SparQL.',
        },
        type: {
          type: 'uri',
          value:
            'https://github.com/catenax-ng/product-knowledge/ontology/common_ontology.ttl#SkillAsset',
        },
        version: {
          type: 'literal',
          value: '0.6.5-SNAPSHOT',
        },
        contentType: {
          type: 'literal',
          value: 'application/json, application/xml',
        },
        shape: {
          type: 'literal',
          value:
            'PREFIX cx: <https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/cx_ontology.ttl#>\nPREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>\nPREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>\nPREFIX xsd: <http://www.w3.org/2001/XMLSchema#> \n\n######\n# Sample "Material Incident" Search Skill \n# An incident has\n# - a description of the target material\n# - a geographical region (as a spatial segment)\n# The skill produces\n# - incident site(s) and source part(s)\n# - affected product(s) and organization(s)\n# - (m)bom trace(s) from source to product \n######\n\nSELECT ?site ?part ?partName ?vendor ?product ?productName ?lat ?lon ?part2 ?part3 ?part4 ?site2 ?site3 ?site4 ?site5 ?lat2 ?lon2 ?lat3 ?lon3 ?lat4 ?lon4 ?lat5 ?lon5 WHERE {\n\n  VALUES (?material ?latmin ?latmax ?lonmin ?lonmax) { \n      ("@material"^^xsd:string "@latmin"^^xsd:double "@latmax"^^xsd:double "@lonmin"^^xsd:double "@lonmax"^^xsd:double) \n  }\n\n  ## Look for production sites in the region\n  ## using the BPNM/Golden Record Catalogue\n  ?site cx:hasGeoInformation [\n      cx:hasLatitude ?lat;\n      cx:hasLongitude ?lon\n  ].\n  FILTER( ?lat >=  ?latmin && ?lat <= ?latmax &&\n          ?lon >=  ?lonmin && ?lon <= ?lonmax)\n  \n  ## Find the connector address of the responsible\n  ## businesspartner/orga from the federated data catalogue \n  ?incidentOrga cx:hasSite ?site;\n        cx:hasConnector ?connectorUrl.\n        \n  SERVICE ?connectorUrl {\n\n      ## Is there a product which has the incident "material"\n      ## workaround: use the part name\n       ?part rdf:type cx:Part;\n         cx:partName ?partName;\n         cx:isProducedBy ?site.\n       FILTER( CONTAINS(?partName, ?material)).\n\n      ?part cx:isPartOf ?part2.\n      ?part2 cx:partName ?part2Name;\n             cx:isProducedBy ?site2.\n  \n      OPTIONAL {\n          ?part2 cx:isPartOf ?part3.\n          ?part3 cx:partName ?part3Name;\n                 cx:isProducedBy ?site3.\n      }\n\n     OPTIONAL {\n          ?part3 cx:isPartOf ?part4.\n          ?part4 cx:partName ?part4Name;\n                 cx:isProducedBy ?site4.\n     }\n\n      OPTIONAL {\n          ?part4 cx:isPartOf ?product.\n          ?product cx:partName ?productName;\n                   cx:isProducedBy ?site5.\n     }\n  }\n\n  ?vendor cx:hasSite ?site5.\n  ?site2 cx:hasGeoInformation [\n      cx:hasLatitude ?lat2;\n      cx:hasLongitude ?lon2\n  ].\n  ?site3 cx:hasGeoInformation [\n      cx:hasLatitude ?lat3;\n      cx:hasLongitude ?lon3\n  ].\n  ?site4 cx:hasGeoInformation [\n      cx:hasLatitude ?lat4;\n      cx:hasLongitude ?lon4\n  ].\n  ?site5 cx:hasGeoInformation [\n      cx:hasLatitude ?lat5;\n      cx:hasLongitude ?lon5\n  ].\n} \n',
        },
        isDefinedBy: {
          type: 'literal',
          value:
            '<https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/cx_ontology.ttl>,<https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/material_ontology.ttl>',
        },
      },
      {
        connector: {
          type: 'uri',
          value:
            'edcs://knowledge.int.demo.catena-x.net/oem-edc-control/BPNL00000003COJN',
        },
        asset: {
          type: 'uri',
          value: 'urn:cx:Graph:oem:BehaviourTwin',
        },
        name: {
          type: 'literal',
          value: 'OEM portion of the Behaviour Twin RUL/HI Testdataset.',
        },
        description: {
          type: 'literal',
          value:
            'A graph asset/offering mounting Carena-X Testdata for Behaviour Twin.',
        },
        type: {
          type: 'uri',
          value:
            'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/cx_ontology.ttl#GraphAsset',
        },
        version: {
          type: 'literal',
          value: 'CX_RuL_Testdata_v1.0.0',
        },
        contentType: {
          type: 'literal',
          value: 'application/json, application/xml',
        },
        shape: {
          type: 'literal',
          value:
            '@prefix : <urn:cx:Graph:oem:BehaviourTwin> .\n@prefix cx: <https://github.com/catenax-ng/product-knowledge/ontology/cx.ttl#> .\n@prefix owl: <http://www.w3.org/2002/07/owl#> .\n@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .\n@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .\n@prefix sh: <http://www.w3.org/ns/shacl#> .\n\nOemLoadSpectrum rdf:type sh:NodeShape ;\n  sh:targetClass cx:LoadSpectrum ;\n  sh:property [\n        sh:path cx:provisionedBy ;\n        sh:hasValue <bpn:legal:BPNL00000003AYRE> ;\n    ] ;\n  sh:property [\n        sh:path cx:Version ;\n        sh:hasValue 0^^xsd:long ;\n    ] ;\n  sh:property [\n        sh:path cx: ;\n        sh:class SupplierParts ;\n    ] ;\n\nSupplierParts rdf:type sh:NodeShape ;\n  sh:targetClass cx:VehicleComponent ;\n  sh:property [\n        sh:path cx:isProducedBy ;\n        sh:hasValue <bpn:legal:BPNL00000003B2OM> ;\n    ] ;\n',
        },
        isDefinedBy: {
          type: 'literal',
          value:
            '<https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/cx_ontology.ttl>',
        },
      },
      {
        connector: {
          type: 'uri',
          value:
            'edcs://knowledge.int.demo.catena-x.net/consumer-edc-control/BPNL00000003CQI9',
        },
        asset: {
          type: 'uri',
          value: 'urn:cx:Graph:ntier:TraceabilityAsPlanned',
        },
        name: {
          type: 'literal',
          value: 'TierN portion of the Traceability As-Planned Testdataset.',
        },
        description: {
          type: 'literal',
          value:
            'A graph asset/offering mounting Carena-X Testdata for Traceability.',
        },
        type: {
          type: 'uri',
          value:
            'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/cx_ontology.ttl#GraphAsset',
        },
        version: {
          type: 'literal',
          value: 'CX_Testdata_v1.4.1-AsPlanned',
        },
        contentType: {
          type: 'literal',
          value: 'application/json, application/xml',
        },
        shape: {
          type: 'literal',
          value:
            '@prefix : <urn:cx:Graph:ntier:TraceabilityAsPlanned> .\n@prefix cx: <https://github.com/catenax-ng/product-knowledge/ontology/cx.ttl#> .\n@prefix owl: <http://www.w3.org/2002/07/owl#> .\n@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .\n@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .\n@prefix sh: <http://www.w3.org/ns/shacl#> .\n\nOemAssemblyGroup rdf:type sh:NodeShape ;\n  sh:targetClass cx:AssemblyGroup ;\n  sh:property [\n        sh:path cx:provisionedBy ;\n        sh:hasValue <bpn:legal:BPNL00000003AYRE> ;\n    ] ;\n  sh:property [\n        sh:path cx:Version ;\n        sh:hasValue 0^^xsd:long ;\n    ] ;\n  sh:property [\n        sh:path cx: ;\n        sh:class SupplierParts ;\n    ] ;\n\nSupplierParts rdf:type sh:NodeShape ;\n  sh:targetClass cx:Part ;\n  sh:property [\n        sh:path cx:isProducedBy ;\n        sh:hasValue <bpn:legal:BPNL00000003B2OM> ;\n    ] ;\n',
        },
        isDefinedBy: {
          type: 'literal',
          value:
            'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/cx_ontology.ttl',
        },
      },
      {
        connector: {
          type: 'uri',
          value:
            'edcs://knowledge.int.demo.catena-x.net/oem-edc-control/BPNL00000003COJN',
        },
        asset: {
          type: 'uri',
          value: 'urn:cx:Graph:oem:Quality',
        },
        name: {
          type: 'literal',
          value: 'Quality Data.',
        },
        description: {
          type: 'literal',
          value: 'A graph asset/offering mounting Quality data.',
        },
        type: {
          type: 'literal',
          value:
            'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/cx_ontology.ttl#GraphAsset',
        },
        version: {
          type: 'literal',
          value: 'v0.7.2',
        },
        contentType: {
          type: 'literal',
          value: 'application/json, application/xml',
        },
        shape: {
          type: 'literal',
          value: '@prefix : <urn:cx:Graph:oem:Quality> .',
        },
        isDefinedBy: {
          type: 'literal',
          value:
            'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/cx_ontology.ttl',
        },
      },
      {
        connector: {
          type: 'uri',
          value:
            'edcs://knowledge.int.demo.catena-x.net/tiera-edc-control/BPNL00000003CPIY',
        },
        asset: {
          type: 'uri',
          value: 'urn:cx:Graph:tierA:TraceabilityAsPlanned',
        },
        name: {
          type: 'literal',
          value: 'Supplier portion of the Traceability As-Planned Testdataset.',
        },
        description: {
          type: 'literal',
          value:
            'A graph asset/offering mounting Carena-X Testdata for Traceability.',
        },
        type: {
          type: 'literal',
          value:
            'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/cx_ontology.ttl#GraphAsset',
        },
        version: {
          type: 'literal',
          value: 'CX_Testdata_v1.4.1-AsPlanned',
        },
        contentType: {
          type: 'literal',
          value: 'application/json, application/xml',
        },
        shape: {
          type: 'literal',
          value:
            '@prefix : <urn:cx:Graph:tierA:TraceabilityAsPlanned> .\n@prefix cx: <https://github.com/catenax-ng/product-knowledge/ontology/cx.ttl#> .\n@prefix owl: <http://www.w3.org/2002/07/owl#> .\n@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .\n@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .\n@prefix sh: <http://www.w3.org/ns/shacl#> .\n\nOemAssemblyGroup rdf:type sh:NodeShape ;\n  sh:targetClass cx:AssemblyGroup ;\n  sh:property [\n        sh:path cx:provisionedBy ;\n        sh:hasValue <bpn:legal:BPNL00000003AYRE> ;\n    ] ;\n  sh:property [\n        sh:path cx:Version ;\n        sh:hasValue 0^^xsd:long ;\n    ] ;\n  sh:property [\n        sh:path cx: ;\n        sh:class SupplierParts ;\n    ] ;\n\nSupplierParts rdf:type sh:NodeShape ;\n  sh:targetClass cx:Part ;\n  sh:property [\n        sh:path cx:isProducedBy ;\n        sh:hasValue <bpn:legal:BPNL00000003B2OM> ;\n    ] ;\n',
        },
        isDefinedBy: {
          type: 'literal',
          value:
            'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/cx_ontology.ttl',
        },
      },
      {
        connector: {
          type: 'uri',
          value:
            'edcs://knowledge.int.demo.catena-x.net/oem-edc-control/BPNL00000003COJN',
        },
        asset: {
          type: 'uri',
          value: 'urn:cx:Graph:oem:TraceabilityAsPlanned',
        },
        name: {
          type: 'literal',
          value: 'OEM portion of the Traceability As-Planned Testdataset.',
        },
        description: {
          type: 'literal',
          value:
            'A graph asset/offering mounting Carena-X Testdata for Traceability.',
        },
        type: {
          type: 'literal',
          value:
            'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/cx_ontology.ttl#GraphAsset',
        },
        version: {
          type: 'literal',
          value: 'CX_Testdata_v1.4.1-AsPlanned',
        },
        contentType: {
          type: 'literal',
          value: 'application/json, application/xml',
        },
        shape: {
          type: 'literal',
          value:
            '@prefix : <urn:cx:Graph:oem:TraceabilityAsPlanned> .\n@prefix cx: <https://github.com/catenax-ng/product-knowledge/ontology/cx.ttl#> .\n@prefix owl: <http://www.w3.org/2002/07/owl#> .\n@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .\n@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .\n@prefix sh: <http://www.w3.org/ns/shacl#> .\n\nOemAssemblyGroup rdf:type sh:NodeShape ;\n  sh:targetClass cx:AssemblyGroup ;\n  sh:property [\n        sh:path cx:provisionedBy ;\n        sh:hasValue <bpn:legal:BPNL00000003AYRE> ;\n    ] ;\n  sh:property [\n        sh:path cx:Version ;\n        sh:hasValue 0^^xsd:long ;\n    ] ;\n  sh:property [\n        sh:path cx: ;\n        sh:class SupplierParts ;\n    ] ;\n\nSupplierParts rdf:type sh:NodeShape ;\n  sh:targetClass cx:Part ;\n  sh:property [\n        sh:path cx:isProducedBy ;\n        sh:hasValue <bpn:legal:BPNL00000003B2OM> ;\n    ] ;\n',
        },
        isDefinedBy: {
          type: 'literal',
          value:
            '<https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/cx_ontology.ttl>',
        },
      },
      {
        connector: {
          type: 'uri',
          value:
            'edcs://knowledge.int.demo.catena-x.net/tiera-edc-control/BPNL00000003CPIY',
        },
        asset: {
          type: 'uri',
          value: 'urn:cx:Graph:tierA:HealthIndicatorGearbox',
        },
        name: {
          type: 'literal',
          value: 'Health Indications Service for Gearboxes',
        },
        description: {
          type: 'literal',
          value:
            'Another sample graph asset/offering referring to a specific prognosis resource.',
        },
        type: {
          type: 'literal',
          value:
            'https://github.com/catenax-ng/product-knowledge/ontology/common_ontology.ttl#GraphAsset',
        },
        version: {
          type: 'literal',
          value: '0.6.2-SNAPSHOT',
        },
        contentType: {
          type: 'literal',
          value: 'application/json, application/xml',
        },
        shape: {
          type: 'literal',
          value:
            '@prefix : <urn:cx:Graph:tierA:HealthIndicatorGearbox> .\n@prefix cx: <https://github.com/catenax-ng/product-knowledge/ontology/cx.ttl#> .\n@prefix cx-lifetime: <https://github.com/catenax-ng/product-knowledge/ontology/lifetime.ttl#> .\n@prefix owl: <http://www.w3.org/2002/07/owl#> .\n@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .\n@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .\n@prefix sh: <http://www.w3.org/ns/shacl#> .\n :Tier1LifetimePrognosis rdf:type sh:NodeShape ;\n  sh:targetClass cx-lifetime:LifetimePrognosis ;\n  sh:property [\n        sh:path cx:provisionedBy ;\n        sh:hasValue <https://github.com/catenax-ng/product-knowledge/ontology/cx.ttl#BusinessPartner/BPNL00000003CPIY> ].\n',
        },
        isDefinedBy: {
          type: 'literal',
          value:
            '<https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/prognosis_ontology.ttl>',
        },
      },
      {
        connector: {
          type: 'uri',
          value:
            'edcs://knowledge.int.demo.catena-x.net/tiera-edc-control/BPNL00000003CPIY',
        },
        asset: {
          type: 'uri',
          value: 'urn:cx:Graph:tierA:LifetimeGearbox',
        },
        name: {
          type: 'literal',
          value: 'Lifetime Prognosis Service for Gearboxes',
        },
        description: {
          type: 'literal',
          value:
            'A sample graph asset/offering referring to a specific prognosis resource.',
        },
        type: {
          type: 'literal',
          value:
            'https://github.com/catenax-ng/product-knowledge/ontology/common_ontology.ttl#GraphAsset',
        },
        version: {
          type: 'literal',
          value: '0.5.5-SNAPSHOT',
        },
        contentType: {
          type: 'literal',
          value: 'application/json, application/xml',
        },
        shape: {
          type: 'literal',
          value:
            '@prefix : <urn:cx:Graph:tierA:LifetimeGearbox> .\n@prefix cx: <https://github.com/catenax-ng/product-knowledge/ontology/cx.ttl#> .\n@prefix cx-lifetime: <https://github.com/catenax-ng/product-knowledge/ontology/lifetime.ttl#> .\n@prefix owl: <http://www.w3.org/2002/07/owl#> .\n@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .\n@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .\n@prefix sh: <http://www.w3.org/ns/shacl#> .\n :Tier1LifetimePrognosis rdf:type sh:NodeShape ;\n  sh:targetClass cx-lifetime:LifetimePrognosis ;\n  sh:property [\n        sh:path cx:provisionedBy ;\n        sh:hasValue <https://github.com/catenax-ng/product-knowledge/ontology/cx.ttl#BusinessPartner/BPNL00000003CPIY> ].\n',
        },
        isDefinedBy: {
          type: 'literal',
          value:
            '<https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/prognosis_ontology.ttl>',
        },
      },
    ],
  },
  warnings: [
    {
      'source-tenant': 'BPNL00000003CQI9',
      'source-asset': 'urn:cx:GraphAsset#DefaultGraph',
      'target-tenant': 'BPNL00000003COJN',
      'target-asset': 'urn:cx:GraphAsset#supplier.TestGraph',
      problem: 'An example warning.',
      context: 'SPARQL-10478',
    },
  ],
};

export const SEARCH_RESULT = {
  head: {
    vars: ['vin', 'troubleCode', 'description', 'partProg', 'distance', 'time'],
  },
  results: {
    bindings: [
      {
        vin: {
          type: 'literal',
          value: 'WVA8984323420333',
        },
        troubleCode: {
          type: 'literal',
          value: 'P0745',
        },
        description: {
          type: 'literal',
          value: 'Getriebeöldruck-Magnetventil - Fehlfunktion Stromkreis',
        },
        partProg: {
          type: 'literal',
          value: '"GearOil"',
        },
        distance: {
          type: 'literal',
          datatype: 'http://www.w3.org/2001/XMLSchema#int',
          value: '150',
        },
        time: {
          type: 'literal',
          datatype: 'http://www.w3.org/2001/XMLSchema#int',
          value: '2',
        },
      },
    ],
  },
  warnings: [
    {
      'source-tenant': 'BPNL00000003CQI9',
      'source-asset': 'urn:cx:GraphAsset#DefaultGraph',
      'target-tenant': 'BPNL00000003COJN',
      'target-asset': 'urn:cx:GraphAsset#supplier.TestGraph',
      problem: 'An example warning.',
      context: 'SPARQL-10478',
    },
  ],
};

export const ONTOLOGIES = [
  {
    name: 'Address Ontology',
    download_url:
      'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/address_ontology.ttl',
    vowl: 'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/vowl/address_ontology.json',
    type: 'OWL',
    status: 'DRAFT',
    version: '0.8.5',
    assets: ['', ''],
  },
  {
    name: 'Common Ontology',
    download_url:
      'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/common_ontology.ttl',
    vowl: 'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/vowl/common_ontology.json',
    type: 'OWL',
    status: 'DRAFT',
    version: '0.8.5',
  },
  {
    name: 'Contact Ontology',
    download_url:
      'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/contact_ontology.ttl',
    vowl: 'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/vowl/contact_ontology.json',
    type: 'OWL',
    status: 'DRAFT',
    version: '0.8.5',
  },
  {
    name: 'CX Ontology',
    download_url:
      'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/cx_ontology.ttl',
    vowl: 'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/vowl/cx_ontology.json',
    type: 'OWL',
    status: 'DRAFT',
    version: '0.8.5',
  },
  {
    name: 'Diagnosis Ontology',
    download_url:
      'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/diagnosis_ontology.ttl',
    vowl: 'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/vowl/diagnosis_ontology.json',
    type: 'OWL',
    status: 'DRAFT',
    version: '0.8.5',
  },
  {
    name: 'Encoding Ontology',
    download_url:
      'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/encoding_ontology.ttl',
    vowl: 'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/vowl/encoding_ontology.json',
    type: 'OWL',
    status: 'DRAFT',
    version: '0.8.5',
  },
  {
    name: 'Error Ontology',
    download_url:
      'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/error_ontology.ttl',
    vowl: 'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/vowl/error_ontology.json',
    type: 'OWL',
    status: 'DRAFT',
    version: '0.8.5',
  },
  {
    name: 'Load Spectrum Ontology',
    download_url:
      'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/load_spectrum_ontology.ttl',
    vowl: 'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/vowl/load_spectrum_ontology.json',
    type: 'OWL',
    status: 'DRAFT',
    version: '0.8.5',
  },
  {
    name: 'Material Ontology',
    download_url:
      'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/material_ontology.ttl',
    vowl: 'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/vowl/material_ontology.json',
    type: 'OWL',
    status: 'DRAFT',
    version: '0.8.5',
  },
  {
    name: 'Part Ontology',
    download_url:
      'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/part_ontology.ttl',
    vowl: 'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/vowl/part_ontology.json',
    type: 'OWL',
    status: 'DRAFT',
    version: '0.8.5',
  },
  {
    name: 'Person Ontology',
    download_url:
      'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/person_ontology.ttl',
    vowl: 'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/vowl/person_ontology.json',
    type: 'OWL',
    status: 'DRAFT',
    version: '0.8.5',
  },
  {
    name: 'Prognosis Ontology',
    download_url:
      'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/prognosis_ontology.ttl',
    vowl: 'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/vowl/prognosis_ontology.json',
    type: 'OWL',
    status: 'DRAFT',
    version: '0.8.5',
  },
  {
    name: 'Vehicle Component Ontology',
    download_url:
      'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/vehicle_component_ontology.ttl',
    vowl: 'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/vowl/vehicle_component_ontology.json',
    type: 'OWL',
    status: 'DRAFT',
    version: '0.8.5',
  },
  {
    name: 'Vehicle Information Ontology',
    download_url:
      'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/vehicle_information_ontology.ttl',
    vowl: 'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/vowl/vehicle_information_ontology.json',
    type: 'OWL',
    status: 'DRAFT',
    version: '0.8.5',
  },
  {
    name: 'Vehicle Lifecycle Ontology',
    download_url:
      'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/vehicle_lifecycle_ontology.ttl',
    vowl: 'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/vowl/vehicle_lifecycle_ontology.json',
    type: 'OWL',
    status: 'DRAFT',
    version: '0.8.5',
  },
  {
    name: 'Vehicle Ontology',
    download_url:
      'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/vehicle_ontology.ttl',
    vowl: 'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/vowl/vehicle_ontology.json',
    type: 'OWL',
    status: 'DRAFT',
    version: '0.8.5',
  },
  {
    name: 'Vehicle Safety Ontology',
    download_url:
      'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/vehicle_safety_ontology.ttl',
    vowl: 'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/vowl/vehicle_safety_ontology.json',
    type: 'OWL',
    status: 'DRAFT',
    version: '0.8.5',
  },
  {
    name: 'Vehicle Usage Ontology',
    download_url:
      'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/vehicle_usage_ontology.ttl',
    vowl: 'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/vowl/vehicle_usage_ontology.json',
    type: 'OWL',
    status: 'DRAFT',
    version: '0.8.5',
  },
];
