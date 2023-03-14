namespace JSX {
  interface IntrinsicElements {
    'spar-natural': SparnaturalAttributes;
  }

  interface SparnaturalAttributes {
    ref: React.RefObject<HTMLElement>;
    src: string;
    lang: string;
    endpoint: string;
    distinct: string;
    limit: string;
    prefix: string;
    debug: string;
  }
}
