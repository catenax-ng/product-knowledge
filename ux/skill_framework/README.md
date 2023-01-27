# Catena-X Knowledge Agents (Hey Catena!) Skill Framework

The Skill Framework is a library to build Apps that interact with Hey Catena! and keep conversational state.

## How to use it

In order to use the Knowledge Agents Skill Framework, you should first add it to your dependencies

```console
npm install @catenax-ng/skill_framework

```

## General Interaction

Since the skill framework should be extensible, we work with mutable factories. That means that for any
function/service of the skill framework, there will be a getter (and a setter) to access the current or exchange the current
factories.

For example, to access or exchange the realm mapping factory, you would

```typescript
import {getRealmMappingFactory, setRealmMappingFactory, IRealmMappingFactory} from '@catenax-ng/skill_framework';


class MyRealmMappingFactory implements IRealmMappingFactory {
  ...
};

var currentFactory=getRealmMappingFactory();
setRealmMappingFactory(new MyRealmMappingFactory());
```

For example, to access or exchange the connector factory, you would

```typescript
import {getConnectorFactory, setConnectorFactory, IConnectorFactory} from '@catenax-ng/skill_framework';


class MyConnectorFactory implements IConnectorFactory {
  ...
};

var currentFactory=getConnectorFactory();
setConnectorFactory(new MyConnectorFactory());
```

## Realm Mapping

The skill framework has the ability to perform a realm mapping of the actually executing user of the skill framework
to a target domain. By calling the `getHeaderAnnotation` method, you would be returned with a header object that
should be joined/extended in order to attach to any outgoing request to that domain.

```typescript
import { getRealmMappingFactory } from '@catenax-ng/skill_framework';

var additionalHeaders = getRealmMappingFactory()
  .create()
  .getHeaderAnnotation('http://www.example.com');
```

The default realm mapping factory will use a realm mapping implementation which takes a header key from the `REACT_APP_SKILL_CONNECTOR_AUTH_HEADER_KEY` environment variable and the header value from the `REACT_APP_SKILL_CONNECTOR_AUTH_HEADER_VALUE` variable. If the environment variables are unset, the header object will be empty.

## Interacting with the Dataspace Connector

The skill framework has the ability to interact with the tenant's dataspace connector. In general these interactions are asynchronous, such as the ability
to list the assets of the connector itself or some remote connector by the 'execute' method.


```typescript
import {getConnectorFactory, Catalogue} from '@catenax-ng/skill_framework';


# we must await for the asynchronous result
var catalogue:BindingSet= await getConnectorFactory().create().execute('Dataspace', {});

```

The default connector factory will inspect the `REACT_APP_SKILL_CONNECTOR_CONTROL`,`REACT_APP_SKILL_CONNECTOR_DATA`,`REACT_APP_SKILL_CONNECTOR_AUTH_HEADER_KEY`, `REACT_APP_SKILL_CONNECTOR_AUTH_HEADER_VALUE` and `REACT_APP_SKILL_PROXY` environment variables.
If they are unset or empty, it will use a mock connector implementation.

Otherwise, it will use a connector implementation that uses the given string as the connector URL.

```console
export REACT_APP_SKILL_CONNECTOR_CONTROL=https://knowledge.int.demo.catena-x.net/oem-edc-control/BPNL00000003COJN
export REACT_APP_SKILL_CONNECTOR_DATA=https://knowledge.int.demo.catena-x.net/oem-edc-data/BPNL00000003COJN
export REACT_APP_SKILL_CONNECTOR_AUTH_HEADER_KEY=X-Api-Key
export REACT_APP_SKILL_CONNECTOR_AUTH_HEADER_VALUE=YOURAPIKEY
export REACT_APP_SKILL_PROXY=YOURPROXY
export REACT_APP_SKILL_GITHUB_ONTOLOGYHUB=https://api.github.com/repos/catenax-ng/product-knowledge/contents/ontology

## Notice

* see copyright notice in the top folder
* see license file in the top folder
* see authors file in the top folder





```
