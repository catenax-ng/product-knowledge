import {
  AssetProperties,
  BindingSet,
  Catalogue,
  Entry,
  getConnectorFactory,
  getOntologyHubFactory,
  OntologyResult,
} from '@catenax-ng/skill-framework/dist/src';

// TYPES
export type AssetPropertiesType = AssetProperties;
export type BindingSetType = BindingSet;
export type EntryType = Entry;

// SERVICES
export function OntologyHubService(): Promise<OntologyResult[]> {
  const ontologyHub = getOntologyHubFactory().create();
  return ontologyHub.getOntologies();
}

export function AssetListService(): Promise<Catalogue> {
  const connector = getConnectorFactory().create();
  return connector.listAssets();
}

export function CustomSearchService(
  selectedSkill: string,
  queryVars: any
): Promise<BindingSet> {
  const connector = getConnectorFactory().create();
  return connector.execute(selectedSkill, queryVars);
}
