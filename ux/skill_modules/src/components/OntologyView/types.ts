export interface Nodes {
  data: NodeData
}

export interface Edges {
  data: EdgeData
}

export interface EdgeData {
  source: string,
  target: string,
  type: string
}

export interface NodeData {
  id: string,
  category: string,
  label?: string,
  type?: string
}

export interface GraphObject {
  nodes: Nodes[],
  edges: Edges[]
}