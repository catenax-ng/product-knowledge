export class Node {
  title: string;
  value: string;
  parent: Node | null = null;
  children?: Node[] | null;

  constructor(
    title: string,
    value: string | null = null,
    children: Node[] | null = null
  ) {
    this.title = title;
    this.value = value == null ? title : value;
    this.children = children;
    if (children != null) {
      children.forEach((child) => (child.parent = this));
    }
  }

  toString() {
    return this.title;
  }
}

export const getParent = (node: Node) => node.parent;
