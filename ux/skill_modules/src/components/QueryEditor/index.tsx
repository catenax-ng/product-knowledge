import React from 'react';
import { Box } from '@mui/material';

import CodeMirrorEditor from './CodeMirrorEditor';
import { Tab, TabPanel, Tabs } from 'cx-portal-shared-components';
import SupernaturlaEditor from './SupernaturalEditor';
import MonacoEditor from './MonacoEditor';

export const QueryEditor = () => {
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

  function a11yProps(index: number) {
    return {
      id: `simple-tab-${index}`,
      'aria-controls': `simple-tabpanel-${index}`,
    };
  }
  const [value, setValue] = React.useState(0);

  const handleChange = (event: React.SyntheticEvent, newValue: number) => {
    setValue(newValue);
  };

  return (
    <Box>
      <Box sx={{ borderBottom: 1, borderColor: 'divider' }}>
        <Tabs value={value} onChange={handleChange} aria-label="basic tabs example">
          <Tab label="Supernatural Editor" {...a11yProps(0)} />
          <Tab label="Code Mirror" {...a11yProps(1)} />
          <Tab label="Monaco Editor" {...a11yProps(2)} />
        </Tabs>
      </Box>
      <TabPanel value={value} index={0}>
        <SupernaturlaEditor />
      </TabPanel>
      <TabPanel value={value} index={1}>
        <CodeMirrorEditor />
      </TabPanel>
      <TabPanel value={value} index={2}>
        <MonacoEditor defaultCode={defaultCode}/>
      </TabPanel>
    </Box>
  );
};
