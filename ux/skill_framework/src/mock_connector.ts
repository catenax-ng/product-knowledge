//
// Mock logic of the skill framework
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//

import { JSONElement, BindingSet } from './data';
import { IConnector } from './connector';
import { ASSETS, SEARCH_RESULT } from './mock_data';

/**
 * Implementation of a mock connector
 */
export class MockConnector implements IConnector {
  //execute
  public execute(
    skill: string,
    queryVariables: JSONElement,
    data_url?: string
  ): Promise<BindingSet> {
    if (skill === 'Dataspace') return Promise.resolve(ASSETS);
    return Promise.resolve(SEARCH_RESULT);
  }
  //execute
  public executeQuery(
    query: string,
    queryVariables: JSONElement,
    data_url?: string
  ): Promise<BindingSet> {
    return Promise.resolve(SEARCH_RESULT);
  }

  public currentConnector(): string {
    return 'MOCK_CONNECTOR';
  }
}
