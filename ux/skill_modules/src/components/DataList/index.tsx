import { BindingSet, Entry } from '@catenax-ng/skill-framework/dist/src';
import { IconButton, Table, Typography } from 'cx-portal-shared-components';
import React from 'react';
import { GridColDef, GridRowId, GridRowModel } from '@mui/x-data-grid';
import { Box, Tooltip } from '@mui/material';
import ErrorTwoToneIcon from '@mui/icons-material/ErrorTwoTone';

interface DataListProps {
  search: string;
  id: string;
  data: BindingSet;
  actions?: Action[];
}

interface Action {
  name: string;
  icon: Element;
  onClick: (id: string | undefined) => void;
  rowKey: string;
}

export const DataList = ({ search, id, data, actions }: DataListProps) => {
  const tableTitle = `Results for ${search}`;
  const hiddenColums = ['shape', 'contentType'];

  const getTtlByUrl = (url: string) =>
    url.split('/').filter((str) => str.includes('ttl'))[0];

  const resultToColumns = (result: string[]): Array<GridColDef> => {
    const columns: Array<GridColDef> = result.map((item) => ({
      field: item,
      flex: 2,
      renderCell: ({ row }: { row: Entry }) => {
        const rowItem = row[item];
        let val = rowItem ? rowItem.value : '';
        val = val.replace('\\"', '"').replace('\\n', '\n');
        if (item === 'isDefinedBy') {
          val = val.split(',').map(getTtlByUrl).toString();
          console.log(val);
        }
        return (
          <Tooltip title={val}>
            <span
              style={{
                whiteSpace: 'nowrap',
                overflow: 'hidden',
                direction: 'rtl',
                textOverflow: 'ellipsis',
              }}
            >
              {val}
            </span>
          </Tooltip>
        );
      },
      hide: hiddenColums.includes(item),
    }));
    if (actions && actions.length > 0) {
      const actionColumn = {
        field: 'actions',
        flex: 2,
        renderCell: ({ row }: { row: Entry }) =>
          actions.map((action) => {
            const rowValue = row[action.rowKey];
            const onClickParam = row && rowValue ? rowValue.value : '';
            return (
              <IconButton
                key={action.name}
                title={action.name}
                onClick={() => action.onClick(onClickParam)}
              >
                {action.icon}
              </IconButton>
            );
          }),
      };
      columns.push(actionColumn);
    }
    return columns;
  };

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
