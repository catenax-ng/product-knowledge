import React, { useState } from 'react';
import { Box } from '@mui/material';

import CodeMirrorEditor from './CodeMirrorEditor';
import { Tab, TabPanel, Tabs } from 'cx-portal-shared-components';
import SupernaturlaEditor from './SupernaturalEditor';
import MonacoEditor from './MonacoEditor';
import { BindingSet } from '@catenax-ng/skill-framework/dist/src';
import { DataList } from '../DataList';

export const QueryEditor = () => {
  const defaultCode = `SELECT 
  ?connector ?id ?name ?description ?type ?version ?contentType 
  WHERE { 
    ?connector <https://github.com/catenax-ng/product-knowledge/ontology/cx.ttl%23offersAsset> ?asset.
    ?asset <https://github.com/catenax-ng/product-knowledge/ontology/common_ontology.ttl%23contentType> ?contentType; 
    <http://www.w3.org/1999/02/22-rdf-syntax-ns%23type> ?type;
    <https://github.com/catenax-ng/product-knowledge/ontology/common_ontology.ttl%23version> ?version; 
    <https://github.com/catenax-ng/product-knowledge/ontology/common_ontology.ttl%23description> ?description.
  }`;
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
          <Tab label="Supernatural Editor" {...a11yProps(0)} />
          <Tab label="Code Mirror" {...a11yProps(1)} />
          <Tab label="Monaco Editor" {...a11yProps(2)} />
        </Tabs>
      </Box>
      <TabPanel value={value} index={0}>
        <SupernaturlaEditor />
      </TabPanel>
      <TabPanel value={value} index={1}>
        <CodeMirrorEditor defaultCode={defaultCode} onSubmit={setResult} />
      </TabPanel>
      <TabPanel value={value} index={2}>
        <MonacoEditor defaultCode={defaultCode} onSubmit={setResult} />
      </TabPanel>
      {result && (
        <DataList search={'Sparql Query'} id={'sparql-query'} data={result} />
      )}
    </Box>
  );
};
