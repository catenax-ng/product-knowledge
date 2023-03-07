//
// Skill Module
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//

import { CustomSearch, DataList } from '@catenax-ng/skill-modules';
import { Typography } from 'cx-portal-shared-components';
import { Grid } from '@mui/material';
import { useState } from 'react';
import { BindingSet } from '@catenax-ng/skill-framework/dist/src';
import '@catenax-ng/skill-modules/dist/styles/leaflet.css'

export default function Search() {
  const [searchResult, setSearchResult] = useState<BindingSet>();
  const [search, setSearch] = useState<string>('');
  const [searchKey, setSearchKey] = useState<string>('');
  const highlightedColumns = ['kmLeft', 'daysLeft', 'product', 'productName', 'vendor']

  const onSearch = (search: string, id: string, result: BindingSet) => {
    setSearch(search);
    setSearchKey(id);
    setSearchResult(result);
  };

  return (
    <>
      <Typography
        sx={{
          mt: 3,
          mb: 3,
          fontFamily: 'LibreFranklin-Light',
          textAlign: 'center',
        }}
        variant="h4"
        className="section-title"
      >
        Perform Skill-Based Search
      </Typography>
      <Grid container justifyContent="center" spacing={3}>
        <Grid item xs={8}>
          <CustomSearch onSearch={onSearch} />
        </Grid>
        {searchResult && (
          <Grid item xs={12}>
            <DataList search={search} id={searchKey} data={searchResult} hiddenColumsIndex={5} highlightedColumns={highlightedColumns} />
          </Grid>
        )}
      </Grid>
    </>
  );
}
