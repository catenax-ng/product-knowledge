import { use as cytoscapeUse } from "cytoscape";
// @ts-ignore
import dagre from "cytoscape-dagre";

export default function () {
  cytoscapeUse(dagre);
}