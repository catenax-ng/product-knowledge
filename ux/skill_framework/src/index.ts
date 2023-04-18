//
// Main logic of the skill framework
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//

import { HeaderRecord } from './data';
import {
  IConnector,
  IConnectorFactory,
  IRealmMapping,
  IRealmMappingFactory,
} from './connector';
import { MockConnector } from './mock_connector';
import { RemoteConnector } from './remote_connector';

export { getOntologyHubFactory, OntologyResult } from './ontology_hub';
export {
  IConnector,
  IConnectorFactory,
  IRealmMapping,
  IRealmMappingFactory,
} from './connector';
export { JSONElement, BindingSet, Warning, HeaderRecord, Entry } from './data';

/**
 * default connector factory taking its information from environment
 */
class EnvironmentConnectorFactory implements IConnectorFactory {
  private environmentConnector: IConnector;

  constructor() {
    if (
      process.env.REACT_APP_SKILL_CONNECTOR_CONTROL != undefined &&
      process.env.REACT_APP_SKILL_CONNECTOR_DATA != undefined &&
      process.env.REACT_APP_SKILL_CONNECTOR_CONTROL != '' &&
      process.env.REACT_APP_SKILL_CONNECTOR_DATA != ''
    ) {
      this.environmentConnector = new RemoteConnector(
        process.env.REACT_APP_SKILL_CONNECTOR_CONTROL,
        process.env.REACT_APP_SKILL_CONNECTOR_DATA,
        undefined,
        process.env.REACT_APP_SKILL_PROXY
      );
    } else {
      this.environmentConnector = new MockConnector();
    }
  }

  public create() {
    return this.environmentConnector;
  }
}

/**
 * default realm mapping taking its information from environment
 */
class EnvironmentRealmMapping implements IRealmMapping {
  public getHeaderAnnotation() {
    const headers: HeaderRecord = {};
    if (
      process.env.REACT_APP_SKILL_CONNECTOR_AUTH_HEADER_KEY != undefined &&
      process.env.REACT_APP_SKILL_CONNECTOR_AUTH_HEADER_KEY !=
        'REACT_APP_SKILL_CONNECTOR_AUTH_HEADER_KEY'
    ) {
      headers[process.env.REACT_APP_SKILL_CONNECTOR_AUTH_HEADER_KEY] =
        process.env.REACT_APP_SKILL_CONNECTOR_AUTH_HEADER_VALUE ?? '';
    }
    return headers;
  }
}

/**
 * default realm factory
 */
class EnvironmentRealmMappingFactory implements IRealmMappingFactory {
  private environmentRealmMapping: IRealmMapping;

  constructor() {
    this.environmentRealmMapping = new EnvironmentRealmMapping();
  }

  public create() {
    return this.environmentRealmMapping;
  }
}

/**
 * global factory variable
 */
let realmMappingFactory: IRealmMappingFactory =
  new EnvironmentRealmMappingFactory();

/**
 * @returns the global connector factory
 */
export const getRealmMappingFactory = function () {
  return realmMappingFactory;
};

/**
 * sets
 * @param factory the new global factory
 */

export const setRealmMappingFactory = function (factory: IRealmMappingFactory) {
  realmMappingFactory = factory;
};

/**
 * global factory variable
 */
let connectorFactory: IConnectorFactory = new EnvironmentConnectorFactory();

/**
 * @returns the global connector factory
 */
export const getConnectorFactory = function () {
  return connectorFactory;
};

/**
 * sets
 * @param factory the new global factory
 */

export const setConnectorFactory = function (factory: IConnectorFactory) {
  connectorFactory = factory;
};

/**
 * @returns url of the skill backend
 */
export const getSkillBackend = function () {
  return (
    process.env.REACT_APP_SKILL_BACKEND ?? 'https://service.tib.eu/webvowl/'
  );
};
