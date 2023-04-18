import { Box } from '@mui/material';
import { Typography } from 'cx-portal-shared-components';
import React from 'react';
import ErrorTwoToneIcon from '@mui/icons-material/ErrorTwoTone';

export const EmptyResultBox = () => {
  return (
    <Box textAlign="center" maxWidth="500px" ml="auto" mr="auto">
      <ErrorTwoToneIcon color="warning" fontSize="large" />
      <Typography variant="h4">Empty search result</Typography>
      <Typography>
        We could not find any data related to your search request. Please change
        your search input.
      </Typography>
    </Box>
  );
};
