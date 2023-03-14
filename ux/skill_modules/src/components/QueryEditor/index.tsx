import React, { useCallback, useEffect, useRef, useState } from 'react';
import { Box, Button } from '@mui/material';
import 'sparnatural';
import 'sparnatural/dist/sparnatural.css';
// import the JSON-LD config file
import config from './config.json';
import Editor from '@monaco-editor/react';

interface SparnaturalEvent extends Event {
  detail?: {
    queryString: string;
    queryJson: string;
    querySparqlJs: string;
  };
}

export const QueryEditor = () => {
  const sparnaturalRef = useRef<HTMLElement>(null);
  const [theme, setTheme] = useState<string>('light');
  const defaultCode = `PREFIX xsd:	<http://www.w3.org/2001/XMLSchema#> 
PREFIX rdf:	<http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX cx:	<urn:io.catenax.knowledge.Ontology:>
### RUL Skill Input: (@van @troubleCode) ### SELECT ?affectedAssembly ?problem ?kmLeft ?daysLeft WHERE {

  	### Infer the OEM Telematics Asset from Federated Data Catalogue ###
    [ cx:isIssuerOf <@van>; cx:hasConnector [ cx:offersAsset ?telematicsAsset ] ].
    ?telematicsAsset rdf:type cx:GraphAsset; cx:hasUseCaseRole cx:EquipmentManufacturer.

    SERVICE ?telematicsAsset { ### Move Computation from Consumer to OEM ###
        
        ### Analyze DTC and lookup serial parts & telematics data ###
		?problem rdf:type cx:DiagnosticTroubleCode; cx:hasCode <@troubleCode>; cx:affects ?assemblyGroup.
        ?affectedAssembly rdf:type cx:AssemblyGroup; cx:hasDomain ?assemblyGroup; cx:isComponentOf+ <@van>.
        ?loadSpectrum rdf:type cx:LoadSpectrum; cx:recordedBy ?affectedAssembly; cx:hasMileage ?mileage.
    
        ### Find the Supplier (Graph) ###
        ?affectedAssembly cx:isSuppliedBy [ cx:hasConnector [ cx:offersAsset ?progosisAsset ] ]. 
        ?prognosisAsset rdf:type cx:GraphAsset; cx:hasUseCaseRole cx:AssemblySupplier.
          
    	SERVICE ?prognosisAsset { ### Move Computation from OEM to Supplier ### 
		   
           ### Perform a detailed Device Simulation ###
           [ rdf:type cx:LifetimePrognosis; cx:withComponent ?affectedAssembly; 
             cx:withMileage ?mileage; cx:withLoadSpectrum ?loadSpectrum; 
             cx:remainingDistance ?kmLeft; cx:remainingTime ?daysLeft ].
      
        } ### Validates output Supplier->OEM according to contract ###
    } ### Validates output OEM->Consumer according to contract ### } ORDER BY ?kmLeft LIMIT 5 ## Batch Reporting
`;
  const [code, setCode] = useState<string | undefined>(defaultCode);

  useEffect(() => {
    sparnaturalRef?.current?.addEventListener(
      'queryUpdated',
      (event: SparnaturalEvent) => {
        console.log(event?.detail?.queryString);
        console.log(event?.detail?.queryJson);
        console.log(event?.detail?.querySparqlJs);
      }
    );
  }, []);

  const toggleTheme = useCallback(() => {
    console.log('change theme');
    setTheme((theme) => (theme === 'light' ? 'vs-dark' : 'light'));
  }, []);

  useEffect(() => {
    console.log(theme);
  }, [theme]);

  function onCodeChange(value: string | undefined) {
    console.log('hello onCodeChange');
    console.log(value);
    setCode(value);
  }

  const showValue = () => {
    console.log('hello value');
    console.log(code);
  };

  return (
    <Box>
      <Editor
        height="50vh"
        defaultLanguage="sparql"
        defaultValue={defaultCode}
        theme={theme}
        onChange={onCodeChange}
      />
      <Box>
        <Button onClick={toggleTheme}>Toggle Theme</Button>
        <Button onClick={showValue}>Run SPARQL</Button>
      </Box>
      <link
        rel="stylesheet"
        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css"
      />
      <div id="ui-search">
        <spar-natural
          ref={sparnaturalRef}
          src={JSON.stringify(config)}
          lang={'en'}
          endpoint={
            'https://knowledge.dev.demo.catena-x.net/consumer-edc-data/BPNL00000003CQI9/api/agent'
          }
          distinct={'true'}
          limit={'1000'}
          prefix={
            'skos:http://www.w3.org/2004/02/skos/core# rico:https://www.ica.org/standards/RiC/ontology#'
          }
          debug={'true'}
        />
      </div>
    </Box>
  );
};
