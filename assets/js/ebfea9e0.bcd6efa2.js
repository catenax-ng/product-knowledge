"use strict";(self.webpackChunkproduct_knowledge_tractusx_github_io=self.webpackChunkproduct_knowledge_tractusx_github_io||[]).push([[1617],{3905:(e,n,t)=>{t.d(n,{Zo:()=>d,kt:()=>g});var a=t(67294);function o(e,n,t){return n in e?Object.defineProperty(e,n,{value:t,enumerable:!0,configurable:!0,writable:!0}):e[n]=t,e}function r(e,n){var t=Object.keys(e);if(Object.getOwnPropertySymbols){var a=Object.getOwnPropertySymbols(e);n&&(a=a.filter((function(n){return Object.getOwnPropertyDescriptor(e,n).enumerable}))),t.push.apply(t,a)}return t}function i(e){for(var n=1;n<arguments.length;n++){var t=null!=arguments[n]?arguments[n]:{};n%2?r(Object(t),!0).forEach((function(n){o(e,n,t[n])})):Object.getOwnPropertyDescriptors?Object.defineProperties(e,Object.getOwnPropertyDescriptors(t)):r(Object(t)).forEach((function(n){Object.defineProperty(e,n,Object.getOwnPropertyDescriptor(t,n))}))}return e}function l(e,n){if(null==e)return{};var t,a,o=function(e,n){if(null==e)return{};var t,a,o={},r=Object.keys(e);for(a=0;a<r.length;a++)t=r[a],n.indexOf(t)>=0||(o[t]=e[t]);return o}(e,n);if(Object.getOwnPropertySymbols){var r=Object.getOwnPropertySymbols(e);for(a=0;a<r.length;a++)t=r[a],n.indexOf(t)>=0||Object.prototype.propertyIsEnumerable.call(e,t)&&(o[t]=e[t])}return o}var s=a.createContext({}),c=function(e){var n=a.useContext(s),t=n;return e&&(t="function"==typeof e?e(n):i(i({},n),e)),t},d=function(e){var n=c(e.components);return a.createElement(s.Provider,{value:n},e.children)},p="mdxType",u={inlineCode:"code",wrapper:function(e){var n=e.children;return a.createElement(a.Fragment,{},n)}},m=a.forwardRef((function(e,n){var t=e.components,o=e.mdxType,r=e.originalType,s=e.parentName,d=l(e,["components","mdxType","originalType","parentName"]),p=c(t),m=o,g=p["".concat(s,".").concat(m)]||p[m]||u[m]||r;return t?a.createElement(g,i(i({ref:n},d),{},{components:t})):a.createElement(g,i({ref:n},d))}));function g(e,n){var t=arguments,o=n&&n.mdxType;if("string"==typeof e||o){var r=t.length,i=new Array(r);i[0]=m;var l={};for(var s in n)hasOwnProperty.call(n,s)&&(l[s]=n[s]);l.originalType=e,l[p]="string"==typeof e?e:o,i[1]=l;for(var c=2;c<r;c++)i[c]=t[c];return a.createElement.apply(null,i)}return a.createElement.apply(null,t)}m.displayName="MDXCreateElement"},12107:(e,n,t)=>{t.r(n),t.d(n,{assets:()=>s,contentTitle:()=>i,default:()=>p,frontMatter:()=>r,metadata:()=>l,toc:()=>c});var a=t(87462),o=(t(67294),t(3905));const r={sidebar_position:1,title:"API"},i=void 0,l={unversionedId:"development-view/api",id:"development-view/api",title:"API",description:"The Agent API is designed along the W3C SPARQL 1.1",source:"@site/docs/development-view/api.md",sourceDirName:"development-view",slug:"/development-view/api",permalink:"/product-knowledge/docs/development-view/api",draft:!1,editUrl:"https://github.com/catenax-ng/product-knowledge/tree/feature/ART3-382-documentation/docs/development-view/api.md",tags:[],version:"current",sidebarPosition:1,frontMatter:{sidebar_position:1,title:"API"},sidebar:"docs",previous:{title:"Compiling",permalink:"/product-knowledge/docs/development-view/compile"},next:{title:"Invoke a Skill or Query (Simple)",permalink:"/product-knowledge/docs/development-view/api/agent/agent-get"}},s={},c=[{value:"Examples",id:"examples",level:2},{value:"Invoke a Locally-Stored Parameterized Skill (Simple)",id:"invoke-a-locally-stored-parameterized-skill-simple",level:3},{value:"Invoke a Dataspace-Stored Parameterized Skill (Flexible)",id:"invoke-a-dataspace-stored-parameterized-skill-flexible",level:3},{value:"Register a Parameterized Skill",id:"register-a-parameterized-skill",level:3},{value:"Invoke an Ad-hoc Query",id:"invoke-an-ad-hoc-query",level:3}],d={toc:c};function p(e){let{components:n,...t}=e;return(0,o.kt)("wrapper",(0,a.Z)({},d,t,{components:n,mdxType:"MDXLayout"}),(0,o.kt)("p",null,"The Agent API is designed along the ",(0,o.kt)("a",{parentName:"p",href:"https://www.w3.org/TR/sparql11-query/"},"W3C SPARQL 1.1"),"\nspecification. It represents the core interface of the ",(0,o.kt)("a",{parentName:"p",href:"architecture"},"Catena-X Knowledge Agents (CX KA)\nArchitecture")," to enable federated (i.e. distributed, but independent) and sovereign\n(i.e. collaborative, but controlled and secured) data processing over GAIA-X/IDS dataspaces."),(0,o.kt)("p",null,"For that purpose, this API is used in three different functions/building\nblocks of CX KA:"),(0,o.kt)("ol",null,(0,o.kt)("li",{parentName:"ol"},"As a Consumer-facing entrypoint into the dataspace (the so-called\nMatchmaking Agent)."),(0,o.kt)("li",{parentName:"ol"},"As a Provider-facing callback from the dataspace into the backend\n(the so-called Binding Agent)."),(0,o.kt)("li",{parentName:"ol"},'As an intermediate Transfer protocol between "Sinks" representing SPARQL Remote',(0,o.kt)("br",{parentName:"li"}),'Service Contexts (=sub queries/routines) and the\ncorresponding "Sources" representing backend-bound SPARQL Graph Contexts.\nThese Sinks and Sources are to be implemented using the\nEDC (Eclipse Dataspace Components) framework.')),(0,o.kt)("p",null,'For each of these three functions, a particular "profile" of this API\n(here: a fragment or variant of the full-blown SPARQL 1.1 specification)\nis employed:'),(0,o.kt)("ol",null,(0,o.kt)("li",{parentName:"ol"},"The KA-MATCH profile allows to call federated SPARQL logic as stored procedures\n(so-called Skills) based on a rich set of meta-data (ontology)"),(0,o.kt)("li",{parentName:"ol"},"The KA-BIND profile allows to delegate non-federated and data-focussed SPARQL sub-queries by compiling them into native backend API calls (e.g. in SQL or REST)."),(0,o.kt)("li",{parentName:"ol"},"The KA-TRANSFER profile allows to wrap (and unwrap) well-defined header and\nprotocol information from SPARQL into the generic payload of the EDC Http transfer.")),(0,o.kt)("p",null,"This API is already designed with alternative query protocols (such as GRAPHQL\nor Federated SQL) in mind."),(0,o.kt)("h2",{id:"examples"},"Examples"),(0,o.kt)("h3",{id:"invoke-a-locally-stored-parameterized-skill-simple"},"Invoke a Locally-Stored Parameterized Skill (Simple)"),(0,o.kt)("p",null,"see the ",(0,o.kt)("a",{parentName:"p",href:"api/agent/getAgent"},"AGENT GET")," method specification"),(0,o.kt)("pre",null,(0,o.kt)("code",{parentName:"pre",className:"language-console"},"curl --location '${KA-MATCH}/agent?asset=urn%3Acx%3ASkill%3Aconsumer%3ALifetime&(vin=WBAAL31029PZ00001&troubleCode=P0746&troubleCode=P0745)&(vin=WBAAL31029PZ00002&troubleCode=P0744)&(vin=WBAAL31029PZ00003&troubleCode=P0743)' \\\n--header 'Authorization: Basic ${UuencodedUsernameColonPassword}'\n")),(0,o.kt)("h3",{id:"invoke-a-dataspace-stored-parameterized-skill-flexible"},"Invoke a Dataspace-Stored Parameterized Skill (Flexible)"),(0,o.kt)("p",null,"see the ",(0,o.kt)("a",{parentName:"p",href:"api/agent/postAgent"},"AGENT POST")," method specification"),(0,o.kt)("pre",null,(0,o.kt)("code",{parentName:"pre",className:"language-console"},'curl --location \'${KA-MATCH}/agent?asset=${EDC-BUSINESSPARTNER}%23urn%3Acx%3ASkill%3Aconsumer%3ALifetime\' \\\n--header \'Content-Type: application/sparql-results+json\' \\\n--header \'Authorization: Basic ${UuencodedUsernameColonPassword}\' \\\n--data \'{\n    "head": {\n        "vars": [\n            "vin",\n            "troubleCode"\n        ]\n    },\n    "results": {\n        "bindings": [\n            {\n                "vin": {\n                    "type": "literal",\n                    "value": "WBAAL31029PZ00001"\n                },\n                "troubleCode": {\n                    "type": "literal",\n                    "value": "P0746"\n                }\n            },\n            {\n                "vin": {\n                    "type": "literal",\n                    "value": "WBAAL31029PZ00001"\n                },\n                "troubleCode": {\n                    "type": "literal",\n                    "value": "P0745"\n                }\n            },\n            {\n                "vin": {\n                    "type": "literal",\n                    "value": "WBAAL31029PZ00002"\n                },\n                "troubleCode": {\n                    "type": "literal",\n                    "value": "P0744"\n                }\n            }\n        ]\n    }\n}\'\n')),(0,o.kt)("h3",{id:"register-a-parameterized-skill"},"Register a Parameterized Skill"),(0,o.kt)("p",null,"see the ",(0,o.kt)("a",{parentName:"p",href:"api/agent/skill/postSkill"},"AGENT SKILL POST")," method specification"),(0,o.kt)("pre",null,(0,o.kt)("code",{parentName:"pre",className:"language-console"},"curl --location '${KA-MATCH}/agent/skill?asset=urn%3Acx%3ASkill%3Aconsumer%3ALifetime' \\\n--header 'Content-Type: application/sparql-query' \\\n--header 'Authorization: Basic ${UuencodedUsernameColonPassword}' \\\n--data-raw 'PREFIX xsd:           <http://www.w3.org/2001/XMLSchema#> \nPREFIX rdf:           <http://www.w3.org/1999/02/22-rdf-syntax-ns#>\nPREFIX rdfs:          <http://www.w3.org/2000/01/rdf-schema#>\nPREFIX cx:            <https://github.com/catenax-ng/product-knowledge/ontology/cx.ttl#>\n\n############################################################################################\n#                  Catena-X Knowledge Agents Sample Federated Skill           \n#                         Realizes a 5-Step Business Process                          \n#            \"Remaining Useful Life Prognosis based on Diagnosis TroubleCodes\"      \n############################################################################################\n# Preconditions:                                                                    \n# - A Contract Offering from OEM (e.g. BMW) to CONSUMER (e.g. ADAC)                 \n#   - VIN-VAN Conversion                                                            \n#   - DTC Analysis/Resolution (including the READING of PartType and Description)   \n#   - Serial Part & SUPPLIER Lookup                                                   \n# - A Contract Offering from SUPPLIER (e.g. ZF) to OEM                              \n#   - Telematics data (including the PROPAGATION of LoadSpectrum)                     \n#   - RUL Prognosis Invocation (including the DISTRIBUTION of RUL results)        \n############################################################################################\n\n####\n# 5. Project the actual output of the Skill on CONSUMER side\n####\nSELECT ?van ?troubleCode ?description ?affectedPart ?distanceKm ?timeDays ?vin WHERE {\n\n####\n# 1. The CONSUMER detects a trouble code on a car in his fleet\n####\nVALUES (?vin ?troubleCode) { (\"@vin\"^^xsd:string \"@troubleCode\"^^xsd:string) }.\n\n####\n# 2. The CONSUMER looks up the OEM (connector) associated to the VIN \n#    using the Federated Data Catalogue  (Catalogue=Default Graph)\n####\n?oem cx:isIssuerOfVehicleIdentificationNumber ?vin;\n        cx:hasConnector ?oemConnector.\n\n?oemConnector cx:offersAsset ?diagnoseAsset.\n?diagnoseAsset rdf:type <https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/cx_ontology.ttl#GraphAsset>;\n                rdfs:isDefinedBy <https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/diagnosis_ontology.ttl>.\n\n####\n# 3. The CONSUMER delegates the following logic to the OEM (connector)\n####\nSERVICE ?oemConnector { \n\n    ####\n    # 3.1 The OEM (e.g. BMW) anomyzes the VIN into an anomymous (VAN) node\n    #.    and gets some master data with it \n    ####\n    ?van cx:isAnonymousVehicle ?vin;\n        cx:hasRegistration ?registration.\n\n    ####\n    # 3.2 The OEM analyzes the DTC-affected part type (Diagnosis Graph)\n    ####\n    GRAPH ?diagnoseAsset {\n\n    ?Dtc rdf:type cx:DTC; \n        cx:Code ?troubleCode;\n        cx:affects [ cx:EnDenomination ?partType ]; \n        cx:Description ?description.\n    \n    } # OEM#Diagnosis context\n\n    ####\n    # 3.3 The OEM obtains fresh telematics/load-spectrum data for the vehicle\n    #     focussed to the problematic partType (Telematics Graph) \n    ####\n    ?van cx:latestMileageReceived ?mileage;\n        cx:latestDetailReceived ?telematicsDetail.\n    ?telematicsDetail cx:hasPartType ?partType;\n                    cx:hasLoadSpectrum ?loadSpectrum.\n\n    ####\n    # 3.4 The OEM looks up the serialized part of the VAN (Traceability Graph)\n    #     and the supplier address in the dataspace\n    ####\n    ?serializedPart cx:isComponentOf+ ?van;\n                    cx:hasPartType ?partType;\n                    cx:hasName ?affectedPart;\n                    cx:hasSupplier [\n                        cx:hasConnector ?tieraConnector\n                    ].           \n\n    ?tieraConnector cx:offersAsset ?prognosisAsset.\n    ?prognosisAsset rdfs:isDefinedBy <https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/prognosis_ontology.ttl>.\n\n    ####\n    # 4. The OEM (and not the CONSUMER) delegates to the SUPPLIER (connector)\n    #    which means that load spectrum data etc is only exchanged using their\n    #    contract and between their connectors.\n    ####\n    SERVICE ?tieraConnector { \n\n    ####\n    # 4.1 The SUPPLIER adds additional measurement information\n    ####\n    ?telematicsDetail cx:hasFile ?loadSpectrumFile;\n                        cx:hasHeader ?loadSpectrumHeader.\n\n    ####\n    # 4.2 The SUPPLIER invokes a prognosis model associated the part type using the load-spectrum data\n    ####\n    GRAPH ?prognosisAsset {\n\n        ?invocation rdf:type cx:LifetimePrognosis;\n            \n            # <--General vehicle info\n            cx:loadCollectiveMileage ?mileage;\n            cx:loadCollectiveRegistrationDate ?registration;\n\n            # <--Part Info from the OEM\n            cx:loadCollectiveComponent ?affectedPart;\n            cx:loadCollectiveBody ?loadSpectrum;\n            \n            # <--Additional info from the SUPPLIER\n            cx:loadCollectiveFile ?loadSpectrumFile;\n            cx:loadCollectiveHeader ?loadSpectrumHeader; \n            \n            # --\x3ethe actual prognosis output\n            cx:remainingDistance ?distanceKm; \n            cx:remainingTime ?timeDays.\n    \n    } # SUPPLIER#Prognosis context\n\n    } # SUPPLIER context\n\n} # OEM context\n\n    # now we do reporting/operationalising on the CONSUMER side\n} ORDER BY ?remainingDistance LIMIT 5'\n")),(0,o.kt)("h3",{id:"invoke-an-ad-hoc-query"},"Invoke an Ad-hoc Query"),(0,o.kt)("p",null,"see the ",(0,o.kt)("a",{parentName:"p",href:"api/agent/postAgent"},"AGENT POST")," method specification"),(0,o.kt)("pre",null,(0,o.kt)("code",{parentName:"pre",className:"language-console"},"curl --location '${KA-BIND}/agent' \\\n--header 'Content-Type: application/sparql-query' \\\n--header 'Authorization: Basic ${UuencodedUsernameColonPassword}' \\\n--data-raw 'PREFIX xsd:           <http://www.w3.org/2001/XMLSchema#> \nPREFIX rdf:           <http://www.w3.org/1999/02/22-rdf-syntax-ns#>\nPREFIX rdfs:          <http://www.w3.org/2000/01/rdf-schema#>\nPREFIX cx:            <https://github.com/catenax-ng/product-knowledge/ontology/cx.ttl#>\n\n# Sample Graph Context that is Delegated/Instantiated to a Binding Agent Call\nSELECT ?partType ?description WHERE {\n    VALUES (?troubleCode) { (\"P0745\"^^xsd:string) (\"P0746\"^^xsd:string) }.\n\n    ?Dtc rdf:type cx:DTC; \n        cx:Code ?troubleCode;\n        cx:affects [ cx:EnDenomination ?partType ]; \n        cx:Description ?description.\n        \n} \n")))}p.isMDXComponent=!0}}]);