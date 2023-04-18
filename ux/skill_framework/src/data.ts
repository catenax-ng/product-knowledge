//
// Data structures of the skill framework
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//

/**
 * some typescript pseudo-bindings
 * for generic JSON objects
 */
export type JSONElement = JSONObject | JSONArray;
export type JSONArray = Array<JSONValue>;
export type JSONValue = string | number | boolean | JSONElement;

export interface JSONObject {
  [x: string]: JSONValue;
}

/**
 * Headers are string-based dictionaries
 */
export interface HeaderRecord {
  [key: string]: string;
}

/**
 * Main data/tuple set as defined by the SPARQL standard
 */
export interface BindingSet {
  head: Head;
  results: Binding;
  warnings?: Warning[];
}

export interface Head {
  vars: string[];
}

export interface Binding {
  bindings: Entry[];
}

export interface Entry {
  [key: string]: Value | undefined;
}

export interface Value {
  value: string;
  type: string;
}

/**
 * Catena-X Log Structure
 */
export interface Warning {
  'source-tenant'?: string;
  'source-asset'?: string;
  'target-tenant'?: string;
  'target-asset'?: string;
  context?: string;
  problem?: string;
}
