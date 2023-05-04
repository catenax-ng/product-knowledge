"use strict";(self.webpackChunkproduct_knowledge_tractusx_github_io=self.webpackChunkproduct_knowledge_tractusx_github_io||[]).push([[6955],{3905:(e,t,a)=>{a.d(t,{Zo:()=>c,kt:()=>g});var n=a(67294);function o(e,t,a){return t in e?Object.defineProperty(e,t,{value:a,enumerable:!0,configurable:!0,writable:!0}):e[t]=a,e}function i(e,t){var a=Object.keys(e);if(Object.getOwnPropertySymbols){var n=Object.getOwnPropertySymbols(e);t&&(n=n.filter((function(t){return Object.getOwnPropertyDescriptor(e,t).enumerable}))),a.push.apply(a,n)}return a}function s(e){for(var t=1;t<arguments.length;t++){var a=null!=arguments[t]?arguments[t]:{};t%2?i(Object(a),!0).forEach((function(t){o(e,t,a[t])})):Object.getOwnPropertyDescriptors?Object.defineProperties(e,Object.getOwnPropertyDescriptors(a)):i(Object(a)).forEach((function(t){Object.defineProperty(e,t,Object.getOwnPropertyDescriptor(a,t))}))}return e}function r(e,t){if(null==e)return{};var a,n,o=function(e,t){if(null==e)return{};var a,n,o={},i=Object.keys(e);for(n=0;n<i.length;n++)a=i[n],t.indexOf(a)>=0||(o[a]=e[a]);return o}(e,t);if(Object.getOwnPropertySymbols){var i=Object.getOwnPropertySymbols(e);for(n=0;n<i.length;n++)a=i[n],t.indexOf(a)>=0||Object.prototype.propertyIsEnumerable.call(e,a)&&(o[a]=e[a])}return o}var l=n.createContext({}),d=function(e){var t=n.useContext(l),a=t;return e&&(a="function"==typeof e?e(t):s(s({},t),e)),a},c=function(e){var t=d(e.components);return n.createElement(l.Provider,{value:t},e.children)},p="mdxType",h={inlineCode:"code",wrapper:function(e){var t=e.children;return n.createElement(n.Fragment,{},t)}},u=n.forwardRef((function(e,t){var a=e.components,o=e.mdxType,i=e.originalType,l=e.parentName,c=r(e,["components","mdxType","originalType","parentName"]),p=d(a),u=o,g=p["".concat(l,".").concat(u)]||p[u]||h[u]||i;return a?n.createElement(g,s(s({ref:t},c),{},{components:a})):n.createElement(g,s({ref:t},c))}));function g(e,t){var a=arguments,o=t&&t.mdxType;if("string"==typeof e||o){var i=a.length,s=new Array(i);s[0]=u;var r={};for(var l in t)hasOwnProperty.call(t,l)&&(r[l]=t[l]);r.originalType=e,r[p]="string"==typeof e?e:o,s[1]=r;for(var d=2;d<i;d++)s[d]=a[d];return n.createElement.apply(null,s)}return n.createElement.apply(null,a)}u.displayName="MDXCreateElement"},94116:(e,t,a)=>{a.r(t),a.d(t,{assets:()=>l,contentTitle:()=>s,default:()=>p,frontMatter:()=>i,metadata:()=>r,toc:()=>d});var n=a(87462),o=(a(67294),a(3905));const i={sidebar_position:1,title:"Layers & Modules"},s=void 0,r={unversionedId:"development-view/modules",id:"development-view/modules",title:"Layers & Modules",description:"This chapter gives an overview how the Agent standard and Kit should be implemented in terms of layers and modules.",source:"@site/docs/development-view/modules.md",sourceDirName:"development-view",slug:"/development-view/modules",permalink:"/product-knowledge/docs/development-view/modules",draft:!1,editUrl:"https://github.com/catenax-ng/product-knowledge/tree/feature/ART3-382-documentation/docs/development-view/modules.md",tags:[],version:"current",sidebarPosition:1,frontMatter:{sidebar_position:1,title:"Layers & Modules"},sidebar:"docs",previous:{title:"High-Level Architecture",permalink:"/product-knowledge/docs/development-view/architecture"},next:{title:"AAS Bridge",permalink:"/product-knowledge/docs/development-view/aas/bridge"}},l={},d=[{value:"Semantic Models",id:"semantic-models",level:2},{value:"Ontology Editing &amp; Visualization",id:"ontology-editing--visualization",level:3},{value:"Ontology Management",id:"ontology-management",level:3},{value:"Data Consumption Layer/Query Definition",id:"data-consumption-layerquery-definition",level:2},{value:"Skill Framework",id:"skill-framework",level:3},{value:"Query/Skill Editor",id:"queryskill-editor",level:3},{value:"Data Consuming App",id:"data-consuming-app",level:3},{value:"Dataspace Layer",id:"dataspace-layer",level:2},{value:"EDC*",id:"edc",level:3},{value:"Matchmaking Agent",id:"matchmaking-agent",level:3},{value:"Federated Catalogue",id:"federated-catalogue",level:3},{value:"Backend Systems (Non-Standard Relevant)",id:"backend-systems-non-standard-relevant",level:2},{value:"AAS Servers and Databases",id:"aas-servers-and-databases",level:3},{value:"Virtualization Layer (Non-Standard Relevant)",id:"virtualization-layer-non-standard-relevant",level:2},{value:"ETL/Data Lakes",id:"etldata-lakes",level:3},{value:"API Gateway",id:"api-gateway",level:3},{value:"Binding Layer",id:"binding-layer",level:2},{value:"Virtual Knowledge Graph",id:"virtual-knowledge-graph",level:3},{value:"Functional Remoting",id:"functional-remoting",level:3},{value:"Graph Database",id:"graph-database",level:3},{value:"AAS-&gt;KA Bridge",id:"aas-ka-bridge",level:3},{value:"KA-&gt;AAS Bridge",id:"ka-aas-bridge",level:3}],c={toc:d};function p(e){let{components:t,...i}=e;return(0,o.kt)("wrapper",(0,n.Z)({},c,i,{components:t,mdxType:"MDXLayout"}),(0,o.kt)("p",null,"This chapter gives an overview how the Agent standard and Kit should be implemented in terms of layers and modules."),(0,o.kt)("p",null,"For more information see"),(0,o.kt)("ul",null,(0,o.kt)("li",{parentName:"ul"},"Our ",(0,o.kt)("a",{parentName:"li",href:"../adoption-view/intro"},"Adoption")," guideline"),(0,o.kt)("li",{parentName:"ul"},"The ",(0,o.kt)("a",{parentName:"li",href:"architecture"},"High-Level Architecture")),(0,o.kt)("li",{parentName:"ul"},"Our ",(0,o.kt)("a",{parentName:"li",href:"reference"},"Reference Implementation")),(0,o.kt)("li",{parentName:"ul"},"The ",(0,o.kt)("a",{parentName:"li",href:"../operation-view/deployment"},"Deployment")," guide")),(0,o.kt)("p",null,"In this context generic building blocks were defined (see Figure 4) which can be implemented with different open source or COTS solutions. In the scope of Catena-X project these building blocks are instantiated with a reference implementation based on open source components (the Knowledge Agents KIT). The detailed architecture following this reference implementation can be found here: ",(0,o.kt)("a",{parentName:"p",href:"https://catenax-ng.github.io/product-knowledge/docs/architecture"},"https://catenax-ng.github.io/product-knowledge/docs/architecture"),"."),(0,o.kt)("p",null,(0,o.kt)("a",{target:"_blank",href:a(86384).Z},(0,o.kt)("img",{alt:"Architecture High-Level",src:a(47054).Z,width:"400",height:"260"}))),(0,o.kt)("p",null,"In the following paragraphs, all building blocks relevant for this standard are introduced:"),(0,o.kt)("h2",{id:"semantic-models"},"Semantic Models"),(0,o.kt)("p",null,"Ontologies, as defined by W3C Web Ontology Language OWL 2 (",(0,o.kt)("a",{parentName:"p",href:"https://www.w3.org/OWL/"},"https://www.w3.org/OWL/"),") standard, provide the core of the KA catalogue. By offering rich semantic modelling possibilities, they contribute to a common understanding of existing concepts and their relations across the data space participants. To increase practical applicability, this standard contains an overview about most important concepts and best practices for ontology modelling relevant for the KA approach (see chapter 5). OWL comes with several interpretation profiles (",(0,o.kt)("a",{parentName:"p",href:"https://www.w3.org/TR/owl2-profiles/"},"https://www.w3.org/TR/owl2-profiles/"),") for different types of applications. For model checking and data validation (not part of this standard), we propose the Rule Logic (RL) profile. For query answering/data processing (part of this standard), we apply the Existential Logic (EL) profile (on the Dataspace Layer) and the Query Logic (QL) profile (on the Binding Layer)."),(0,o.kt)("h3",{id:"ontology-editing--visualization"},"Ontology Editing & Visualization"),(0,o.kt)("p",null,"To create and visualize ontology models, dedicated tooling is advised. For this purpose, various open source tools (e.g. Proteg\xe9) or commercial products (e.g. metaphacts) are available. We hence standardize on the ubiquitous RDF Terse Triple Language TTL (",(0,o.kt)("a",{parentName:"p",href:"https://www.w3.org/TR/turtle/"},"https://www.w3.org/TR/turtle/"),") format which is furthermore able to divide/merge large ontologies into/from modular domain ontology files."),(0,o.kt)("h3",{id:"ontology-management"},"Ontology Management"),(0,o.kt)("p",null,"To achieve model governance, a dedicated solution for ontology management is necessary. Key function is to give an overview about available models and their respective meta data and life cycle (e.g. in work, released, deprecated). Because of the big parallels, it is today best practice to perform ontology management through modern and collaborative source code versioning systems. The de-facto standard in this regard is GIT (in particular: its http/s protocol variant, including an anonymous read-only raw file access to release branches). In the following, we call the merged domain ontology files in a release branch \u201cthe\u201d (shared) Semantic Model (of that release). For practicability purposes, the Data Consumption and the Binding Layer could be equipped with only use-case and role-specific excerpts of that Semantic Model. While this may affect the results of model checking and validity profiles, it will not affect the query/data processing results."),(0,o.kt)("h2",{id:"data-consumption-layerquery-definition"},"Data Consumption Layer/Query Definition"),(0,o.kt)("p",null,"This layer comprises all applications which utilize provided data and functions of business partners to achieve a direct business impact and frameworks which simplify the development of these applications. Thus, this layer focuses on using a released Semantic Model (or a use-case/role-specific excerpt thereof) as a vocabulary to build flexible queries (Skills) and integrating these Skills in data consuming apps."),(0,o.kt)("p",null,"We rely on SPARQL 1.1 specification (",(0,o.kt)("a",{parentName:"p",href:"https://www.w3.org/TR/sparql11-query/"},"https://www.w3.org/TR/sparql11-query/"),") as a language and protocol to search for and process data across different business partners. As a part of this specification, we support the QUERY RESULTS JSON (",(0,o.kt)("a",{parentName:"p",href:"https://www.w3.org/TR/sparql11-results-json/"},"https://www.w3.org/TR/sparql11-results-json/"),") and the QUERY RESULTS XML (",(0,o.kt)("a",{parentName:"p",href:"https://www.w3.org/TR/rdf-sparql-XMLres/"},"https://www.w3.org/TR/rdf-sparql-XMLres/"),") formats to represent both the answer sets generated by SPARQL skills and the sets of input parameters that a SPARQL skill should be applied to. For answer sets, additional formats such as the QUERY RESULTS CSV and TSV (",(0,o.kt)("a",{parentName:"p",href:"https://www.w3.org/TR/sparql11-results-csv-tsv/"},"https://www.w3.org/TR/sparql11-results-csv-tsv/"),") format may be supported. Required is the ability to store and invoke SPARQL queries as parameterized procedures in the dataspace; this is a KA-specific extension to the SPARQL endpoint and is captured a concise Openapi specification in the following (",(0,o.kt)("a",{parentName:"p",href:"https://app.swaggerhub.com/apis/Catena-X/CX-KA-Agent-Specification/0.8.7#/"},"https://app.swaggerhub.com/apis/Catena-X/CX-KA-Agent-Specification/0.8.7#/"),"). Also part of that specification is an extended response behaviour which introduces the warning status code \u201c203\u201d and a response header \u201ccx_warning\u201d bound to a JSON structure that lists abnormal events or trace information that appeared during the processing."),(0,o.kt)("h3",{id:"skill-framework"},"Skill Framework"),(0,o.kt)("p",null,"Consumer/Client-side component, which is connected to the consumer dataspace components (the Matchmaking Agent via SPARQL, optionally: the EDC via the Data Management API). It is at least multi-user capable (can switch/lookup identities of the logged-in user), if not multi-tenant capable (can switch Matchmaking Agents and hence ED Connectors). It looks up references to Skills in the Dataspace and delegates their execution to the Matchmaking Agent. The Skill framework may maintain a \u201cconversational state\u201d per user (contextual memory which is a kind of graph/data set) which drives the workflow. It may also help to define, validate and maintain Skills in the underlying Dataspace Layer."),(0,o.kt)("h3",{id:"queryskill-editor"},"Query/Skill Editor"),(0,o.kt)("p",null,"To systematically build and maintain Skills, a query editor for easy construction and debugging queries is advisable. The skill editor should support syntax highlighting for the query language itself and it may support auto-complete based on the Semantic Model. A skill editor could also have a graphical model in which a procedure can be composed out of pre-defined blocks. Finally, a skill editor should have the ability to test-drive the execution of a skill (maybe without storing/publishing the skill and making any \u201cserious\u201d contract agreements in the dataspace and based on sample data)."),(0,o.kt)("h3",{id:"data-consuming-app"},"Data Consuming App"),(0,o.kt)("p",null,"Application that utilizes data of data providers to deliver added value to the user (e.g. CO2 footprint calculation tool). Skills can be easily integrated in these apps as stored procedure. Hence, skill and app development can be decoupled to increase efficiency of the app development process. For more flexible needs, Skills could be generated ad-hoc from templates based on the business logic and app data. The Data Consuming App could integrate a Skill Framework to encapsulate the interaction with the Dataspace Layer. The Consuming App could also integrate a Query/Skill Editor for expert users."),(0,o.kt)("h2",{id:"dataspace-layer"},"Dataspace Layer"),(0,o.kt)("p",null,"The base Dataspace-building technology is the Eclipse Dataspace Connector (EDC) which should be extended to operate as a HTTP/S contracting & transfer facility for the SPARQL-speaking Matchmaking Agent. To resolve dataspace offers and addresses using the ontological vocabulary, the Matchmaking Agent keeps a default meta-graph, the Federated Catalogue, that is used to host the Semantic Model and that is regularly synchronized with the relevant dataspace information including the offers of surrounding business partners/EDCs."),(0,o.kt)("p",null,(0,o.kt)("a",{target:"_blank",href:a(32707).Z},(0,o.kt)("img",{alt:"Dataspace Layer",src:a(14034).Z,width:"500",height:"179"}))),(0,o.kt)("h3",{id:"edc"},"EDC*"),(0,o.kt)("p",null,"Actually, the Eclipse Dataspace Connector (see Catena-X Standard CX-00001) consists of two components which both have to be extended (using the EDC extension mechanism) for KA enablement. The Control Plane hosts the actual management/negotiation engine and is usually a singleton that is exposing"),(0,o.kt)("p",null,"an internal (api-key secured) API for managing the control plane by administrative accounts/apps and the Matchmaking Agent\nManages Assets (=Internal Addresses including security and other contextual information into the Binding/Virtualization/Backend Layers together with External meta-data/properties of the Assets for discovery and self-description)\nManages Policies (=Conditions regarding the validity of Asset negotiations and interactions)\nManages Contract Definitions (=Offers are combinations of Assets and Policies and are used to build up a Catalogue)\na public (DAPS-secured) IDS API for coordination with other control planes of other business partners to setup transfer routings between the data planes.\nstate machines for monitoring (data) transfer processes which are actually executed by the (multiple, scalable) data plane(s). KA introduces a new transfer process type \u201cHttpProtocol\u201d which works like the standard \u201cHttpProxy\u201d transfer but enables sub-protocols of http/s (such as SPARQL) installing dedicated routing logic in the data plane(s) (see below)\na validation engine which currently operates on static tokens/claims which are extracted from the transfer flow but may be extended with additional properties in order to check additional runtime information in the form of properties\ncallback triggers for announcing transfer endpoints to the data plane to external applications, such as the Matchmaking Agent (or other direct EDC clients, frameworks and applications). We want to support multiple Matchmaking Agent instances per EDC for load-balancing purposes and we also like to allow for a bridged operation with other non-KA use cases, so it should be possible to configure several endpoint callback listeners per control plane.\nThe Data Plane (multiple instances) performs the actual data transfer tasks as instrumented by the control plane. The data plane exposes transfer-specific capabilities (Sinks and Sources) to adapt the actual endpoint/asset protocols (in the EDC standard: the asset type)."),(0,o.kt)("p",null,"Graph Assets use the asset type \u201curn:cx:Protocol:w3c:Http#SPARQL\u201d. In their address part, the following properties are supported\n\u201casset:prop:id\u201d \u2013 The name under which the Graph will be offered. Should be a proper IRI/URN, such as urn:io.catenax.knowledge.dataspace:GraphAsset#TelematicsSupplier\n\u201cbaseUrl\u201d \u2013 The endpoint URL of the binding agent (see below). Should be a proper http/s SPARQL endpoint.\n\u201cproxyPath\u201d \u2013 must be set to \u201cfalse\u201d\n\u201cproxyQueryParams\u201d \u2013 must be set to \u201ctrue\u201d\n\u201cproxyBody\u201d \u2013 must be set to \u201ctrue\u201d\n\u201cauthKey\u201d \u2013 optional authentication header, e.g. \u201cX-Api-Key\u201d\n\u201cauthCode\u201d \u2013 optional authentication value, such as an API key\n\u201cheader:Host\u201d \u2013 optional fixed Host header forwarded to the endpoint\n\u201cheader:Accepts\u201d \u2013 optional fixed Accepts header forwarded to the endpoint, e.g., \u201capplication/sparql-results+json\u201d\nSkill Assets use the asset type \u201curn:cx:Protocol:w3c:Http#SKILL\u201d. In their address part, the following properties are supported\n\u201casset:prop:id\u201d \u2013 The name under which the Skill will be offered. Should be a proper IRI/URN, such as urn:io.catenax.knowledge.dataspace:SkillAsset#TelematicsOEM\n\u201cbaseUrl\u201d \u2013 should be empty or will be ignored\n\u201cquery\u201d \u2013 A valid and parameterized SPARQL query\n\u201cproxyPath\u201d \u2013 must be set to \u201cfalse\u201d\n\u201cproxyQueryParams\u201d \u2013 must be set to \u201ctrue\u201d\n\u201cproxyBody\u201d \u2013 must be set to \u201cfalse\u201d\nIn their description part, Skill Assets and Graph Assets can have the following properties:\n\u201casset:prop:id\u201d \u2013 Equal to the corresponding field in the internal address.\n\u201ccx:hasRole\u201d \u2013 An RDF description listing the Use case Roles that this asset belongs to, e.g. \u201c<urn:io.catenax.knowledge.dataspace:UseCaseRole#TelematicsOEM>\u201d\n\u201casset:prop:name\u201d \u2013 Title of the asset in the default language.\n\u201casset:prop:name@de\u201d \u2013 Title of the asset in German (or other languages accordingly.\n\u201casset:prop:description\u201d, \u201casset:prop:name@de\u201d, \u2026 - Description of the Asset\n\u201casset:prop:version\u201d \u2013 A version IRI which is a download URI for the Asset Desccription as a separate file\n\u201casset:prop:contenttype\u201d \u2013 A valid Content-Type constraint to list the available response formats, e.g. \u201capplication/sparql-results+json, application/sparql-results+xml\u201d\n\u201crdf:type\u201d \u2013 Iri of the Asset Type, \u201c<urn:io.catenax.knowledge.dataspace:GraphAsset>\u201d for graph assets and \u201c<urn:io.catenax.knowledge.dataspace:SkillAsset>\u201d for skill assets.\n\u201crdfs:isDefinedBy\u201d \u2013 An RDF description listing the Use case ontologies that this asset belongs to, e.g., \u201c<urn:io.catenax.knowledge.dataspace:UseCase#Telematics>\u201d\n\u201ccx:protocol\u201d \u2013 should be set to \u201c<urn:cx:Protocol:w3c:Http#SPARQL>\u201d\n\u201ccx:shape\u201d \u2013 contains a SHACL constraint description which describes the contents of the Graph Asset or the SPARQL text of the query (in case this is a \u201cfree\u201d Skill)\n\u201ccx:isFederated\u201d \u2013 a Boolean indicating whether this asset should appear in the federated data catalogue (and hence can be dynamically resolved)\nFor both Graph and Skill Assets, appropriate Sink and Source implementations have to be registered which operate just as the standard HttpSink and HttpSource, but cater for some additional peculiarities. In particular, the \u201cAgentSource\u201d\nshould unwrap the original \u201cAccepts\u201d header from the payload that is enclosed within the \u201ccx_accepts\u201d parameter\ncomplete the payload with any additional headers (and the query parameter) as given in the assets address properties.\nMay parse the query and validate the given data address using additional runtime information from the query, the header, the parameters and extended  policies with the help of the extended control plane.\nrewrite the resulting SPARQL query parameter/body by replacing any occurrence of the Asset-URI \u201cGRAPH <?assetUri>\u201d with the actual URL of the asset baseUrl (SERVICE <?baseUrl>).\nMay rewrite the query using the \u201ccx:shape\u201d property of the GraphAsset in order to enforce particular constraints.\nDelegate the resulting call to the Matchmaking Agent."),(0,o.kt)("h3",{id:"matchmaking-agent"},"Matchmaking Agent"),(0,o.kt)("p",null,"This component which is the first stage of SPARQL processing serves several purposes. It operates as the main invocation point to the Data Consuming Layer. It operates as the main bridging point between incoming EDC transfers (from an \u201cAgent Source\u201d) and the underlying Binding Layer. And it implements federation by delegating any outgoing SERVICE/GRAPH contexts to the EDC. The Matchmaking Agent"),(0,o.kt)("p",null,"Should  perform a realm-mapping from the tenant domain (Authentication Scheme, such as API-Key and Oauth2) into the dataspace domain (EDC tokens)\nShould use the EDC management API in order to negotiate outgoing \u201cHttpProtocol\u201d transfers. It may use parallelism and asynchronity to perform multiple such calls simultaneously. It will wrap any inbound \u201cAccept\u201d header requirements as an additional \u201ccx_accept\u201d parameter to the transfer sink.\nShould operate as a endpoint callback listener, such that the setup transfers can invoke the data plane\nUses and Maintains the Federated Catalogue as an RDF store.\nShould be able to access Binding Agents by means of \u201cSERVICE\u201d contexts in the SPARQL standard. Hereby, the Matchmaking Agent should be able to restrict the type of sub-queries that are forwarded. For practicability purposes, Binding Agents need only support a subset of SPARQL and OWL (no embedded GRAPH/SERVICE contexts, no transitive closures and inversion, no object variables in rdf:type, no owl:sameAs lookups, \u2026).\nSince EDC and Matchmaking Agent are bidirectionally coupled, implementations could merge Data Plane and Matchmaking Agent into a single package, the so-called Agent Plane. Agent Planes and ordinary Data Planes can co-exist due to our design choices."),(0,o.kt)("h3",{id:"federated-catalogue"},"Federated Catalogue"),(0,o.kt)("p",null,"The Federated Catalogue is an RDF data storage facility for the Matchmaking Agent. It could be an in-memory triple store (that is restored via downloading TTL and configuration files upon restart) or an ordinary relational database that has been adapted to fit to the chosen Matchmaking Agent implementation. One example of such an interface is the RDF4J SAIL compliant to all RDF4J based SPARQL engines."),(0,o.kt)("p",null,"The Federated Catalogue should initially download the complete Semantic Model that has been released for the target environment. It should also contain a list of business partners and their roles which form the surrounding dataspace neighborhood of the tenant. For that purpose, It could use GPDM and Self-Description Hub services in order to lookup EDC addresses and additional domain information (sites, geo addresses). It should then be frequently updated with \u201clive\u201d information by invoking the EDC data management API to regularly obtain catalogue information."),(0,o.kt)("p",null,"The portion of the Semantic Model describing these meta-data (Business Partners, Sites, Addresses, Use Cases, Use Case Roles, Connectors & Assets) is called the Common domain ontology and is mandatory for all releases/excerpts of the Semantic Model (",(0,o.kt)("a",{parentName:"p",href:"https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/common_ontology.ttl"},"https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/common_ontology.ttl"),")."),(0,o.kt)("h2",{id:"backend-systems-non-standard-relevant"},"Backend Systems (Non-Standard Relevant)"),(0,o.kt)("p",null,"(Legacy, Non-Dataspace) IT landscape of data space participants consisting of various backend systems, such as PLM, ERP, ObjectStores mostly located in the Enterprise Intranet and hosted/goverened by the business departments.\nHere, the actual data sources of all Catena-X participants is originated\nwhere they are served using custom, but mission-critical business or\ntechnological APIs in specific, transaction-oriented formats."),(0,o.kt)("h3",{id:"aas-servers-and-databases"},"AAS Servers and Databases"),(0,o.kt)("p",null,"As a special case of backend systems, we also regard existing AAS servers and databases as valid data sources\nto form a semantic dataspace."),(0,o.kt)("p",null,"See ",(0,o.kt)("a",{parentName:"p",href:"/product-knowledge/docs/development-view/aas/bridge"},"AAS Bridge")," for a more detailed explanation."),(0,o.kt)("h2",{id:"virtualization-layer-non-standard-relevant"},"Virtualization Layer (Non-Standard Relevant)"),(0,o.kt)("p",null,"The data virtualization layer fulfills the function of making the company\ninternal, department-hosted data available for cross-company data exchange\nscenarios, e.g. via data lakes, data warehouses or other enterprise\nmiddleware."),(0,o.kt)("p",null,"Instead of connecting each and every backend system separately to\nan published data source/sink (such as provided by Catena-X) it often makes\nsense to have this additional layer on top of backend systems\nwhich orchestrates data demand and supply across the systems."),(0,o.kt)("p",null,"Depending on company IT architecture different technologies can be used\nto build up this layer."),(0,o.kt)("h3",{id:"etldata-lakes"},"ETL/Data Lakes"),(0,o.kt)("p",null,"In this scenario data from connected backend systems is stored in a central repository, such as in a Data Lake or central Data Warehouse scenario. Here, different kinds of raw data can be stored, processed, and combined to new data sets, while still being centrally available for any access. Synchronization between backends and data lake is achieved via ETL processes."),(0,o.kt)("h3",{id:"api-gateway"},"API Gateway"),(0,o.kt)("p",null,"This approach offers users a unified and technically abstract view for querying and manipulating data across a range of disparate sources. As such, it can be used to create virtualized and integrated views of data in memory rather than executing data movement and physically storing integrated views."),(0,o.kt)("h2",{id:"binding-layer"},"Binding Layer"),(0,o.kt)("p",null,"Finally, the missing link between the Dataspace Layer and the Virtualization Layer is the Binding Layer. Hereby rather than mapping the data between different formats (e.g. Data Tables in CSV Format to and from Data Graphs in the TTL format) which is a mostly resource-consuming data transformation process, binding rather rewrites the actual queries (e.g. SPARQL into SQL, SPARQL into GraphQL or REST). In order to make this query rewriting not too complicated, a restricted subset of SPARQL is envisaged."),(0,o.kt)("h3",{id:"virtual-knowledge-graph"},"Virtual Knowledge Graph"),(0,o.kt)("p",null,"A Virtual Knowledge Graph has the aim to make the content of relational databases accessable as a virtual knowledge graph. Virtual in this context means that the data itself remains in the relational database. Furthermore, this building block provides the function to translate SPARQL to SQL queries (e.g. via R2RML mappings in TTL)."),(0,o.kt)("h3",{id:"functional-remoting"},"Functional Remoting"),(0,o.kt)("p",null,"The Functional Remoting building block allows translation of SPARQL queries to specific API calls, e.g. to trigger a certain computation function. Function Binding is described in a special RDF4J TTL configuration."),(0,o.kt)("h3",{id:"graph-database"},"Graph Database"),(0,o.kt)("p",null,"A graph database stores a pre-mapped Knowledge Graph in a dedicated RDF store. It can be combined with a Virtual Knowledge Graph in order to cache frequent accesses to the Virtualization Layer."),(0,o.kt)("h3",{id:"aas-ka-bridge"},"AAS->KA Bridge"),(0,o.kt)("p",null,"Special form of virtualization component which denormalizes/flattens & caches the often hierarchical\ninformation (Shells, Submodels, Submodel Elements) stored in backend AAS servers in order to make it\naccessible for ad-hoc querying."),(0,o.kt)("p",null,"See ",(0,o.kt)("a",{parentName:"p",href:"/product-knowledge/docs/development-view/aas/bridge"},"AAS Bridge")," for a more detailed explanation."),(0,o.kt)("h3",{id:"ka-aas-bridge"},"KA->AAS Bridge"),(0,o.kt)("p",null,"In order to form a twin-based, highly-standarized access to any graphTo allow for a more strict\nIn order to form a graph-based, flexible access to AAS backend components, we\nemploy a bridge virtualization module which denormalizes/caches the information\ninside Shells and Submodels."),(0,o.kt)("p",null,"See ",(0,o.kt)("a",{parentName:"p",href:"/product-knowledge/docs/development-view/aas/bridge"},"AAS Bridge")," for a more detailed explanation."))}p.isMDXComponent=!0},32707:(e,t,a)=>{a.d(t,{Z:()=>n});const n=a.p+"assets/files/dataspace_layer-dad78fc65accdeaaa9afc513a46d344b.png"},86384:(e,t,a)=>{a.d(t,{Z:()=>n});const n=a.p+"assets/files/layer_architecture-b3c9d3ef03a11d3f2646ae35d3eadac8.png"},14034:(e,t,a)=>{a.d(t,{Z:()=>n});const n=a.p+"assets/images/dataspace_layer_small-f83d2b4d94c2cbdfe427354f130833a8.png"},47054:(e,t,a)=>{a.d(t,{Z:()=>n});const n=a.p+"assets/images/layer_architecture_small-01c79d41e82911339f6fe18be6552bab.png"}}]);