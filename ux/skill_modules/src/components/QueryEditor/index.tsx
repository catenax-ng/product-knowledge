import React, { useState } from 'react';
import { Box } from '@mui/material';

import CodeMirrorEditor from './CodeMirrorEditor';
import { Tab, TabPanel, Tabs } from 'cx-portal-shared-components';
import SupernaturlaEditor from './SupernaturalEditor';
import MonacoEditor from './MonacoEditor';
import { BindingSet } from '@catenax-ng/skill-framework/dist/src';
import { DataList } from '../DataList';
import SparqlEditor from './SparqlEditor/SparqlEditor';

export const QueryEditor = () => {
  const defaultCode = `PREFIX cx: <https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/cx_ontology.ttl#>
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>
PREFIX bpns: <bpn:site:>

######
# Sample "Material Site" Trace Skill
# An trace incident has
# - a description of the target material # - a bpns number # The skill produces # - source part(s) # - affected product(s) and organization(s) # - (m)bom trace(s) from source to product ######

SELECT ?site ?part ?partName ?vendor ?product ?productName ?part2 ?part3 ?part4 ?site2 ?site3 ?site4 ?site5 WHERE {

  VALUES (?material ?site) { 
      ("Cathode"^^xsd:string bpns:BPNS00000003B0Q0)
  }
  
  ## Find the connector address of the responsible
  ## businesspartner/orga from the federated data catalogue
  ?incidentOrga cx:hasSite ?site;
        cx:hasConnector ?connectorUrl.
        
  SERVICE ?connectorUrl {

      ## Is there a product which has the incident "material"
      ## workaround: use the part name
       ?part rdf:type cx:Part;
         cx:partName ?partName;
         cx:isProducedBy ?site.
       FILTER( CONTAINS(?partName, ?material)).

      ?part cx:isPartOf ?part2.
      ?part2 cx:partName ?part2Name;
             cx:isProducedBy ?site2.
  
      OPTIONAL {
          ?part2 cx:isPartOf ?part3.
          ?part3 cx:partName ?part3Name;
                 cx:isProducedBy ?site3.
      }

     OPTIONAL {
          ?part3 cx:isPartOf ?part4.
          ?part4 cx:partName ?part4Name;
                 cx:isProducedBy ?site4.
     }

      OPTIONAL {
          ?part4 cx:isPartOf ?product.
          ?product cx:partName ?productName;
                   cx:isProducedBy ?site5.
     }
  }

  ?vendor cx:hasSite ?site5.
} 
`;
  const [result, setResult] = useState<BindingSet>();
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
        <Tabs
          value={value}
          onChange={handleChange}
          aria-label="basic tabs example"
        >
          <Tab label="Yasgui Editor" {...a11yProps(0)} />
          <Tab label="Supernatural Editor" {...a11yProps(1)} />
          <Tab label="Code Mirror" {...a11yProps(2)} />
          <Tab label="Monaco Editor" {...a11yProps(3)} />
        </Tabs>
      </Box>
      <TabPanel value={value} index={0}>
        <SparqlEditor defaultCode={defaultCode} onSubmit={setResult} />
      </TabPanel>
      <TabPanel value={value} index={1}>
        <SupernaturlaEditor />
      </TabPanel>
      <TabPanel value={value} index={2}>
        <CodeMirrorEditor defaultCode={defaultCode} onSubmit={setResult} />
      </TabPanel>
      <TabPanel value={value} index={3}>
        <MonacoEditor defaultCode={defaultCode} onSubmit={setResult} />
      </TabPanel>
      {result && <DataList search={'Sparql Query'} data={result} />}
    </Box>
  );
};
