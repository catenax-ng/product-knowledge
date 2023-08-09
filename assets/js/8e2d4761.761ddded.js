"use strict";(self.webpackChunkproduct_knowledge_tractusx_github_io=self.webpackChunkproduct_knowledge_tractusx_github_io||[]).push([[6909],{3905:(e,t,a)=>{a.d(t,{Zo:()=>d,kt:()=>m});var n=a(67294);function i(e,t,a){return t in e?Object.defineProperty(e,t,{value:a,enumerable:!0,configurable:!0,writable:!0}):e[t]=a,e}function r(e,t){var a=Object.keys(e);if(Object.getOwnPropertySymbols){var n=Object.getOwnPropertySymbols(e);t&&(n=n.filter((function(t){return Object.getOwnPropertyDescriptor(e,t).enumerable}))),a.push.apply(a,n)}return a}function o(e){for(var t=1;t<arguments.length;t++){var a=null!=arguments[t]?arguments[t]:{};t%2?r(Object(a),!0).forEach((function(t){i(e,t,a[t])})):Object.getOwnPropertyDescriptors?Object.defineProperties(e,Object.getOwnPropertyDescriptors(a)):r(Object(a)).forEach((function(t){Object.defineProperty(e,t,Object.getOwnPropertyDescriptor(a,t))}))}return e}function s(e,t){if(null==e)return{};var a,n,i=function(e,t){if(null==e)return{};var a,n,i={},r=Object.keys(e);for(n=0;n<r.length;n++)a=r[n],t.indexOf(a)>=0||(i[a]=e[a]);return i}(e,t);if(Object.getOwnPropertySymbols){var r=Object.getOwnPropertySymbols(e);for(n=0;n<r.length;n++)a=r[n],t.indexOf(a)>=0||Object.prototype.propertyIsEnumerable.call(e,a)&&(i[a]=e[a])}return i}var l=n.createContext({}),c=function(e){var t=n.useContext(l),a=t;return e&&(a="function"==typeof e?e(t):o(o({},t),e)),a},d=function(e){var t=c(e.components);return n.createElement(l.Provider,{value:t},e.children)},p="mdxType",u={inlineCode:"code",wrapper:function(e){var t=e.children;return n.createElement(n.Fragment,{},t)}},h=n.forwardRef((function(e,t){var a=e.components,i=e.mdxType,r=e.originalType,l=e.parentName,d=s(e,["components","mdxType","originalType","parentName"]),p=c(a),h=i,m=p["".concat(l,".").concat(h)]||p[h]||u[h]||r;return a?n.createElement(m,o(o({ref:t},d),{},{components:a})):n.createElement(m,o({ref:t},d))}));function m(e,t){var a=arguments,i=t&&t.mdxType;if("string"==typeof e||i){var r=a.length,o=new Array(r);o[0]=h;var s={};for(var l in t)hasOwnProperty.call(t,l)&&(s[l]=t[l]);s.originalType=e,s[p]="string"==typeof e?e:i,o[1]=s;for(var c=2;c<r;c++)o[c]=a[c];return n.createElement.apply(null,o)}return n.createElement.apply(null,a)}h.displayName="MDXCreateElement"},45016:(e,t,a)=>{a.r(t),a.d(t,{assets:()=>l,contentTitle:()=>o,default:()=>p,frontMatter:()=>r,metadata:()=>s,toc:()=>c});var n=a(87462),i=(a(67294),a(3905));const r={sidebar_position:7,title:"Detailed Architecture"},o=void 0,s={unversionedId:"development-view/Arc42",id:"development-view/Arc42",title:"Detailed Architecture",description:"This document describes the detailed Architecture of the Agents Standard and Kit based on ARC42 standard.",source:"@site/docs/development-view/Arc42.md",sourceDirName:"development-view",slug:"/development-view/Arc42",permalink:"/product-knowledge/docs/development-view/Arc42",draft:!1,editUrl:"https://github.com/catenax-ng/product-knowledge/tree/feature/ART3-382-documentation/docs/development-view/Arc42.md",tags:[],version:"current",sidebarPosition:7,frontMatter:{sidebar_position:7,title:"Detailed Architecture"},sidebar:"docs",previous:{title:"High-Level Architecture",permalink:"/product-knowledge/docs/development-view/architecture"},next:{title:"Layers & Modules",permalink:"/product-knowledge/docs/development-view/modules"}},l={},c=[{value:"Introduction and Goals",id:"introduction-and-goals",level:2},{value:"Constraints",id:"constraints",level:2},{value:"Context and Scope",id:"context-and-scope",level:2},{value:"Solution Strategy",id:"solution-strategy",level:2},{value:"Building Block View",id:"building-block-view",level:2},{value:"Runtime View",id:"runtime-view",level:2},{value:"Deployment View",id:"deployment-view",level:2}],d={toc:c};function p(e){let{components:t,...r}=e;return(0,i.kt)("wrapper",(0,n.Z)({},d,r,{components:t,mdxType:"MDXLayout"}),(0,i.kt)("p",null,"This document describes the detailed Architecture of the Agents Standard and Kit based on ARC42 standard."),(0,i.kt)("h2",{id:"introduction-and-goals"},"Introduction and Goals"),(0,i.kt)("p",null,"The main objective concerning the approach described in this section is to create a state-of-the-art compute-to-data architecture for automotive use cases (and beyond) based on standards and best practices around GAIA-X and W3C. To reach this aim, full semantic integration, search and query with focus on relations between entities and data sovereignty is focused. In contrast to a simple file-based data transfer, this shifts the responsibility for the access, authorization to the data and processing of the data from the application development to the provider and hence ultimately, the actual owner of the data. To achieve this aim, the Knowledge Agent standard shall achieve the following abilities:"),(0,i.kt)("ul",null,(0,i.kt)("li",{parentName:"ul"},"the ability to define well-formed and composable computations/scripts (skills) which operate over various assets of various business partners."),(0,i.kt)("li",{parentName:"ul"},"the ability to invoke and dynamically distribute these (sub-)skills over the relevant partners/connectors using an extensible agent interface."),(0,i.kt)("li",{parentName:"ul"},'the ability to safely provide data and service assets via appropriate agent implementations which "bind" the skill to the backend execution engines (rather than mapping data).'),(0,i.kt)("li",{parentName:"ul"},"the ability for an agent/connector/business partner to decide",(0,i.kt)("ul",{parentName:"li"},(0,i.kt)("li",{parentName:"ul"},"whether to hide particular data and computations inside a sub-skill"),(0,i.kt)("li",{parentName:"ul"},"whether to delegate/federate particular computations/sub-skills to other agents"),(0,i.kt)("li",{parentName:"ul"},"whether to migrate or clone an agent/asset from a partner"))),(0,i.kt)("li",{parentName:"ul"},"the ability to describe data and service assets as well as appropriate federation policies in the IDS vocabulary in order to allow for a dynamic matchmaking of skills and agents."),(0,i.kt)("li",{parentName:"ul"},"the ability to define domain/use case-based ontologies which form the vocabulary used in the skill definitions."),(0,i.kt)("li",{parentName:"ul"},"the ability to visualize and develop the ontologies and skills in appropriate SDKs and User Experience components.")),(0,i.kt)("p",null,"See also the KIT ",(0,i.kt)("a",{parentName:"p",href:"../adoption-view/intro"},"Introduction")," section and The ",(0,i.kt)("a",{parentName:"p",href:"architecture"},"High-Level Architecture"),"."),(0,i.kt)("h2",{id:"constraints"},"Constraints"),(0,i.kt)("p",null,"The Knowledge Agents Architecture is based on the Catena-X Dataspace Architecture with a specific focus on the Eclipse Dataspace Connector (EDC). It integrates with Catena-X Portal/Core Services & Identity Management principles and supports the typical interaction models as required by Catena-X Use Cases, such as"),(0,i.kt)("ul",null,(0,i.kt)("li",{parentName:"ul"},"Traceability with Focus on Low-Volume Bills-Of-Material Data and Deep Supply Chains with One-Up and One-Down Visibility"),(0,i.kt)("li",{parentName:"ul"},"Behaviour Twin with Focus on High-Volume Telematics Data and Flat and Trustful Supply Chain\xa0\xa0")),(0,i.kt)("p",null,"Furthermore, on the vocabulary/script level it utilizes and extends well-defined profiles of W3C Semantic Web Standards, such as OWL, RDF, SHACL, SPARQL."),(0,i.kt)("h2",{id:"context-and-scope"},"Context and Scope"),(0,i.kt)("p",null,"The standard is relevant for the following roles:"),(0,i.kt)("ul",null,(0,i.kt)("li",{parentName:"ul"},"Business Application Provider"),(0,i.kt)("li",{parentName:"ul"},"Enablement Service Provider"),(0,i.kt)("li",{parentName:"ul"},"Data Consumer"),(0,i.kt)("li",{parentName:"ul"},"Data Provider")),(0,i.kt)("p",null,"The following Catena-X stakeholders are affected by Knowledge Agent approach"),(0,i.kt)("ul",null,(0,i.kt)("li",{parentName:"ul"},(0,i.kt)("p",{parentName:"li"},(0,i.kt)("strong",{parentName:"p"},"Business Application Provider:")," Applications that use KA technology on behalf of a Dataspace Participant (e.g. a Fleet Monitor, an Incident Reporting Solution).")),(0,i.kt)("li",{parentName:"ul"},(0,i.kt)("p",{parentName:"li"},(0,i.kt)("strong",{parentName:"p"},"Enablement Service Provider:")," Services to assist Dataspace Participants/Applications in processing data based on KA technology (e.g. a Graph Database, a Virtual Graph Binding Engine, an EDC Package).\nAs a second path, Companies are addressed that want to provide compute resources (for example by a server or other KA-enabled Applications or Services) based on instances/configurations of KA-enabled EDC Packages, for example a Recycling Software Specialist")),(0,i.kt)("li",{parentName:"ul"},(0,i.kt)("p",{parentName:"li"},(0,i.kt)("strong",{parentName:"p"},"Data Consumer:")," Companies that want to use data and logic (for example by KA-enabled Applications or Services) based on instances/configurations of KA-enabled EDC Packages, such as a Recycling Company or a Tier-2 Automotive Supplier")),(0,i.kt)("li",{parentName:"ul"},(0,i.kt)("p",{parentName:"li"},(0,i.kt)("strong",{parentName:"p"},"Data Provider:")," Companies that want to provide data (for example by a backend database or other KA-enabled Applications or Services) based on instances/configurations of KA-enabled EDC Packages, for example an Automotive OEM. Companies that want to provide functions (for example by a REST endpoint or other KA-enabled Applications or Services) based on instances/configurations of KA-enabled EDC Packages, for example a Tier1 Sensor Device Supplier"))),(0,i.kt)("p",null,"Content-wise the following capabilities of Catena-X are addressed:"),(0,i.kt)("ul",null,(0,i.kt)("li",{parentName:"ul"},"Query and Search (Basic Mechanism, Integration in User Experiences)"),(0,i.kt)("li",{parentName:"ul"},"Services for making use of various federated data sources being part of a data space (Data & Function Provisioning, Logic Development & Provisioning)"),(0,i.kt)("li",{parentName:"ul"},"Semantic Modelling"),(0,i.kt)("li",{parentName:"ul"},"Publishing, Negotiation, Transfer Protocols and Policy Enforcement via IDS (EDC) connector")),(0,i.kt)("h2",{id:"solution-strategy"},"Solution Strategy"),(0,i.kt)("p",null,"Knowledge Agents regards the peer-to-peer Dataspace as one large (virtual) knowledge graph."),(0,i.kt)("p",null,"A graph, because the representation of data as a set of Triples (Outgoing-Node = Subject, Edge = Predicate, Receiving-Node = Object) is the highest form of normalization to which all other forms of structured data can be abstracted."),(0,i.kt)("p",null,"Virtual, because this graph is not centrally instantiated in a dedicated database, but it is manifested by a computation (traversal) which jumps from node to node (and hereby: from the sovereignity domain of one business partner to the another one including taking over authentication and authorization information).\xa0\xa0"),(0,i.kt)("p",null,"Knowledge because computations and graph contents are not arbitrary, but share common meta-data (again in the form of a graph interlinked with the actual instance graph) such that the vocabulary (at least: edge names) is standardized and computations can be formulated (offered)  independent of the data."),(0,i.kt)("p",null,"To reach that metaphor, the Knowledge Agents Architecture uses the following specifications, some of which are standard-relevant:"),(0,i.kt)("pre",null,(0,i.kt)("code",{parentName:"pre"},"* A general description language based on the Resource Description Framework (RDF)\n* A Meta-Model defined by OWL-R\n* A platform Ontology (consisting of several domain ontologies) as the Semantic Model\n* A description of graphs (=graph assets) which contain instance data for the Semantic Model (or: use-case driven and role-driven subsets thereof) and which may be described as SHACL constraints\n* A query language to traverse the graphs in SparQL and store these queries as skills (=skill assets) in the database\n")),(0,i.kt)("p",null,"Non-standard relevant, but provided as a best practice/blueprint architecture are"),(0,i.kt)("pre",null,(0,i.kt)("code",{parentName:"pre"},"* Bindings for relational and functional data\n  * R2RML or OBDA for relational data\n  * RDF4J/SAIL configuration for REST remoting\n* SQL- and REST-based Virtualizers which bridge public Dataspace Operations with internal/private backend systems/data sources.\n")),(0,i.kt)("p",null,"  ",(0,i.kt)("a",{target:"_blank",href:a(91658).Z},(0,i.kt)("img",{alt:"Example_Graph_Standards",src:a(41833).Z,width:"1124",height:"889"}))),(0,i.kt)("p",null,"Knowledge Agents regards the peer-to-peer Dataspace as one large federated execution engine."),(0,i.kt)("p",null,"Federation means distributed that is there is no central endpoint/resource which controls the computation, but the execution may be entered/triggered on any tenant and uses a scalable set of resources which are contributed by each participant."),(0,i.kt)("p",null,"Federation means independent in that there is no central authentication/authorization regime, but the computation is validated, controled and (transparently) delegated by decentral policies as given/defined be each particpant."),(0,i.kt)("p",null,"See also ",(0,i.kt)("a",{parentName:"p",href:"architecture"},"High-Level Architecture"),"."),(0,i.kt)("h2",{id:"building-block-view"},"Building Block View"),(0,i.kt)("p",null,"See chapter ",(0,i.kt)("a",{parentName:"p",href:"modules"},"Layers & Modules")),(0,i.kt)("p",null,(0,i.kt)("a",{target:"_blank",href:a(7802).Z},(0,i.kt)("img",{alt:"Architecture High-Level",src:a(36218).Z,width:"600",height:"447"}))),(0,i.kt)("h2",{id:"runtime-view"},"Runtime View"),(0,i.kt)("p",null,(0,i.kt)("a",{target:"_blank",href:a(51717).Z},(0,i.kt)("img",{alt:"Runtime View2",src:a(51106).Z,width:"1615",height:"943"}))),(0,i.kt)("p",null,"Sequence of actions:"),(0,i.kt)("pre",null,(0,i.kt)("code",{parentName:"pre"},'A data provider provides a self description of the piece of knowledge he likes to provide including the terms of conditions in his own data catalogue\n    * Graph assets describe\n      * node classes\n      * relations (arity) and \n      * constraints on nodes and relations (temporal, value ranges, ...)\xa0\n      * constraints on the queries/skills that may be executed on the graph\n    * Graph usage policies can restrict the following operations on graphs (given an execution context)\n      * selection\n      * traversion\n      * the storage\n      * the manipulation and the\n      * deletion of nodes and relations\xa0\xa0\nA data provider marks particular graph assets as being visible in the federated data catalog.\xa0The federated data catalogues of the federated companies/EDCs will be automatically synchronized.\nAny consuming app can employ an agent with a suitable skill/query (which can be provided locally or as a remote asset, too)\nThe agent will match the requirements in the skill with the offers in the federated data catalog to fill in the endpoints and usage policies from the self description. Optional: If necessary, needed attributes/claims have to be requested from a suitable issuer to get the verifiable credentials into the wallet.\nAgreements (between XA, XC, eventually between XB) have to be set up in such a way that the corresponding agents will be available through the data plane. Optional: Within EDC the contracts are negotiated and the needed attributes/claims are verified (see PEP, PDP and PIP).\nThe agent delegates a sub-query/sub-skill to the respective knowledge owners (data provider) for the knowledge via an instance of EDC. It annotates the sub-queries with a call context which contains the EDC/agent calling sequence and the other assets with which the result data \u2192 ohne data oder resulting data will be joined.\nThe data plane will validate the calling context together with the claims inside the agreement token.\xa0\u2192 im Schaubild gibt es zweimal Schritt "7"; eine der Beschreibungen fehlt hier also, oder?\nThe agent executes the actual query by mapping to a backend data system and finally provides the app the result\xa0\u2192 "provides the result to the app"? \u2192 auf "8" kommt zweimal vor; einmal als "bind" Schritt ins Backend, einmal als request\nThe agent can decide to delegate further down the line\xa0\u2192 sollte das auch im Schaubild zu sehen sein?\n')),(0,i.kt)("h2",{id:"deployment-view"},"Deployment View"),(0,i.kt)("p",null,"See chapter ",(0,i.kt)("a",{parentName:"p",href:"../operation-view/deployment"},"Deployment"),"."))}p.isMDXComponent=!0},91658:(e,t,a)=>{a.d(t,{Z:()=>n});const n=a.p+"assets/files/Example_Graph-8a7adf8435a49057690df4a880fa9deb.jpg"},51717:(e,t,a)=>{a.d(t,{Z:()=>n});const n=a.p+"assets/files/Runtime_View3-740cddfe0eef94cd41de5f53d6f8c973.png"},7802:(e,t,a)=>{a.d(t,{Z:()=>n});const n=a.p+"assets/files/knowledge_agent_architecture-15fd310f1a667afd2468806a1803c95b.png"},41833:(e,t,a)=>{a.d(t,{Z:()=>n});const n=a.p+"assets/images/Example_Graph-8a7adf8435a49057690df4a880fa9deb.jpg"},51106:(e,t,a)=>{a.d(t,{Z:()=>n});const n=a.p+"assets/images/Runtime_View3-740cddfe0eef94cd41de5f53d6f8c973.png"},36218:(e,t,a)=>{a.d(t,{Z:()=>n});const n=a.p+"assets/images/knowledge_agent_architecture_small-9cc3ea62face191965d2cc95057c3f5b.png"}}]);