import { use as cytoscapeUse } from 'cytoscape';
import dagre from 'cytoscape-dagre';

export default function () {
  cytoscapeUse(dagre);
}
