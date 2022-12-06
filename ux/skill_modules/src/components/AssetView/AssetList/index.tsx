import {
  AssetProperties,
  getConnectorFactory,
  BindingSet,
} from '@catenax-ng/skill-framework/dist/src';
import { DataList } from '../../DataList';

import React, { useEffect, useState } from 'react';

function AssetList() {
  const [searchResult, setSearchResult] = useState<BindingSet>();
  const [search, setSearch] = useState<string>('Assets');
  const [searchKey, setSearchKey] = useState<string>('asset');

  const [assetList, setAssetList] = useState<AssetProperties[]>([]);
  useEffect(() => {
    const connector = getConnectorFactory().create();
    connector.execute('Dataspace', {}).then((catalogue) => {
      console.log(catalogue);
      setSearchResult(catalogue);
    });
  }, []);

  return (
    <>
      {searchResult && (
        <DataList search={search} id={searchKey} data={searchResult} />
      )}
    </>
  );
}

export default AssetList;
