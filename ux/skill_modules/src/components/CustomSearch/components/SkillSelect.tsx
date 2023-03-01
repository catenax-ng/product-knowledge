import { Autocomplete, TextField } from '@mui/material';
import React, { SyntheticEvent, useState } from 'react';
import VoiceInput from './VoiceInput';

const skillOptions = [
  { title: 'Trouble Code Search', value: 'TroubleCodeSearch' },
  { title: 'Material Incident Search', value: 'MaterialIncidentSearch' },
  { title: 'Remaining Useful Life', value: 'Lifetime' },
];

interface SkillSelectProps {
  onSkillChange: (value: string) => void;
}

interface SkillOptions {
  title: string;
  value: string;
}

export const SkillSelect = ({ onSkillChange }: SkillSelectProps) => {
  const [noResult, setNoResult] = useState<boolean>(false);
  const [skillValue, setSkillValue] = useState<string | null>('');
  const [inputValue, setInputValue] = useState<string>('');

  const onSearchSkill = (value: string) => {
    setNoResult(false);
    let filteredSkills: SkillOptions[] = [];
    const searchParams = value.split(' ');
    const wordMatches: string[] = [];
    filteredSkills = skillOptions.filter((skill) =>
      searchParams.some((word) => {
        const paramIncluded = skill.value
          .toLowerCase()
          .includes(word.toLowerCase());
        if (paramIncluded && !wordMatches.includes(word))
          wordMatches.push(word);
        return paramIncluded;
      })
    );

    if (filteredSkills.length > 0) {
      if (filteredSkills.length == 1) {
        onSkillChange(filteredSkills[0].value);
        setSkillValue(filteredSkills[0].title);
      }
      setInputValue(wordMatches.join(' '));
    } else {
      setNoResult(true);
      onResetSkills();
    }
  };

  const onResetSkills = () => {
    setSkillValue('');
  };

  const onAutocompleteSkillChange = (
    event: SyntheticEvent<Element, Event>,
    value: string | { title: string; value: string } | null
  ) => {
    if (value) {
      if (typeof value === 'string') {
        setSkillValue(value);
        onSkillChange(value);
      } else {
        setSkillValue(value.title);
        onSkillChange(value.value);
      }
    }
  };

  return (
    <>
      <VoiceInput
        onSearch={onSearchSkill}
        onReset={onResetSkills}
        noResult={noResult}
      />
      <Autocomplete
        id="free-solo-voice-rec"
        value={skillValue}
        onChange={onAutocompleteSkillChange}
        inputValue={inputValue}
        onInputChange={(event, newInputValue) => {
          setInputValue(newInputValue);
        }}
        selectOnFocus
        clearOnBlur
        renderInput={(params) => <TextField {...params} label="Skills" />}
        getOptionLabel={(option) => {
          // Value selected with enter, right from the input
          if (typeof option === 'string') {
            return option;
          }
          // Regular option
          return option.title;
        }}
        renderOption={(props, option) => <li {...props}>{option.title}</li>}
        options={skillOptions}
        freeSolo
      />
    </>
  );
};
