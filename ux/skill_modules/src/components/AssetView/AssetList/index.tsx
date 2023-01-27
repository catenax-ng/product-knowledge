import {
  getConnectorFactory,
  BindingSet,
} from '@catenax-ng/skill-framework/dist/src';
import { DataList } from '../../DataList';
import EastIcon from '@mui/icons-material/East';

import React, { useEffect, useState } from 'react';

interface AssetListProps {
  filter?: string;
}
function AssetList({ filter }: AssetListProps) {
  const [searchResult, setSearchResult] = useState<BindingSet>();

  useEffect(() => {
    const connector = getConnectorFactory().create();
    //here add filter
    console.log('Filter Assets by Ontology: ' + filter);
    connector.execute('Dataspace', {}).then((catalogue) => {
      console.log(catalogue);
      setSearchResult(catalogue);
    });
  }, []);

  const actions = [
    {
      name: 'Jump to related Ontologies',
      icon: <EastIcon />,
      onClick: (value: string | undefined) => console.log(value),
      rowKey: 'isDefinedBy',
    },
  ];

  return (
    <>
      {searchResult && (
        <DataList
          search="Assets"
          id="asset"
          data={searchResult}
          actions={actions}
        />
      )}
    </>
  );
}

export default AssetList;
