type JSONValue = string | number | boolean | JSONObject | JSONArray;
type JSONArray = Array<JSONValue>;
interface JSONObject {
  [x: string]: JSONValue;
}
export const Layouts: Record<string, JSONObject> = {
  random: {
    name: 'random',
    animate: true,
    label: 'Random',
  },
  grid: {
    name: 'grid',
    animate: true,
    nodeDimensionsIncludeLabels: true,
    label: 'Grid',
  },
  circle: {
    name: 'circle',
    animate: true,
    label: 'Circle',
  },
  concentric: {
    name: 'concentric',
    animate: true,
    nodeDimensionsIncludeLabels: true,
    label: 'Concentric',
  },
  dagre: {
    name: 'dagre',
    animate: true,
    label: 'Hierarchy (Dagre)',
  },
  breadthfirst: {
    name: 'breadthfirst',
    animate: true,
    grid: true,
    label: 'efficient Hierarchy',
    padding: 50,
  },
};
