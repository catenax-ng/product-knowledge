import { Stylesheet } from 'cytoscape';

const primary = '#ffa600';

export const DefaultStyleSheet: Stylesheet[] = [
  {
    selector: 'node',
    style: {
      backgroundColor: primary,
      width: 30,
      height: 30,
      label: 'data(label)',
      'overlay-padding': '6px',
      'z-index': 10,
      //text props
      color: primary,
      'font-size': 20,
      'font-weight': 600,
      'text-halign': 'center',
      'text-valign': 'top',
      'text-margin-y': -7,
    },
  },
  {
    selector: 'node:selected',
    style: {
      'border-width': '2px',
      width: 40,
      height: 40,
      shape: 'star',
      'z-index': 11,
    },
  },
  {
    selector: "node[type='class']",
    style: {
      shape: 'diamond',
    },
  },
  {
    selector: 'edge',
    style: {
      width: 1,
      'line-color': '#ccc',
      'target-arrow-color': '#bbb',
      'target-arrow-shape': 'triangle',
      'curve-style': 'bezier',
    },
  },
  {
    selector: 'edge:selected',
    style: {
      width: 2,
      label: 'data(type)',
      'text-valign': 'top',
      'line-color': '#aaa',
      'target-arrow-color': primary,
    },
  },
  {
    selector: "edge[type='subclass']",
    style: {
      'line-color': 'red',
      'target-arrow-color': 'red',
    },
  },
  {
    selector: "edge[type='relation']",
    style: {
      'line-color': 'blue',
      'target-arrow-color': 'blue',
    },
  },
];
