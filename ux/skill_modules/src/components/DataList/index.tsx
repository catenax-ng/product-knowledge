import { BindingSet, Entry } from '@catenax-ng/skill-framework/dist/src';
import { Table, Typography } from 'cx-portal-shared-components';
import React from 'react';
import { GridColDef, GridRowId, GridRowModel } from '@mui/x-data-grid';
import { Box, Tooltip } from '@mui/material';
import ErrorTwoToneIcon from '@mui/icons-material/ErrorTwoTone';

interface DataListProps {
  search: string;
  id: string;
  data: BindingSet;
}

export const DataList = ({ search, id, data }: DataListProps) => {
  const tableTitle = `Results for ${search}`;
  const resultToColumns = (result: string[]): Array<GridColDef> =>
    result.map((item) => ({
      field: item,
      flex: 2,
      renderCell: ({ row }: { row: Entry }) => (
        <Tooltip title={row[item].value}>
          <span
            style={{
              whiteSpace: 'nowrap',
              overflow: 'hidden',
              textOverflow: 'ellipsis',
            }}
          >
            {row[item].value ? row[item].value : ''}
          </span>
        </Tooltip>
      ),
    }));

  const rowId = (row: GridRowModel): GridRowId => {
    if (id != undefined && row[id] != undefined) {
      return String(row[id].value);
    } else {
      return JSON.stringify(row);
    }
  };

  return (
    <>
      {data.results.bindings.length > 0 ? (
        <Table
          density="compact"
          title={tableTitle}
          rowsCount={data.results.bindings.length}
          columns={resultToColumns(data.head.vars)}
          rows={data.results.bindings}
          getRowId={rowId}
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
