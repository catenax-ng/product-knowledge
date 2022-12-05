import { BindingSet, Entry } from '@catenax-ng/skill-framework/dist/src';
import { Table, Typography } from 'cx-portal-shared-components';
import React from 'react';
import { GridColDef } from '@mui/x-data-grid';
import { Box } from '@mui/material';
import ErrorTwoToneIcon from '@mui/icons-material/ErrorTwoTone';

export const DataList = ({ search, id, data }: { search: string; id:string; data: BindingSet }) => {
  const tableTitle = `Results for ${search}`;
  const resultToColumns = (result: string[]): Array<GridColDef> =>
    result.map((item) => ({
      field: item,
      flex: 2,
      valueGetter: ({ row }: { row: Entry }) =>
        row[item].value ? row[item].value : 'No Value',
    }));

  return (
    <>
      {data.results.bindings.length > 0 ? (
        <Table
          title={tableTitle}
          rowsCount={data.results.bindings.length}
          columns={resultToColumns(data.head.vars)}
          rows={data.results.bindings}
          getRowId={(row) => row[id].value}
        />
      ) : (
        <Box textAlign="center" maxWidth="500px" ml="auto" mr="auto">
          <ErrorTwoToneIcon color="warning" fontSize="large" />
          <Typography variant="h4">Empty search result</Typography>
          <Typography>
            We could not find any data related to your search request. Please
            change your search input.
          </Typography>
        </Box>
      )}
    </>
  );
};
