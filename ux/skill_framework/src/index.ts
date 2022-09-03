//
// Main logic of the skill framework
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//

import fetch from 'node-fetch';
import { RequestInit } from 'node-fetch';
import createHttpsProxyAgent from 'https-proxy-agent'; 
import { HttpsProxyAgent } from 'https-proxy-agent'; 

// issue a module loading message
console.log("Debug: Loading skill_framework/index");

/*
 * a connector factory
 */
export interface IConnectorFactory {
    create: () => IConnector
}

/**
 * the connector interface
 */
export interface IConnector {
    /**
     * function to list all assets of the default catalogue through this connector
     * the providerUrl is an optional parameter (means that we will look for the local catalogue)
     */
    listAssets: (providerUrl?:string) => Promise<Catalogue>
}

/**
 * an EDC (Federated) Catalogue
 */
export interface Catalogue {
    /**
     * the id of the catalogue
     */
    id: string,
    /**
     * the list of offers
     */
    contractOffers: ContractOffer[]
}

/**
 * an EDC offer
 */
export interface ContractOffer {
    /**
     * id of the offer
     */
    id: string,
    /**
     * optional id of the associated policy
     */
    policyId?: string,
    /**
     * optional id of the associated artifact/asset
     */
    assetId?: string,
    /**
     * the urn of the provider
     */
    provider: string,
    /**
     * the urn of the consumer
     */
    consumer: string,
    /**
     * if this offer is temporarily restricted: the start of the offer
     */
    offerStart?: string,
    /**
     * if this offer is temporarily restricted: the end of the offer
     */
    offerEnd?: string,
    /**
     * if the contract associated to this offer is temporarily restricted: the start of the contract
     */
    contractStart?: string,
    /**
     * if the contract associated to this offer is temporarily restricted: the end of the contract
     */
    contractEnd?: string,
    /**
     * the policy of the offer
     */
    policy: Policy,
    /**
     * the asset description of the offer
     */
    asset: Asset
}

/**
 * a connector policy
 */
interface Policy {
    /** unique id of the policy */
    uid: string,
    /** a set of permissions */
    permissions: Condition[],
    /** a set of prohibitions */
    prohibitions: Condition[],
    /** a set of obligations */
    obligations: Condition[],
    /** this is extensible */
    extensibleProperties: any,
    /** policies may inherit from each other, this would be the uid of the parent policy if so */
    inheritsFrom?: string,
    /** the assigner of the policy */
    assigner?: string,
    /** the assignee of the policy */
    assignee?: string,
    /** the target of the policy (if restricted) */
    target?: string,
    /** the type of the policy */
    '@type': PolicyTypeObject
}

/** 
 * different policy types 
 * TODO wtf is that a set versus singelton or the policy is "set"/"get"?*/
export enum PolicyType {
    /** set or set */
    set = "set"
}

/**
 * an object describing the policy type further
 */
interface PolicyTypeObject {
    /** references the type */
   '@policytype': PolicyType
}

/**
 * an invividual permission, obligation or prohibition
 */
interface Condition {
    /** 
     * type of condition
     * TODO maybe we need an enum here
     */
    edctype: string,
    /**
     * condition may have a unique identifier
     */
    uid?: string,
    /**
     * a target of the condition
     */
    target: string,
    /**
     * the action that is permitted/prohibited or obliged
     */
    action: Action,
    /**
     * assignee of the condition
     */
    assignee?: string,
    /**
     * assigner of the condition
     */
    assigner?: string,
    /** a set of constraints on the condition */
    constraints: Constraint[],
    /** a set of duties attached to the condition */
    duties: Constraint[]
}

/**
 * different types of actions
 * TODO insert graph actions
 */
export enum ActionType {
    /** do what you want with it */
    USE = "USE"
}

/**
 * an action in a condition
 */
export interface Action {
    /** type of action */
    type: ActionType,
    /** TODO wtf */
    includedIn?: string,
    /** an action may also directly have a constraint */
    constraint?: Constraint
}

/**
 * TODO need to define constraints
 */
export interface Constraint {
}

/**
 * this is an asset description
 */
export interface Asset {
    /** just a flexible property container */
    properties: AssetProperties
}

/**
 * the flexible properties of an asset
 */
export interface AssetProperties {
    /** clear name of the asset  */
    'asset:prop:name': string,
    /** content type TODO use enum or media type  */
    'asset:prop:contenttype': string,
    /** optional size */
    'ids:byteSize'?: number,
    /** version of the asset descriptor */
    'asset:prop:version'?: string,
    /** id of the asset */
    'asset:prop:id': string,
    /** optional filename when downloading */
    'ids:fileName'?: string,
    /** a policy may be referenced directly  */
    'asset:prop:policy-id'?: string,

}

/**
 * this is an artifact (complete description of asset and address part)
 */
export interface Artifact {
    /** links an asset description */
    asset:Asset,
    /** with a data address description */
    dataAddress:DataAddress
}

/**
 * this is a dataaddress
 */
export interface DataAddress {
    /** just a flexible container of properties */
    properties: DataAddressProperties
}

/**
 * the different types of endpoints/data planes supported
 */
export enum DataAddressEndpointType {
    /** http data plane */
    HttpData = "HttpData"
}

/**
 * the flexible properties of a data address
 */
export interface DataAddressProperties {
    /** link to the backend system interfaced */
    endpoint: string,
    /** type of data plane attached */
    type: DataAddressEndpointType
}

/**
 * Implementation of a mock connector
 */
class MockConnector implements IConnector {
    public listAssets(providerUrl?: string): Promise<Catalogue> {
        return Promise.resolve({
            "id": "default",
            "contractOffers": [
                {
                    "id": "contract-readall:6854d537-c810-49c0-85e6-df038257d90c",
                    "policy": {
                        "uid": "f0930399-72da-4d64-82e1-e7df015de403",
                        "permissions": [
                            {
                                "edctype": "dataspaceconnector:permission",
                                "target": "offer-code",
                                "action": {
                                    "type": ActionType.USE,
                                },
                                "constraints": [],
                                "duties": []
                            }
                        ],
                        "prohibitions": [],
                        "obligations": [],
                        "extensibleProperties": {},
                        "@type": {
                            "@policytype": PolicyType.set
                        }
                    },
                    "asset": {
                        "properties": {
                            "asset:prop:name": "Tenant Offer of Certificates of Destruction.",
                            "asset:prop:contenttype": "application/json",
                            "asset:prop:policy-id": "use-eu",
                            "asset:prop:id": "offer-code",
                        }
                    },
                    "provider": "urn:connector:provider",
                    "consumer": "urn:connector:consumer",
                }
            ]});
    }
}

/**
 * mock connector factory
 */
export class EnvironmentConnectorFactory implements IConnectorFactory {
    private environmentConnector: IConnector;
    
    constructor() {
        if (process.env.SKILL_CONNECTOR != undefined && process.env.SKILL_CONNECTOR != "" ) {
            this.environmentConnector = new RemoteConnector(process.env.SKILL_CONNECTOR,undefined,process.env.SKILL_PROXY);
        } else {
            this.environmentConnector = new MockConnector();
        }
    }

    public create() {
        return this.environmentConnector;
    }
}

interface IRealmMappingFactory {
    create: () => IRealmMapping
}

interface IRealmMapping {
    getHeaderAnnotation: (targetDomain:string ) => any
}

class EnvironmentRealmMappingFactory implements IRealmMappingFactory {
    private environmentRealmMapping:IRealmMapping;

    constructor() {
        this.environmentRealmMapping = new EnvironmentRealmMapping();
    }

    public create() {
        return this.environmentRealmMapping;
    }
}

class EnvironmentRealmMapping implements IRealmMapping {

    public getHeaderAnnotation(targetDomain:string) {
        var headers:any={};
        if(process.env.SKILL_CONNECTOR_AUTH_HEADER_KEY != undefined) {
            headers[ process.env.SKILL_CONNECTOR_AUTH_HEADER_KEY ?? "" ] =  process.env.SKILL_CONNECTOR_AUTH_HEADER_VALUE;
        }
        return headers;
    }
}

/**
 * global factory variable
 */
 var realmMappingFactory:IRealmMappingFactory = new EnvironmentRealmMappingFactory();

 /**
  * @returns the global connector factory
  */
 export const getRealmMappingFactory = function() {
     return realmMappingFactory;
 };
 
 /**
  * sets 
  * @param factory the new global factory
  */
 
 export const setRealmMappingFactory = function( factory: IRealmMappingFactory) {
   realmMappingFactory=factory;
 }

/**
 * Implementation of a mock connector
 */
class RemoteConnector implements IConnector {
    private url:string;
    private realmMapping:IRealmMapping;
    private proxy?:HttpsProxyAgent;

    constructor(url:string, realmMapping?:IRealmMapping, proxy?:string) {
        this.url=url;
        this.realmMapping=realmMapping ?? getRealmMappingFactory().create();
        if(proxy) {
            this.proxy=createHttpsProxyAgent(proxy);
        } 
    }
    
    public async listAssets(providerUrl?: string) : Promise<Catalogue> {
       const start = new Date().getTime();
       const finalproviderUrl = providerUrl ?? this.url;
       const idsUrl = `${finalproviderUrl}/api/v1/ids/data`;

       console.log(`Listing Assets from Remote Connector ${finalproviderUrl} starts at ${start}.`);

       const finalUrl = `${this.url}/data/catalog?providerUrl=${idsUrl}`;
       
       const fetchOpts:RequestInit= {
        method: 'GET',
        headers: this.realmMapping.getHeaderAnnotation(this.url),
        agent: this.proxy
       };

       // 👇️ const response: Response
       const response = await fetch(finalUrl,fetchOpts);
       
       let elapsed = new Date().getTime() - start;

       console.log(`Listing Assets from Remote Connector finished after ${elapsed} milliseconds.`);

       if (!response.ok) {
         throw new Error(`Error! status: ${response.status}`);
       }
  
       // 👇️ const result: GetUsersResponse
       const result = (await response.json()) as Catalogue;
  
       //console.log('result is: ', JSON.stringify(result, null, 4));
  
       return result;
    }

}

/**
 * global factory variable
 */
 var connectorFactory:IConnectorFactory = new EnvironmentConnectorFactory();

 /**
  * @returns the global connector factory
  */
 export const getConnectorFactory = function() {
     return connectorFactory;
 };
 
 /**
  * sets 
  * @param factory the new global factory
  */
 
 export const setConnectorFactory = function( factory: IConnectorFactory) {
   connectorFactory=factory;
 }
 

