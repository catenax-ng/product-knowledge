import { CustomSearch, DataList } from "@catenax-ng/skill-modules";
import { Typography } from "cx-portal-shared-components";
import { Grid } from "@mui/material";
import { useState } from "react";
import { BindingSet } from '@knowledge-agents-ux/skill_framework/dist/src'

export default function Search(){
  const [searchResult, setSearchResult] = useState<BindingSet>()
  const [searchVin, setSearchVin] = useState<string>('')

  const onSearch = (vin: string, result: BindingSet) => {
    setSearchResult(result);
    setSearchVin(vin);
  }

  return(
    <>
      <Typography
        sx={{ mt: 3, mb: 3, fontFamily: 'LibreFranklin-Light', textAlign: 'center' }}
        variant="h4"
        className="section-title"
      >
        Execute Skills
      </Typography>
      <Grid container justifyContent="center"spacing={3}>
        <Grid item xs={5}>
          <CustomSearch onSearch={onSearch} />
        </Grid>
        {searchResult &&
          <Grid item xs={12}>
            <DataList vin={searchVin} data={searchResult} />
          </Grid>
        }
      </Grid>
    </>
  )
}