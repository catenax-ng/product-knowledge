# Dependencies of Catena-X Knowledge Agents Kit

The following is a simple type of single-level Software-BOM for all official open source products of Catena-X Knowledge Agents. 

* Product - The name of the Epic/Product (* for all)
* Component - The specific sub-component of the Epic/Product (* for all)
* Library/Module - The library or module that the Product/Component is depending on
* Stage - The kind of dependency 
  * Compile - The library is needed to compile the source code of the component into the target artifact (runtime)
  * Test - The library is needed to test the target artifact
  * Packaging - The library is needed to test the target artifact before, while and/or after packaging it
  * Runtime - The library is shipped as a part of the target artifact (runtime)
  * Provided - The library is not shipped as a part of the target artifact, but needed in it runtime
  * All - The library is needed at all Stages
* Version - the version of the library that the component is dependant upon
* License - the license identifier
* Comment - any further remarks on the kind of dependency

| Product | Component | Library/Module  | Version | Stage | License | Comment |
|--- | -- | --- | --- | --- | --- | ---| 
| * | * | [Apache Maven](https://maven.apache.org) | >=3.8 | Compile + Test + Packaging | Apache License 2.0 |     |
| * | * | Docker Engine | >=20.10.17 | Packaging + Provided | Apache License 2.0 |     |
| * | * | [kubernetes](https://kubernetes.io/de/)/[helm](https://helm.sh/) | >=1.20/3.9 | Provided | Apache License 2.0 |     |
| * | * | [Python](https://www.python.org/) | >=3.9 | Test + Packaging + Provided | Zero Clause BSD |     |
| Ontology | Tools | [OWLApi](https://github.com/owlcs/owlapi) | >=5.1 | Compile + Test + Packaging | LGPL and Apache License |     |
| Ontology | Tools | [OWL2VOWL](https://github.com/VisualDataWeb/OWL2VOWL) | >=0.3.7 | Compile + Test + Packaging | MIT License |     |
| Ontology | Tools | [SLF4J](https://www.slf4j.org) | >=2.0.0 | Compile + Test + Packaging | MIT |     |
| Ontology | Tools | [Junit Jupiter](https://junit.org) | >=5 | Test | MIT |     |
| Ontology | Tools | [NodeJS](https://nodejs.org/en/) | >=14 | Compile + Packaging | MIT (Main) + Various Extensions | Only for Json2Sql|
| Ontology | Tools | [Jackson](https://github.com/FasterXML/jackson) | >=2.12.6 | Compile + Test + Packaging | Apache License 2.0 |     |
| Ontology | Tools | [RDFlib](https://rdflib.readthedocs.io/en/stable/) | >=6.2 | Compile + Test + Packaging | BSD-3 |     |
| UX | * | [NodeJS](https://nodejs.org/en/) | >=14 | All | MIT (Main) + Various Extensions |     |
| UX | * | [Typescript](https://www.typescriptlang.org/) | >=4.7 | Compile + Runtime | Apache License 2.0 |     |
| UX | * | [JEST](https://jestjs.io/) | >=28.1 | Test | MIT |     |
| UX | * | [ESLINT](https://eslint.org/) | >=8.35 | Compile + Test + Packaging | MIT |     |
| UX | * | [Prettier](https://github.com/prettier/prettier) | >=2.7.1 | Compile | MIT |     |
| UX | * | [Buffer](https://github.com/feross/buffer) | >=6.0.3 | Test | MIT |     |
| UX | Skill Framework (+ Modules + Gym) | [node-fetch](https://github.com/node-fetch/node-fetch) | >=2.6 | All | MIT |     |
| UX | Skill Framework (+ Modules + Gym) | [https-proxy-agent](https://github.com/TooTallNate/node-https-proxy-agent) | >=5.0.0 | All | MIT |     |
| UX | Skill Modules (+ Gym) | [React](https://reactjs.org/) | >=17.0.2 | Compile + Runtime | MIT licence |     |
| UX | Skill Modules (+ Gym) | [React CytoscapeJS](https://github.com/plotly/react-cytoscapejs) | >=1.2.1 | Compile + Runtime | BSD-2 |     |
| UX | Skill Modules (+ Gym) | [Cytoscape](https://github.com/cytoscape/cytoscape.js) | >=3.22.1 | Compile + Runtime | MIT licence |     |
| UX | Skill Modules (+ Gym) | [Cytoscape Dagre](https://github.com/cytoscape/cytoscape.js-dagre) | >=2.4.0 | Compile + Runtime | MIT licence |     |
| UX | Skill Modules (+ Gym) | [Material UI](https://mui.com/) | >=5.4.4 | All | MIT licence |     |
| UX | Skill Modules (+ Gym) | [React-Leaflet](https://github.com/PaulLeCam/react-leaflet) | >=3.2.0 | All | Hippocratic License |     |
| UX | Skill Modules (+ Gym) | [Leaflet](https://github.com/Leaflet/Leaflet) | >=1.9.3 | All | MIT |     |
| UX | Skill Modules (+ Gym) | [Rollup.js](https://rollupjs.org/) | >=2.77.2 | Compile | MIT licence |     |
| UX | Skill Modules (+ Gym) | [Catena-X Portal Components](https://github.com/catenax-ng/product-portal-frontend) | >=0.6.1 | All | Apache License 2.0 |     |
| UX | Skill Gym | [Web-Vitals](https://github.com/GoogleChrome/web-vitals) | >=2.1.4 | Compile + Runtime | Apache License 2.0 |     |
| Dataspace | * | [Java Runtime Environment (JRE)](https://de.wikipedia.org/wiki/Java-Laufzeitumgebung) | >=11 | Test + Provided | * | License (GPL, BCL, ...) depends on choosen runtime. |
| Dataspace | * | [Java Development Kit (JDK)](https://de.wikipedia.org/wiki/Java_Development_Kit) | >=11 | Compile + Packaging | * | License (GPL, BCL, ...) depends on choosen kit. |
| Dataspace | * | [Junit Jupiter](https://junit.org) | >=5 | Test | MIT |     |
| Dataspace | AAS Bridge | [FAAST Service](https://github.com/FraunhoferIOSB/FAAAST-Service) | >=0.4.0 | All | Apache License 2.0 |
| Dataspace | AAS Bridge | [Eclipse Semantic Modeling Framework](https://github.com/eclipse-esmf/esmf-sdk) | >=1.1.0-M5 | Compile | MPL 2.0 |
| Dataspace | AAS Bridge | [AAS4J](https://github.com/eclipse-aas4j/aas4j) | >=1.2.0 | All | Apache License 2.0 |
| Dataspace | AAS Bridge | [OkHttp3 MockServer](https://github.com/square/okhttp) | 4.9.0 | Test | Apache License 2.0 |
| Dataspace | Mock>Prognosis | [Fastapi](https://fastapi.tiangolo.com/) | >=0.70.0 | All | MIT |     |
| Dataspace | Mock>Prognosis | [Gunicorn](https://gunicorn.org/) | >=20.1.0 | All | MIT |     |
| Dataspace | Mock>Prognosis | [Python Dateutil](https://github.com/dateutil/dateutil) | >=2.8.1 | All | Apache License 2.0 and BSD-3 |     |
| Dataspace | Mock>Prognosis | [Python Multipart](https://github.com/andrew-d/python-multipart) | >=0.0.5 | All | Apache License 2.0 |     |
| Dataspace | Mock>Prognosis | [Uvicorn](https://github.com/encode/uvicorn) | >=0.15.0 | All | BSD-3 |     |
| Dataspace | Mock>Prognosis | [ISort](https://github.com/pycqa/isort) | >=5.10.1 | All | MIT |     |
| Dataspace | Mock>Prognosis | [Pylint](https://github.com/PyCQA/pylint) | >=2.14.3 | Compile | GPL-2 |     |
| Dataspace | Mock>Prognosis | [Pytest](https://github.com/pytest-dev/pytest) | >=6.2.5 | Test | MIT |     |
| Dataspace | Mock>Prognosis | [Pytest-Cov](https://github.com/pytest-dev/pytest-cov) | >=3.0.0 | Test | MIT |     |
| Dataspace | Mock>Prognosis | [Requests](https://github.com/psf/requests) | >=2.28.1 | All | Apache License 2.0 |     |
| Dataspace | Virtualize>Dremio | [Dremio OSS](https://github.com/dremio/dremio-oss) | >=22.1.1 | Runtime | Apache License 2.0 |     |
| Dataspace | Virtualize>Druid | [Apache Druid](https://druid.apache.org/) | >=24 | Runtime | Apache License 2.0 |     |
| Dataspace | Agents>Provisioning | [Ontop VKP](https://ontop-vkg.org/) | >=4.2.1 | All | Apache License 2.0 |     |
| Dataspace | Agents>Provisioning | [Apache Calcite/Avatica](https://calcite.apache.org/avatica/) | >=1.22 | All | Apache License 2.0 |     |
| Dataspace | Agents>Provisioning | [H2 Database](http://h2database.com/) | >=2.1 | Runtime | Mozilla Public License (2.0) and Eclipse Public License (1.0) |     |
| Dataspace | Agents>Provisioning | [Dremio JDBC](https://docs.dremio.com/software/drivers/jdbc/) | >=22.1.1 | All | Proprietary |     |
| Dataspace | Agents>Remoting | [Eclipse RDF4J](https://rdf4j.org/) | >=3.7 | All | Eclipse Public License (1.0) |     |
| Dataspace | Agents>Remoting | [SLF4J](https://www.slf4j.org) | >=2.0.0 | All | MIT |     |
| Dataspace | Agents>Remoting | [Jackson](https://github.com/FasterXML/jackson) | >=2.13.4 | All | Apache License 2.0 |     |
| Dataspace | Agents>Remoting | [Apache HttpComponents](https://hc.apache.org/) | >=4.5.13 | All | Apache License 2.0 |     |
| Dataspace | EDC Extensions | [Tractus-X Knowledge Agents EDC Extensions](https://github.com/catenax-ng/product-agents-edc/blob/main/Dependencies.md) | >=1.9.1 | All | Apache License 2.0 |     |
