//
// Ontology-specific logic of the skill framework
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//

import fetch from 'node-fetch';
import createHttpsProxyAgent from 'https-proxy-agent';
import { HttpsProxyAgent } from 'https-proxy-agent';
import { ONTOLOGIES } from './mock_data';

// a ontology hub factory
export interface IOntologyHubFactory {
  create: () => IOntologyHub;
}

//OntologyHub Interface
export interface IOntologyHub {
  getOntologies: () => Promise<OntologyResult[]>;
}

interface Ontology {
  name: string;
  download_url: string;
}

type OntologyContainer = Array<Ontology>;

export interface OntologyResult {
  name: string;
  download_url: string;
  vowl: string;
  type: string;
  version: string;
  status: string;
}

class OntologyHub implements IOntologyHub {
  private url: string;
  private proxy?: HttpsProxyAgent;

  constructor(url: string, proxy?: string) {
    this.url = url;
    if (proxy) {
      const url = new URL(proxy);
      this.proxy = createHttpsProxyAgent({
        host: url.hostname,
        port: url.port,
      });
    }
  }
  public async getOntologies(): Promise<OntologyResult[]> {
    const response = await fetch(this.url, { agent: this.proxy });

    if (!response.ok) {
      throw new Error(`Error! status: ${response.status}`);
    } else {
      const body = (await response.json()) as OntologyContainer;
      const result: OntologyResult[] = [];
      body.forEach((ontology) => {
        if (ontology.name.endsWith('_ontology.ttl')) {
          const ontolgyName = ontology.name.replace('.ttl', '');
          let items: string[] = ontolgyName.split('_');
          items = items.map((item) => {
            return item.charAt(0).toUpperCase() + item.slice(1);
          });
          const ontolgyTitle = items.join(' ');
          const entry: OntologyResult = {
            name: ontolgyTitle,
            download_url: ontology.download_url,
            vowl: ontology.download_url
              .replace('/ontology/', '/ontology/vowl/')
              .replace('.ttl', '.json'),
            type: 'OWL',
            status: 'DRAFT',
            version: '0.7.4',
          };
          result.push(entry);
        }
      });

      return result;
    }
  }
}

class MockOntologyHub implements IOntologyHub {
  public getOntologies(): Promise<OntologyResult[]> {
    return Promise.resolve(ONTOLOGIES);
  }
}

// class of IOntologyHubFactory
// creates MockOntologyHub or OntologyHub
export class EnvironmentOntologyHubFactory implements IOntologyHubFactory {
  private environmentOntologyHub: IOntologyHub;

  constructor() {
    if (process.env.REACT_APP_SKILL_GITHUB_ONTOLOGYHUB != undefined) {
      this.environmentOntologyHub = new OntologyHub(
        process.env.REACT_APP_SKILL_GITHUB_ONTOLOGYHUB,
        process.env.REACT_APP_SKILL_PROXY
      );
    } else {
      this.environmentOntologyHub = new MockOntologyHub();
    }
  }

  public create() {
    return this.environmentOntologyHub;
  }
}

//global factory variable
const ontologHubFactory: IOntologyHubFactory =
  new EnvironmentOntologyHubFactory();

/**
 * @returns the global connector factory
 */
export const getOntologyHubFactory = function () {
  return ontologHubFactory;
};
