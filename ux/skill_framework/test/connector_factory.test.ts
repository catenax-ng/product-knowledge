/* eslint-disable no-console */
//
// Test logic for the skill framework
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//

import { getConnectorFactory } from '../src/index';
import { expect, jest, test, describe } from '@jest/globals';

/**
 * test: get assets
 */
describe('testing list assets', () => {
  jest.setTimeout(15000);
  test('assets should be returned', async () => {
    const connector = getConnectorFactory().create();
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
 * test: Execute Functions
 */
describe('Testing Execute Function', () => {
  jest.setTimeout(60000);
  const connector = getConnectorFactory().create();

  test('Lifetime Search', async () => {
    const vin = 'WVA8984323420333';
    const troubleCode = 'P0745';

    const queryVariables = { vin: vin, troubleCode: troubleCode };

    const result = await connector.execute('Lifetime', queryVariables);

    result.results.bindings.map((entry) => {
      expect(entry).toHaveProperty('vin');
      expect(entry).toHaveProperty('troubleCode');
      expect(entry).toHaveProperty('partProg');
      expect(entry).toHaveProperty('distance');
      expect(entry).toHaveProperty('time');
      expect(entry.vin).toHaveProperty('value', vin);
      expect(entry.troubleCode).toHaveProperty('value', troubleCode);
      Object.keys(entry).forEach((key) => {
        expect(entry[key]).toEqual(
          expect.objectContaining({
            type: expect.any(String),
            value: expect.any(String),
          })
        );
      });
      expect(entry.time).toHaveProperty('datatype');
      expect(entry.distance).toHaveProperty('datatype');
    });
  });

  test('Trouble Code Search with one parameter', async () => {
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

  test('Trouble Code Search with multiple parameter', async () => {
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
