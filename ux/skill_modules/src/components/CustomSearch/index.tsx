//
// Skill Module
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//

import { Paper } from '@mui/material';
import { BindingSet } from '@catenax-ng/skill-framework/dist/src';
import React, { useState } from 'react';
import { SkillSelect } from './components/SkillSelect';
import TroubleCodeSearch from './TroubleCodeSearch';
import MaterialIncidentSearch from './MaterialIncidentSearch';
import LifetimeSearch from './LifetimeSearch';
import BeerSearch from './BeerSearch';
import {
  SearchContextProps,
  SearchContextProvider,
  SearchOptions,
} from './SearchContext';

export interface CustomSearchProps {
  onSearch: (search: string, key: string, result: BindingSet) => void;
}

export const CustomSearch = ({ onSearch }: CustomSearchProps) => {
  const [selectedSkill, setSelectedSkill] = useState<string | null>('');
  const [options, setOptions] = useState<SearchOptions>({} as SearchOptions);

  const searchContext: SearchContextProps = {
    options: options,
    setOptions: setOptions,
  };

  return (
    <SearchContextProvider value={searchContext}>
      <Paper elevation={3} sx={{ padding: 2, minWidth: 640 }}>
        <SkillSelect onSkillChange={(skill) => setSelectedSkill(skill)} />
        {selectedSkill == 'TroubleCodeSearch' && (
          <TroubleCodeSearch onSearch={onSearch} />
        )}
        {selectedSkill == 'MaterialIncidentSearch' && (
          <MaterialIncidentSearch onSearch={onSearch} />
        )}
        {selectedSkill == 'Lifetime' && <LifetimeSearch onSearch={onSearch} />}
        {selectedSkill == 'BeerSearch' && <BeerSearch onSearch={onSearch} />}
      </Paper>
    </SearchContextProvider>
  );
};
