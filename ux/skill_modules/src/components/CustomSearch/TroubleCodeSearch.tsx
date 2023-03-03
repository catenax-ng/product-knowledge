import { Grid } from '@mui/material';
import { Input, Button } from 'cx-portal-shared-components';
import React, { useContext, useEffect, useState } from 'react';
import { CustomSearchProps } from '.';
import { getConnectorFactory } from '../..';
import { ChipData } from './components/ChipList';
import KeywordInput from './components/KeywordInput';
import VinInput from './components/VinInput';
import { SearchContext } from './SearchContext';

export default function TroubleCodeSearch({ onSearch }: CustomSearchProps) {
  const [searchVin, setSearchVin] = useState<string>('');
  const [searchVersion, setSearchVersion] = useState<string>('');
  const [keywordInput, setKeywordInput] = useState<string>('');
  const [chipData, setChipData] = useState<ChipData[]>([]);
  const [loading, setLoading] = useState<boolean>(false);
  const [disabledButton, setDisabledButton] = useState<boolean>(true);
  const context = useContext(SearchContext);
  const { options } = context;

  const onVinSearchChange = (value: string) => {
    setSearchVin(value);
  };

  const hasNoValue = (item: string | ChipData[]) => item.length === 0;

  useEffect(() => {
    const isDisabled =
      hasNoValue(searchVin) ||
      hasNoValue(searchVersion) ||
      (hasNoValue(chipData) && hasNoValue(keywordInput));
    setDisabledButton(isDisabled);
  }, [searchVin, chipData, keywordInput, searchVersion]);

  useEffect(() => {
    if (!options.values) return;
    if (options.skill === 'TroubleCodeSearch') {
      if (options.values.vin) setSearchVin(options.values.vin);
      setSearchVersion('1');
      if (options.values.keywords) setKeywordInput(options.values.keywords);
    }
  }, [options]);

  const onTroubleButtonClick = () => {
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
    const connector = getConnectorFactory().create();
    connector.execute('TroubleCodeSearch', queryVars).then((result) => {
      onSearch(searchVin, 'codeNumber', result);
      setLoading(false);
    });
  };

  return (
    <>
      <Grid container spacing={1} sx={{ mt: 2 }}>
        <Grid item xs={12} md={10}>
          <VinInput
            value={searchVin}
            onChange={(e) => onVinSearchChange(e.target.value)}
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
      <KeywordInput
        onChange={setKeywordInput}
        placeholder="Enter a key word"
        disabled={loading}
        onChipChange={setChipData}
        input={keywordInput}
      />
      <Button
        disabled={disabledButton || loading}
        fullWidth
        onClick={onTroubleButtonClick}
      >
        Search Troublecodes
      </Button>
    </>
  );
}
