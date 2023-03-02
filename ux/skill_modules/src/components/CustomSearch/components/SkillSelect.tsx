import { Autocomplete, TextField } from '@mui/material';
import React, { SyntheticEvent, useContext, useState } from 'react';
import { SearchContext, SearchOptions } from '../SearchContext';
import VoiceInput from './VoiceInput';

const skillOptions = [
  {
    title: 'Trouble Code Search',
    value: 'TroubleCodeSearch',
    regEx: /\b(trouble|code|codes|P074|P067)\b/g,
  },
  {
    title: 'Material Incident Search',
    value: 'MaterialIncidentSearch',
    regEx: /\b(material)\b/g,
  },
  {
    title: 'Remaining Useful Life',
    value: 'Lifetime',
    regEx: /\b(life)\b/g,
  },
];

interface SkillSelectProps {
  onSkillChange: (value: string, options?: SearchOptions) => void;
}

interface SkillOptions {
  title: string;
  value: string;
  regEx: RegExp;
}

export const SkillSelect = ({ onSkillChange }: SkillSelectProps) => {
  const [noResult, setNoResult] = useState<boolean>(false);
  const [skillValue, setSkillValue] = useState<string | null>('');
  const [inputValue, setInputValue] = useState<string>('');
  const context = useContext(SearchContext);
  const { setOptions } = context;

  const onSearchSkill = (value: string) => {
    setNoResult(false);
    const filteredSkills: SkillOptions[] = skillOptions.filter(
      (skill) => hasSkillMatch(skill.regEx, value).length > 0
    );
    const wordMatches: string = filteredSkills
      .map((skill) => hasSkillMatch(skill.regEx, value).join(' '))
      .join(' ');

    if (filteredSkills.length > 0) {
      if (filteredSkills.length == 1) {
        const skill = filteredSkills[0];
        const options: SearchOptions = {
          skill: skill.value,
          values: hasSkillMatch(skill.regEx, value),
        };
        setOptions(options);
        onSkillChange(skill.value, options);
        setSkillValue(skill.title);
        setInputValue(skill.title);
      }
      //here we have more than one skill option -> what should be done here?
      setInputValue(wordMatches);
    } else {
      setNoResult(true);
      onResetSkills();
    }
  };

  const hasSkillMatch = (skillRegex: RegExp, sentence: string): string[] => {
    const matches = sentence.match(skillRegex);
    const keywords = Array.from(new Set(matches)); // remove duplicates

    return keywords;
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
