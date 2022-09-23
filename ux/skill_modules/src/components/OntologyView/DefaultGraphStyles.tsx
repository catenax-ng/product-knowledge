import { Stylesheet } from "cytoscape";

const primary = '#ffa600';
const secondary = '#b3cb2d';
const cxCategory = '#D91E18';

export const DefaultStyleSheet: Stylesheet[] = [
  {
    selector: "node",
    style: {
      backgroundColor: primary,
      width: 30,
      height: 30,
      label: "data(label)",
      'text-valign': "bottom",
      'overlay-padding': "6px",
      'z-index': 10,
      //text props
      color: primary,
      'font-size': 20,
    }
  },
  {
    selector: "node:selected",
    style: {
      'border-width': '2px',
      'border-color': primary,
      backgroundColor: secondary,
      width: 40,
      height: 40,
      //text props
      color: secondary
    }
  },
  {
    selector: "node[category='https://github.com/catenax-ng/product-knowledge/ontology/cx.ttl']",
    style: {
      backgroundColor: cxCategory,
      color: cxCategory,
      shape: "rectangle"
    }
  },
  {
    selector: "edge",
    style: {
      width: 1,
      label: "data(type)",
      'text-valign': "top",
      'line-color': '#eee',
      'target-arrow-color': '#ddd',
      'target-arrow-shape': "triangle",
      'curve-style': "bezier"
    }
  },
  {
    selector: "edge[type='subclass']",
    style: {
      'line-color': 'red',
      'target-arrow-color': 'red',
    }
  },
  {
    selector: "edge[type='relation']",
    style: {
      'line-color': 'blue',
      'target-arrow-color': 'blue',
    }
  }
];