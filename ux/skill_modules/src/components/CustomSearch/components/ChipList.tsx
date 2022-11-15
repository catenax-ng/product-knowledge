import { Box, Chip } from '@mui/material';
import React, { useState } from 'react';

export interface ChipData {
  key: number;
  label: string;
}

interface ChipListProps {
  chipData: ChipData[];
  onChipDelete: (deleteChip: ChipData) => void;
}

export const ChipList = ({ chipData, onChipDelete }: ChipListProps) => {
  return (
    <Box mb={1}>
      {chipData.map((data) => {
        return (
          <Chip
            color="primary"
            key={data.key}
            label={data.label}
            onDelete={() => onChipDelete(data)}
            clickable={true}
            sx={{ mr: 1 }}
          />
        );
      })}
    </Box>
  );
};
