import { getOntologyHubFactory } from '../src';

/**
 * test: get Ontologies URLs from github
 */
describe('testing ontology hub', () => {
  jest.setTimeout(60000);
  test('get Ontologie URLs from github ', async () => {
    const ontologyHub = getOntologyHubFactory().create();
    expect(ontologyHub.constructor.name).toBe('MockOntologyHub');
    const result = await ontologyHub.getOntologies();
    expect(result.length).toBeGreaterThan(0);
    result.map((entry) => {
      expect(entry).toEqual(
        expect.objectContaining({
          name: expect.any(String),
          download_url: expect.any(String),
          vowl: expect.any(String),
          type: expect.any(String),
          version: expect.any(String),
          status: expect.any(String),
        })
      );
    });
  });
});
