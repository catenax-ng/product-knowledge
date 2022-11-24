//
// Test logic for the skill framework
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//

import { getConnectorFactory } from '../src/index';
import { getOntologyHubFactory } from '../src/ontology_hub';
import { jest } from '@jest/globals';

/**
 * test:get assets
 */
describe('testing skill framework', () => {
  jest.setTimeout(15000);
  test('assets should be returned', async () => {
    const connector = getConnectorFactory().create();
    console.log(`Got connector ${connector}.`);
    const catalogue = await connector.listAssets();
    expect(catalogue.id).toBeDefined();
    console.log(`Found catalog ${catalogue.id}.`);
    expect(catalogue.contractOffers).toBeDefined();
    expect(catalogue.contractOffers.length).toBeGreaterThan(0);
    console.log(`Found ${catalogue.contractOffers.length} offers.`);
    catalogue.contractOffers.map(function (contractOffer) {
      expect(contractOffer).toHaveProperty('id');
      console.log(`Found offer ${contractOffer.id}.`);
      expect(contractOffer).toHaveProperty('policy');
      expect(contractOffer).toHaveProperty('asset');
      expect(contractOffer.asset).toHaveProperty('properties');
      expect(contractOffer.asset.properties).toHaveProperty('asset:prop:id');
      expect(contractOffer.asset.properties).toHaveProperty('asset:prop:name');
      console.log(
        `Found asset ${contractOffer.asset.properties['asset:prop:name']} in offer ${contractOffer.id}.`
      );
      expect(contractOffer.asset.properties).toHaveProperty(
        'asset:prop:contenttype'
      );
    });
  });
});

/**
 * test: get lifetime
 */
describe('testing skill framework', () => {
  jest.setTimeout(60000);
  test('lifetime should be returned ', async () => {
    const connector = getConnectorFactory().create();

    console.log(`Got connector ${connector}.`);

    const queryVariables = { vin: 'WVA8984323420333', troubleCode: 'P0745' };

    const result = await connector.execute('Lifetime', queryVariables);

    result.results.bindings.map(function (entry) {
      console.log(
        'Result as parsed JSON \n' +
          '  vin:  ' +
          entry.vin.value +
          '\n' +
          '  troubleCode:  ' +
          entry.troubleCode.value +
          '\n' +
          '  partProg: ' +
          entry.partProg.value +
          '\n' +
          '  distance: ' +
          entry.distance.value +
          '\n' +
          '  time: ' +
          entry.time.value
      );
    });
  });
});

/**
 * test: Search
 */
describe('testing skill framework', () => {
  jest.setTimeout(60000);
  test('Troublecode search results should be returned', async () => {
    const connector = getConnectorFactory().create();

    console.log(`Got connector ${connector}.`);

    const queryVariables = {
      vin: 'WBAAL31029PZ00001',
      problemArea: 'Getriebe',
      minVersion: 1,
    };

    const result = await connector.execute('TroubleCodeSearch', queryVariables);

    console.log('Query results');
    result.results.bindings.map(function (entry) {
      result.head.vars.map((elem) => {
        console.log(entry[elem].value);
      });
    });
  });
});

/**
 * test: Search 2
 */
describe('testing skill framework', () => {
  jest.setTimeout(60000);
  test('Troublecode search results should be returned for multiple parameters', async () => {
    const connector = getConnectorFactory().create();

    console.log(`Got connector ${connector}.`);

    const queryVariables = [
      { vin: 'WBAAL31029PZ00001', problemArea: 'Getriebe', minVersion: 1 },
      { vin: 'WBAAL31029PZ00001', problemArea: 'Getriebe', minVersion: 1 },
    ];

    const result = await connector.execute('TroubleCodeSearch', queryVariables);

    console.log('Query results');
    result.results.bindings.map(function (entry) {
      result.head.vars.map((elem) => {
        console.log(entry[elem].value);
      });
    });
  });
});

/**
 * test: get Ontologies URLs from github
 */
describe('testing skill framework', () => {
  jest.setTimeout(60000);
  test('get Ontologie URLs from github ', async () => {
    //const result = await getOntologies();

    const ontologyHub = getOntologyHubFactory().create();
    console.log(ontologyHub.constructor.name);
    const result = await ontologyHub.getOntologies();
    expect(result.length).toBeGreaterThan(0);
    console.log(result);
  });
});
