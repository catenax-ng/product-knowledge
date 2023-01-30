import {
  getOntologyHubFactory,
  OntologyResult,
} from '@catenax-ng/skill-framework/dist/src';
import { IconButton, Table } from 'cx-portal-shared-components';
import React, { useEffect, useState } from 'react';
import BubbleChartIcon from '@mui/icons-material/BubbleChart';
import { Box } from '@mui/material';
import EastIcon from '@mui/icons-material/East';

interface OntologyHubProps {
  onShowOntologyGraph?: (vowlUrl: string) => void;
  onShowAssetList?: (name: string) => void;
  pageSize: number;
  filter?: string;
}

export function OntologyHub({
  onShowOntologyGraph,
  pageSize,
  onShowAssetList,
  filter,
}: OntologyHubProps) {
  const [ontologyList, setOntologyList] = useState<OntologyResult[]>([]);

  useEffect(() => {
    const ontologyHub = getOntologyHubFactory().create();
    ontologyHub.getOntologies().then((data) => {
      if (filter && filter.length > 0) {
        data = data.filter((row) => filter.includes(row.download_url));
      }
      setOntologyList(data);
    });
  }, [filter]);

  const columns = [
    {
      field: 'name',
      flex: 2,
      headerName: 'Name',
    },
    {
      field: 'type',
      flex: 1,
      headerName: 'Sprache',
    },
    {
      field: 'version',
      flex: 1,
      headerName: 'Version',
    },
    {
      field: 'status',
      flex: 2,
      headerName: 'Status',
    },
    {
      field: 'actions',
      flex: 1,
      headerName: 'Actions',
      renderCell: ({ row }: { row: OntologyResult }) => (
        <Box>
          {onShowOntologyGraph && (
            <IconButton
              title="Show Ontology Graph"
              sx={{ mr: 1 }}
              onClick={() => onShowOntologyGraph(row.vowl)}
            >
              <BubbleChartIcon />
            </IconButton>
          )}
          {onShowAssetList && (
            <IconButton
              title="Jump to related Assets"
              sx={{ mr: 1 }}
              onClick={() => onShowAssetList(row.download_url)}
            >
              <EastIcon />
            </IconButton>
          )}
        </Box>
      ),
    },
  ];

  return (
    <Table
      title="Ontology Hub"
      pageSize={pageSize}
      rowsCount={ontologyList.length}
      columns={columns}
      rows={ontologyList}
      getRowId={(row: OntologyResult) => row.vowl}
    />
  );
}
