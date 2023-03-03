import { Box } from '@mui/material';
import { Button } from 'cx-portal-shared-components';
import React, { useContext } from 'react';
import { useEffect, useState } from 'react';
import { CustomSearchProps } from '.';
import { getConnectorFactory } from '../..';
import { ChipData } from './components/ChipList';
import KeywordInput from './components/KeywordInput';
import VinInput from './components/VinInput';
import { SearchContext } from './SearchContext';

export default function LifetimeSearch({ onSearch }: CustomSearchProps) {
  const [searchVin, setSearchVin] = useState<string>('');
  const [keywordInput, setKeywordInput] = useState<string>('');
  const [chipData, setChipData] = useState<ChipData[]>([]);
  const [disableButton, setDisableButton] = useState<boolean>(false);
  const [loading, setLoading] = useState<boolean>(false);
  const context = useContext(SearchContext);
  const { options } = context;

  const onVinSearchChange = (value: string) => {
    setSearchVin(value);
  };

  const hasNoValue = (item: string | ChipData[]) => item.length === 0;

  useEffect(() => {
    const isLifetimeDisabled =
      hasNoValue(searchVin) ||
      (hasNoValue(chipData) && hasNoValue(keywordInput));
    setDisableButton(isLifetimeDisabled);
  }, [searchVin, chipData, keywordInput]);

  const onLifetimeButtonClick = () => {
    setLoading(true);
    let queryVars;
    if (hasNoValue(chipData)) {
      queryVars = {
        vin: searchVin,
        troubleCode: keywordInput,
      };
    } else {
      queryVars = chipData.map((keyword) => ({
        vin: searchVin,
        troubleCode: keyword.label,
      }));
    }
    const connector = getConnectorFactory().create();
    connector.execute('Lifetime', queryVars).then((result) => {
      onSearch(searchVin, 'vin', result);
      setLoading(false);
    });
  };

  useEffect(() => {
    if (options.values === undefined) return;
    if (options.skill === 'Lifetime') {
      if (options.values.vin) setSearchVin(options.values.vin);
      if (options.values.codes) setKeywordInput(options.values.codes);
    }
  }, [options]);

  return (
    <>
      <Box mt={2} mb={3}>
        <VinInput
          value={searchVin}
          onChange={(e) => onVinSearchChange(e.target.value)}
          disabled={loading}
        />
      </Box>
      <KeywordInput
        onChange={setKeywordInput}
        placeholder="Enter Trouble Codes"
        disabled={loading}
        onChipChange={setChipData}
        input={keywordInput}
      />
      <Button
        disabled={disableButton || loading}
        fullWidth
        onClick={onLifetimeButtonClick}
      >
        Perform Prognosis
      </Button>
    </>
  );
}
