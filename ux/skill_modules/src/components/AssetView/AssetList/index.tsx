import {getConnectorFactory, AssetProperties} from '@knowledge-agents-ux/skill_framework/dist/src'
import { TableContainer, Table, TableHead, TableRow, TableCell, TableBody } from '@mui/material';
import React, { useEffect, useState } from 'react';

function AssetList() {
  const [assetList, setAssetList] = useState<AssetProperties[]>([])

  useEffect(() => {
    const connector = getConnectorFactory().create();
    connector.listAssets().then(catalogue => setAssetList(catalogue.contractOffers.map(offer => offer.asset.properties)));
  }, [])

  const columns = [
    { key: 'asset:prop:id', name: 'ID', flex: 3 },
    { key: 'asset:prop:name', name: 'Name', flex: 3 },
    { key: 'ids:byteSize', name: 'Byte Size', flex: 3 },
    { key: 'asset:prop:version', name: 'Version', flex: 2 },
    { key: 'ids:fileName', name: 'Filename', flex: 2 },
    { key: 'asset:prop:contenttype', name: 'Content Type', flex: 2 },
    { key: 'asset:prop:policy-id', name: 'Policy ID', flex: 3},
  ];

  return (
    <TableContainer>
      <Table sx={{ minWidth: 650 }} aria-label="asset table">
        <TableHead>
          <TableRow>
            {columns.map((col) => (
              <TableCell key={col.key}>{col.name}</TableCell>
            ))}
          </TableRow>
        </TableHead>
        <TableBody>
          {assetList.map((asset) => (
            <TableRow
              key={asset['asset:prop:id']}
              sx={{ '&:last-child td, &:last-child th': { border: 0 } }}
            >
              <TableCell>{asset['asset:prop:id']}</TableCell>
              <TableCell>{asset['asset:prop:name']}</TableCell>
              <TableCell>{asset['ids:byteSize']}</TableCell>
              <TableCell>{asset['asset:prop:version']}</TableCell>
              <TableCell>{asset['ids:fileName']}</TableCell>
              <TableCell>{asset['asset:prop:contenttype']}</TableCell>
              <TableCell>{asset['asset:prop:policy-id']}</TableCell>
            </TableRow>
          ))}
        </TableBody>
      </Table>
    </TableContainer>
  );
}

export default AssetList;