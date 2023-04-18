//
// Remote connectors
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//

import { JSONElement, JSONArray, Warning, BindingSet } from './data';
import { IConnector, IRealmMapping } from './connector';
import { getRealmMappingFactory } from './index';
import fetch from 'node-fetch';
import { RequestInit } from 'node-fetch';
import createHttpsProxyAgent from 'https-proxy-agent';
import { HttpsProxyAgent } from 'https-proxy-agent';

/**
 * Implementation of a remote connector
 */
export class RemoteConnector implements IConnector {
  private url: string;
  private data_url: string;
  private realmMapping: IRealmMapping;
  private proxy?: HttpsProxyAgent;

  constructor(
    url: string,
    data_url: string,
    realmMapping?: IRealmMapping,
    proxy?: string
  ) {
    this.url = url;
    this.data_url = data_url;
    this.realmMapping = realmMapping ?? getRealmMappingFactory().create();
    if (proxy) {
      const url = new URL(proxy);
      this.proxy = createHttpsProxyAgent({
        host: url.hostname,
        port: url.port,
      });
    }
  }

  public currentConnector(): string {
    return this.data_url;
  }

  //Execute Query
  public async execute(
    skill: string,
    queryVariable: JSONElement,
    data_url?: string
  ): Promise<BindingSet> {
    const start = new Date().getTime();

    const skillUrl = '/api/agent?asset=urn:cx:Skill:consumer:' + skill;
    let parameters = '';
    let parametersContainer = '';
    let queryVariables: JSONArray = [];

    if (Array.isArray(queryVariable)) {
      queryVariables = queryVariable;
    } else {
      queryVariables = [queryVariable];
    }

    queryVariables.forEach((query) => {
      Object.entries(query).forEach(
        ([key, value]) => (parameters = `${parameters}&${key}=${value}`)
      );
      parameters = parameters.replace(/^&/, '');
      parametersContainer = parametersContainer + '&(' + parameters + ')';
      parameters = '';
    });

    const target_url = data_url ?? this.data_url;

    const finalUrl = target_url + skillUrl + parametersContainer;

    const fetchOpts: RequestInit = {
      method: 'GET',
      headers: this.realmMapping.getHeaderAnnotation(this.url),
      agent: this.proxy,
    };

    try {
      //Response
      const response = await fetch(finalUrl, fetchOpts);

      const elapsed = new Date().getTime() - start;

      // eslint-disable-next-line no-console
      console.log(
        `Result from Remote Connector Skill ${skill} finished after ${elapsed} milliseconds.`
      );

      if (!response.ok) {
        const errorResult: BindingSet = {
          head: { vars: [] },
          results: { bindings: [] },
          warnings: [
            {
              'source-tenant': this.data_url,
              problem: `Could not successfully execute skill ${skill}, status: ${response.status}`,
            },
          ],
        };
        return errorResult;
      }

      //result: BindingSet
      const result = (await response.json()) as BindingSet;

      if (response.headers.has('cx_warnings')) {
        const warnings = JSON.parse(
          response.headers.get('cx_warnings')!
        ) as Warning[];
        result.warnings = warnings;
      }

      return result;
    } catch (e) {
      const elapsed = new Date().getTime() - start;
      // eslint-disable-next-line no-console
      console.log(
        `Result from Remote Connector Skill ${skill} failed after ${elapsed} milliseconds with error ${e}.`
      );

      const errorResult: BindingSet = {
        head: { vars: [] },
        results: { bindings: [] },
        warnings: [
          {
            'source-tenant': this.data_url,
            problem: `Could not execute skill ${skill}, error: ${e}`,
          },
        ],
      };

      return errorResult;
    }
  }

  //Execute Query
  public async executeQuery(
    query: string,
    queryVariable: JSONElement,
    data_url?: string
  ): Promise<BindingSet> {
    const start = new Date().getTime();

    const skillUrl = '/api/agent';
    let parameters = '';
    let parametersContainer = '';
    let concatenateParams = '?';
    let queryVariables: JSONArray = [];

    if (Array.isArray(queryVariable)) {
      queryVariables = queryVariable;
    } else {
      queryVariables = [queryVariable];
    }

    queryVariables.forEach((query) => {
      Object.entries(query).forEach(
        ([key, value]) => (parameters = `${parameters}&${key}=${value}`)
      );
      parameters = parameters.replace(/^&/, '');
      parametersContainer =
        parametersContainer + concatenateParams + '(' + parameters + ')';
      concatenateParams = '&';
      parameters = '';
    });

    const target_url = data_url ?? this.data_url;

    const finalUrl = target_url + skillUrl + parametersContainer;

    const headers = this.realmMapping.getHeaderAnnotation(this.url);
    headers['Content-Type'] = 'application/sparql-query';

    const fetchOpts: RequestInit = {
      method: 'POST',
      headers: headers,
      agent: this.proxy,
      body: query,
    };

    try {
      //Response
      const response = await fetch(finalUrl, fetchOpts);

      const elapsed = new Date().getTime() - start;
      // eslint-disable-next-line no-console
      console.log(
        `Result from Remote Connector finished after ${elapsed} milliseconds.`
      );

      if (!response.ok) {
        const errorResult: BindingSet = {
          head: { vars: [] },
          results: { bindings: [] },
          warnings: [
            {
              'source-tenant': this.data_url,
              problem: `Could not successfully execute query, status: ${response.status}`,
            },
          ],
        };
        return errorResult;
      }

      //result: BindingSet
      const result = (await response.json()) as BindingSet;

      if (response.headers.has('cx_warnings')) {
        const warnings = JSON.parse(
          response.headers.get('cx_warnings')!
        ) as Warning[];
        result.warnings = warnings;
      }

      return result;
    } catch (e) {
      const elapsed = new Date().getTime() - start;
      // eslint-disable-next-line no-console
      console.log(
        `Result from Remote Connector failed after ${elapsed} milliseconds with error ${e}.`
      );

      const errorResult: BindingSet = {
        head: { vars: [] },
        results: { bindings: [] },
        warnings: [
          {
            'source-tenant': this.data_url,
            problem: `Could not execute query, error: ${e}`,
          },
        ],
      };

      return errorResult;
    }
  }
}
