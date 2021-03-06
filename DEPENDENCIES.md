# Dependencies of Catena-X Knowledge Agents

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
|--- | --- | --- | --- | --- | --- | ---| 
| Dataspace | * | [Java Runtime Environment (JRE)](https://de.wikipedia.org/wiki/Java-Laufzeitumgebung) | >=11 | Test + Provided | * | License (GPL, BCL, ...) depends on choosen runtime. 
| Dataspace | * | [Java Development Kit (JDK)](https://de.wikipedia.org/wiki/Java_Development_Kit) | >=11 | Compile + Packaging | * | License (GPL, BCL, ...) depends on choosen kit. 
| Dataspace | Provisioning Agent | [Ontop VKP](https://ontop-vkg.org/) | >=3.0 | Packaging + Runtime | Apache License 2.0 | 
| Dataspace | Provisioning Agent | [H2 Database](http://h2database.com/) | >=2.1 | Runtime | Mozilla Public License (2.0) and Eclipse Public License (1.0) | 
| Ontology | Tools | [OWLApi](https://github.com/owlcs/owlapi) | >=5.1 | Compile + Test + Packaging | LGPL and Apache License | 
| UX | * | [NodeJS](https://nodejs.org/en/) | >=14 | All | MIT (Main) + Various Extensions |
| UX | * | [Typescript](https://www.typescriptlang.org/) | >=4.7 | Compile + Runtime | Apache License 2.0 |
| UX | * | [JEST](https://jestjs.io/) | >=28.1 | Test | MIT |
| UX | Skill Framework | [node-fetch](https://github.com/node-fetch/node-fetch) | >=2.6 | All | MIT |
| * | * | Docker Engine | >=20.10.17 | Packaging + Provided | Apache License 2.0 |
| * | * | [kubernetes](https://kubernetes.io/de/)/[helm](https://helm.sh/) | >=1.20/3.9 | Provided | Apache License 2.0 |