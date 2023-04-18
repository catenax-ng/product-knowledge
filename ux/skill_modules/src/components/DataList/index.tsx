import { BindingSet, Entry } from '@catenax-ng/skill-framework/dist/src';
import { IconButton, Table } from 'cx-portal-shared-components';
import React from 'react';
import {
  GridColDef,
  GridRowId,
  GridRowModel,
  GridCellParams,
} from '@mui/x-data-grid';
import { Box, Tooltip } from '@mui/material';
import { EmptyResultBox } from '../EmptyResultBox';
import Alert from '@mui/material/Alert';

interface DataListProps {
  search: string;
  id?: string;
  data: BindingSet;
  actions?: Action[];
  hiddenColums?: string[];
  hiddenColumsIndex?: number;
  highlightedColumns?: string[];
}

interface Action {
  name: string;
  icon: JSX.Element;
  onClick: (id: string | undefined) => void;
  rowKey: string;
}

export const DataList = ({
  search,
  id,
  data,
  actions,
  hiddenColums,
  hiddenColumsIndex,
  highlightedColumns,
}: DataListProps) => {
  const tableTitle = `Results for ${search}`;

  const resultToColumns = (result: string[]): Array<GridColDef> => {
    let filteredColumns: string[] = result;
    if (hiddenColums || hiddenColumsIndex) {
      filteredColumns = result.filter(
        (item, index) =>
          (hiddenColums && !hiddenColums.includes(item)) ||
          (hiddenColumsIndex && index <= hiddenColumsIndex)
      );
    }

    const columns: Array<GridColDef> = filteredColumns.map((item, index) => ({
      field: item,
      flex: 2,
      renderCell: ({ row }: { row: Entry }) => {
        const rowItem = row[item];
        let val = rowItem ? rowItem.value : '';
        val = val.replace('\\"', '"').replace('\\n', '\n');
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
      <Box
        sx={{
          '& .highlighted': {
            backgroundColor: '#b9d5ff91',
            fontWeight: 'bold',
          },
        }}
      >
        {data.results.bindings.length > 0 ? (
          <Table
            density="compact"
            title={tableTitle}
            rowsCount={data.results.bindings.length}
            columns={resultToColumns(data.head.vars)}
            rows={data.results.bindings}
            getRowId={rowId}
            getCellClassName={(params: GridCellParams<number>) => {
              if (
                highlightedColumns &&
                highlightedColumns.includes(params.field)
              ) {
                return 'highlighted';
              }
              return '';
            }}
          />
        ) : (
          <EmptyResultBox />
        )}
        {data.warnings &&
          data.warnings.map((warning, index) => (
            <Alert key={'alert' + index} severity="warning">
              Source: ({warning['source-tenant']},{warning['source-asset']})
              Target: ({warning['target-tenant']},{warning['target-asset']})
              Problem: {warning.problem}
            </Alert>
          ))}
      </Box>
    </>
  );
};
