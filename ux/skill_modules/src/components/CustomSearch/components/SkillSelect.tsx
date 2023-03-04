import { Autocomplete, TextField } from '@mui/material';
import React, { SyntheticEvent, useContext, useState } from 'react';
import { SearchContext, SearchOptions } from '../SearchContext';
import VoiceInput from './VoiceInput';
import { LatLng, LatLngTuple } from 'leaflet';

const skillOptions = [
  {
    title: 'Trouble Code Search',
    value: 'TroubleCodeSearch',
    regEx: /\b(gearbox)\b/g,
  },
  {
    title: 'Material Incident Search',
    value: 'MaterialIncidentSearch',
    regEx: /[wW]hich products are affected by (?<material>.+) material produced in (?<region>.+)/gm,
  },
  {
    title: 'Remaining Useful Life',
    value: 'Lifetime',
    regEx:
      /[hH]ow (long|for) .* drive (?<vehicle>.+) when trouble codes? (?<trouble>[pP][0-9]{4})(?:(?:,| and) (?<trouble2>[pP][0-9]{4}))* occur.*/gm,
  },
];

interface SkillSelectProps {
  onSkillChange: (value: string, options?: SearchOptions) => void;
}

interface SkillOptions {
  title: string;
  value: string;
  regEx: RegExp;
  regExResult?: RegExpExecArray;
}

export const SkillSelect = ({ onSkillChange }: SkillSelectProps) => {
  const [noResult, setNoResult] = useState<boolean>(false);
  const [skillValue, setSkillValue] = useState<string | null>('');
  const [inputValue, setInputValue] = useState<string>('');
  const context = useContext(SearchContext);
  const { setOptions } = context;

  const onSearchSkill = (value: string) => {
    setNoResult(false);
    //add regEx result to skill and filter for existing matches
    const filteredSkills: SkillOptions[] = skillOptions
      .map((skill) => ({
        ...skill,
        regExResult: hasSkillMatch(skill.regEx, value),
      }))
      .filter((skill) => skill.regExResult.length > 0);

    if (filteredSkills.length > 0) {
      if (filteredSkills.length == 1) {
        const skill = filteredSkills[0];
        const options: SearchOptions = {
          skill: skill.value,
          values: getOptionValues(skill),
        };
        setOptions(options);
        onSkillChange(skill.value, options);
        setSkillValue(skill.title);
        setInputValue(skill.title);
      }
      //here we have more than one skill option -> what should be done here?
    } else {
      setNoResult(true);
      onResetSkills();
    }
  };

  const hasSkillMatch = (
    skillRegex: RegExp,
    sentence: string
  ): RegExpExecArray => {
    const match = skillRegex.exec(sentence);
    return match ? match : ({} as RegExpExecArray);
  };

  const getOptionValues = (skill: SkillOptions) => {
    if (!skill.regExResult) return undefined;
    if (skill.value === 'Lifetime') {
      const codes: string[] = [];
      if (skill.regExResult.groups) {
        Object.entries(skill.regExResult.groups).forEach(([key, value]) => {
          if (key.includes('trouble')) codes.push(value);
        });
      }
      return {
        vin: skill.regExResult.groups?.vehicle ? 'WBAAL31029PZ00001' : '',
        codes: codes.join(' '),
      };
    } 
    if (skill.value === 'MaterialIncidentSearch') {
      var searchMaterial = skill.regExResult.groups!.material;
      const arr = searchMaterial.split(" ");
      for (var i = 0; i < arr?.length; i++) {
        arr[i] = arr[i].charAt(0).toUpperCase() + arr[i].slice(1);
      }
      searchMaterial = arr.join(" ");
      var searchRegion:[number,number,number,number] = [0,0,0,0];
      var searchCenter:LatLngTuple = [0,0];
      if(skill.regExResult.groups!.region.includes("southern")) {
        searchRegion=[
            7.5, 98, 8, 98.5,
        ];
        searchCenter=[7.75,98.25];
      } else if(skill.regExResult.groups!.region.includes("east")) {
        searchRegion=[
            12.75, 74.75, 13.25, 75.25,
        ];
         searchCenter=[13,75];
      }
      return {
        material: searchMaterial,
        region: searchRegion,
        center: searchCenter
      };
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
