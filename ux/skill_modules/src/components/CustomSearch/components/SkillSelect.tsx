//
// Skill Module
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//

import { Autocomplete, TextField } from '@mui/material';
import React, { SyntheticEvent, useContext, useState } from 'react';
import { SearchContext, SearchOptions } from '../SearchContext';
import VoiceInput from './VoiceInput';
import { LatLngTuple } from 'leaflet';

const skillOptions = [
  {
    title: 'Trouble Code Search',
    value: 'TroubleCodeSearch',
    regEx: /\b(gearbox)\b/g,
  },
  {
    title: 'Material Incident Search',
    value: 'MaterialIncidentSearch',
    regEx:
      /[wW]hich products are affected by (?<material>.+) produced in (?<region>.+)/gm,
  },
  {
    title: 'Remaining Useful Life',
    value: 'Lifetime',
    regEx:
      /[hH]ow (long|far) .* drive (?<vehicle>.+) when trouble codes? (?<trouble>[pP][0-9]{4})(?:(?:,| and) (?<trouble2>[pP][0-9]{4}))* (occur|appear).*/gm,
  },
  {
    title: 'Beer Search',
    value: 'BeerSearch',
    regEx: /[bB]ring me (a|some) beer.*/gm,
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

  const selectSkill = function (value: string) {
    const selectedSkill = skillOptions.find((skill) => skill.value == value);
    selectSkillOptions(selectedSkill);
  };

  const selectSkillOptions = function (
    selectedSkill: SkillOptions | undefined
  ) {
    if (selectedSkill) {
      const options: SearchOptions = {
        skill: selectedSkill!.value,
        values: getOptionValues(selectedSkill!),
      };
      setOptions(options);
      onSkillChange(selectedSkill!.value, options);
      setSkillValue(selectedSkill!.title);
      setInputValue(selectedSkill!.title);
    }
  };

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
        selectSkillOptions(filteredSkills[0]);
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
    const match = new RegExp(skillRegex).exec(sentence);
    return match ? match : ({} as RegExpExecArray);
  };

  const getOptionValues = (skill: SkillOptions) => {
    if (skill.value === 'Lifetime') {
      const codes: string[] = [];
      if (skill.regExResult && skill.regExResult.groups) {
        Object.entries(skill.regExResult.groups).forEach(([key, value]) => {
          if (key.includes('trouble'))
            codes.push(value.charAt(0).toUpperCase() + value.slice(1));
        });
      }
      return {
        vin: skill.regExResult?.groups?.vehicle ? 'WBAAL31029PZ00001' : '',
        codes: codes.join(' '),
      };
    }
    if (skill.value === 'MaterialIncidentSearch') {
      let searchMaterial = skill.regExResult?.groups?.material;
      if (searchMaterial) {
        searchMaterial = searchMaterial.replace(' material', '');
        searchMaterial = searchMaterial.replace(' Material', '');
        let arr = searchMaterial.split(' ');
        arr = arr.map((noun) => noun.charAt(0).toUpperCase() + noun.slice(1));
        searchMaterial = arr.join(' ');
      } else {
        searchMaterial = '';
      }
      let searchRegion: [number, number, number, number] = [0, 0, 0, 0];
      let searchCenter: LatLngTuple = [0, 0];
      if (
        skill.regExResult?.groups &&
        (skill.regExResult.groups.region.includes('southern') ||
          skill.regExResult.groups.region.includes('Southern'))
      ) {
        searchRegion = [7.5, 98, 8, 98.5];
        searchCenter = [7.75, 98.25];
      } else if (
        skill.regExResult?.groups &&
        (skill.regExResult.groups.region.includes('east') ||
          skill.regExResult.groups.region.includes('East'))
      ) {
        searchRegion = [12.75, 74.75, 13.25, 75.25];
        searchCenter = [13, 75];
      } else {
        searchRegion = [49.75, 8.5, 50.25, 9];
        searchCenter = [50.08184, 8.63552];
      }
      return {
        material: searchMaterial,
        region: searchRegion,
        center: searchCenter,
        zoom: 8,
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
        selectSkill(value);
      } else {
        selectSkill(value.value);
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
