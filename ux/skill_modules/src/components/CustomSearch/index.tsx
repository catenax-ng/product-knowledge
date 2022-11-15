import {
  Box,
  Paper,
  Chip,
  Select,
  InputLabel,
  MenuItem,
  FormControl,
  Grid,
  SelectChangeEvent,
} from '@mui/material';
import { Button, Input } from 'cx-portal-shared-components';
import { useEffect, useState } from 'react';
import {
  BindingSet,
  getConnectorFactory,
} from '@knowledge-agents-ux/skill_framework/dist/src';
import React from 'react';
import { ChipData, ChipList } from './components/ChipList';
import { SkillSelect } from './components/SkillSelect';

interface CustomSearchProps {
  onSearch: (vin: string, result: BindingSet) => void;
}

export const CustomSearch = ({ onSearch }: CustomSearchProps) => {
  const [selectedSkill, setSelectedSkill] = useState<string>('');
  const [searchVin, setSearchVin] = useState<string>('');
  const [searchVersion, setSearchVersion] = useState<string>('');
  const [keywordInput, setKeywordInput] = useState<string>('');
  const [chipData, setChipData] = useState<ChipData[]>([]);
  const [disableButton, setDisableButton] = useState<boolean>(false);
  const [loading, setLoading] = useState<boolean>(false);

  const onVinSearchChange = (value: string) => {
    setSearchVin(value);
  };

  const onChipDelete = (deleteChip: ChipData) => {
    setChipData((chips) => chips.filter((chip) => chip.key !== deleteChip.key));
  };

  const onKeywordInputChange = (value: string) => {
    if (value.includes(' ')) {
      const newChip = { key: chipData.length, label: value.trim() };
      setChipData((prevState) => [...prevState, newChip]);
      setKeywordInput('');
    } else {
      setKeywordInput(value);
    }
  };
  const hasNoValue = (item: any) => item.length === 0;

  useEffect(() => {
    const isDisabled =
      hasNoValue(selectedSkill) ||
      hasNoValue(searchVin) ||
      hasNoValue(searchVersion) ||
      (hasNoValue(chipData) && hasNoValue(keywordInput));
    setDisableButton(isDisabled);
  }, [selectedSkill, searchVin, chipData, keywordInput, searchVersion]);

  const onButtonClick = () => {
    setLoading(true);
    let queryVars;
    if (hasNoValue(chipData)) {
      queryVars = {
        vin: searchVin,
        problemArea: keywordInput,
        minVersion: searchVersion,
      };
    } else {
      queryVars = chipData.map((keyword) => ({
        vin: searchVin,
        problemArea: keyword.label,
        minVersion: searchVersion,
      }));
    }
    console.log(queryVars);
    const connector = getConnectorFactory().create();
    connector.execute(selectedSkill, queryVars).then((result) => {
      console.log(result);
      onSearch(searchVin, result);
      setLoading(false);
    });
  };

  return (
    <Paper elevation={3} sx={{ padding: 3 }}>
      <SkillSelect
        value={selectedSkill}
        onChange={(e) => setSelectedSkill(e.target.value)}
        disabled={loading}
      />
      {selectedSkill && (
        <>
          <Grid container spacing={1}>
            <Grid item xs={12} md={10}>
              <Input
                helperText="Please enter a valid VIN."
                value={searchVin}
                onChange={(e) => onVinSearchChange(e.target.value)}
                placeholder="VIN"
                disabled={loading}
              />
            </Grid>
            <Grid item xs={12} md={2}>
              <Input
                value={searchVersion}
                onChange={(e) => setSearchVersion(e.target.value)}
                placeholder="Version"
                type="number"
                disabled={loading}
              />
            </Grid>
          </Grid>
          <Box mt={2} mb={3}>
            <ChipList chipData={chipData} onChipDelete={onChipDelete} />
            <Input
              value={keywordInput}
              onChange={(e) => onKeywordInputChange(e.target.value)}
              placeholder="Enter a key word"
              disabled={loading}
            />
          </Box>
          <Button
            disabled={disableButton || loading}
            fullWidth
            onClick={onButtonClick}
          >
            Search Data
          </Button>
        </>
      )}
    </Paper>
  );
};
