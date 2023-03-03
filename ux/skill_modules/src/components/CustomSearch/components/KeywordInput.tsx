import { Box } from '@mui/material';
import { Input } from 'cx-portal-shared-components';
import React, { useEffect, useState } from 'react';
import { ChipData, ChipList } from './ChipList';

interface KeywordInputProps {
  onChange: (value: string) => void;
  placeholder: string;
  disabled: boolean;
  onChipChange: (value: ChipData[]) => void;
  input: string;
}
export default function KeywordInput({
  onChange,
  placeholder,
  disabled,
  onChipChange,
  input,
}: KeywordInputProps) {
  const [chipData, setChipData] = useState<ChipData[]>([]);
  const [keywordInput, setKeywordInput] = useState<string>('');

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

  useEffect(() => {
    onChange(keywordInput);
  }, [keywordInput]);

  useEffect(() => {
    if (input) {
      if (input.includes(' ')) {
        setChipData(input.split(' ').map((val, i) => ({ key: i, label: val })));
      } else {
        onKeywordInputChange(input);
      }
    }
  }, [input]);

  useEffect(() => {
    onChipChange(chipData);
  }, [chipData]);

  return (
    <Box mt={2} mb={3}>
      <ChipList chipData={chipData} onChipDelete={onChipDelete} />
      <Input
        value={keywordInput}
        onChange={(e) => onKeywordInputChange(e.target.value)}
        placeholder={placeholder}
        disabled={disabled}
      />
    </Box>
  );
}
