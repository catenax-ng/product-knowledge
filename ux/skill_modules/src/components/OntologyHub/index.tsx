import {
  getOntologyHubFactory,
  OntologyResult,
} from '@catenax-ng/skill-framework/dist/src';
import { Table, Typography } from 'cx-portal-shared-components';
import React, { useEffect, useState } from 'react';

interface OntologyHubProps {
  onOntologySelect: (vowlUrl: string) => void;
}

export function OntologyHub({ onOntologySelect }: OntologyHubProps) {
  const [ontologyList, setOntologyList] = useState<OntologyResult[]>([]);

  useEffect(() => {
    const ontologyHub = getOntologyHubFactory().create();
    ontologyHub.getOntologies().then((data) => setOntologyList(data));
  }, []);

  const columns = [
    {
      field: 'name',
      flex: 2,
      headerName: 'Name',
      renderCell: ({ row }: { row: OntologyResult }) => (
        <Typography onClick={() => onOntologyClick(row.vowl)}>
          {row.name}
        </Typography>
      ),
    },
    {
      field: 'version',
      flex: 2,
      headerName: 'Version',
    },
    {
      field: 'status',
      flex: 2,
      headerName: 'Status',
    },
  ];

  const onOntologyClick = (vowlLink: string) => {
    onOntologySelect(vowlLink);
  };

  return (
    <Table
      title="Ontology Hub"
      rowCount={ontologyList.length}
      columns={columns}
      rows={ontologyList}
      getRowId={(row: OntologyResult) => row.vowl}
    />
  );
}