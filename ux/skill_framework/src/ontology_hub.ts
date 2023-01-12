//
// Ontology-specific logic of the skill framework
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//

import fetch from 'node-fetch';
import createHttpsProxyAgent from 'https-proxy-agent';
import { HttpsProxyAgent } from 'https-proxy-agent';

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
            if (item.length < 3) return item.toUpperCase();
            else return item.charAt(0).toUpperCase() + item.slice(1);
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
            version: '0.7.2',
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
    return Promise.resolve([
      {
        name: 'Address Ontology',
        download_url:
          'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/address_ontology.ttl',
        vowl: 'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/vowl/address_ontology.json',
        type: 'OWL',
        status: 'DRAFT',
        version: '0.7.2',
      },
      {
        name: 'Common Ontology',
        download_url:
          'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/common_ontology.ttl',
        vowl: 'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/vowl/common_ontology.json',
        type: 'OWL',
        status: 'DRAFT',
        version: '0.7.2',
      },
      {
        name: 'Contact Ontology',
        download_url:
          'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/contact_ontology.ttl',
        vowl: 'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/vowl/contact_ontology.json',
        type: 'OWL',
        status: 'DRAFT',
        version: '0.7.2',
      },
      {
        name: 'CX Ontology',
        download_url:
          'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/cx_ontology.ttl',
        vowl: 'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/vowl/cx_ontology.json',
        type: 'OWL',
        status: 'DRAFT',
        version: '0.7.2',
      },
      {
        name: 'Diagnosis Ontology',
        download_url:
          'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/diagnosis_ontology.ttl',
        vowl: 'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/vowl/diagnosis_ontology.json',
        type: 'OWL',
        status: 'DRAFT',
        version: '0.7.2',
      },
      {
        name: 'Encoding Ontology',
        download_url:
          'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/encoding_ontology.ttl',
        vowl: 'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/vowl/encoding_ontology.json',
        type: 'OWL',
        status: 'DRAFT',
        version: '0.7.2',
      },
      {
        name: 'Error Ontology',
        download_url:
          'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/error_ontology.ttl',
        vowl: 'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/vowl/error_ontology.json',
        type: 'OWL',
        status: 'DRAFT',
        version: '0.7.2',
      },
      {
        name: 'Load Spectrum Ontology',
        download_url:
          'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/load_spectrum_ontology.ttl',
        vowl: 'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/vowl/load_spectrum_ontology.json',
        type: 'OWL',
        status: 'DRAFT',
        version: '0.7.2',
      },
      {
        name: 'Material Ontology',
        download_url:
          'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/material_ontology.ttl',
        vowl: 'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/vowl/material_ontology.json',
        type: 'OWL',
        status: 'DRAFT',
        version: '0.7.2',
      },
      {
        name: 'Part Ontology',
        download_url:
          'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/part_ontology.ttl',
        vowl: 'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/vowl/part_ontology.json',
        type: 'OWL',
        status: 'DRAFT',
        version: '0.7.2',
      },
      {
        name: 'Person Ontology',
        download_url:
          'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/person_ontology.ttl',
        vowl: 'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/vowl/person_ontology.json',
        type: 'OWL',
        status: 'DRAFT',
        version: '0.7.2',
      },
      {
        name: 'Prognosis Ontology',
        download_url:
          'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/prognosis_ontology.ttl',
        vowl: 'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/vowl/prognosis_ontology.json',
        type: 'OWL',
        status: 'DRAFT',
        version: '0.7.2',
      },
      {
        name: 'Vehicle Component Ontology',
        download_url:
          'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/vehicle_component_ontology.ttl',
        vowl: 'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/vowl/vehicle_component_ontology.json',
        type: 'OWL',
        status: 'DRAFT',
        version: '0.7.2',
      },
      {
        name: 'Vehicle Information Ontology',
        download_url:
          'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/vehicle_information_ontology.ttl',
        vowl: 'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/vowl/vehicle_information_ontology.json',
        type: 'OWL',
        status: 'DRAFT',
        version: '0.7.2',
      },
      {
        name: 'Vehicle Lifecycle Ontology',
        download_url:
          'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/vehicle_lifecycle_ontology.ttl',
        vowl: 'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/vowl/vehicle_lifecycle_ontology.json',
        type: 'OWL',
        status: 'DRAFT',
        version: '0.7.2',
      },
      {
        name: 'Vehicle Ontology',
        download_url:
          'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/vehicle_ontology.ttl',
        vowl: 'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/vowl/vehicle_ontology.json',
        type: 'OWL',
        status: 'DRAFT',
        version: '0.7.2',
      },
      {
        name: 'Vehicle Safety Ontology',
        download_url:
          'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/vehicle_safety_ontology.ttl',
        vowl: 'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/vowl/vehicle_safety_ontology.json',
        type: 'OWL',
        status: 'DRAFT',
        version: '0.7.2',
      },
      {
        name: 'Vehicle Usage Ontology',
        download_url:
          'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/vehicle_usage_ontology.ttl',
        vowl: 'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/vowl/vehicle_usage_ontology.json',
        type: 'OWL',
        status: 'DRAFT',
        version: '0.7.2',
      },
    ]);
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
