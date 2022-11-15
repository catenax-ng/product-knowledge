import AssetList from './AssetList';
import React from 'react';
import './styles.sass';
import { Box, Grid, Paper } from '@mui/material';
import Typography from '@mui/material/Typography';

export const AssetView = () => {
  return (
    <Box p={4}>
      <Grid container spacing={4}>
        <Grid item xs={12}>
          <Paper>
            <Typography p={2} variant="h4">
              Asset List
            </Typography>
            <AssetList />
          </Paper>
        </Grid>
      </Grid>
    </Box>
  );
};
