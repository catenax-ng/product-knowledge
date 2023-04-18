//
// Connector interface of the skill framework
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//

import { JSONElement, BindingSet, HeaderRecord } from './data';

/**
 * the connector interface
 */
export interface IConnector {
  currentConnector: () => string;

  /**
   * Executes a given skill
   */
  execute: (
    skill: string,
    queryVariables: JSONElement,
    data_url?: string
  ) => Promise<BindingSet>;

  /**
   * Executes a given query
   */
  executeQuery: (
    query: string,
    queryVariables: JSONElement,
    data_url?: string
  ) => Promise<BindingSet>;
}

/*
 * a connector factory
 */
export interface IConnectorFactory {
  create: () => IConnector;
}

/**
 * a realm mapping maps the current user
 * to a target domain (url) by filling out
 * any needed header information
 */
export interface IRealmMapping {
  getHeaderAnnotation: (targetDomain: string) => HeaderRecord;
}

/**
 * a factory for realm mappings
 */
export interface IRealmMappingFactory {
  create: () => IRealmMapping;
}
