//
// Skill Module
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//

import { createContext } from 'react';
import { LatLngTuple } from 'leaflet';

export interface SearchOptions {
  skill: string;
  values?: SearchOptionValues;
}

interface SearchOptionValues {
  vin?: string;
  codes?: string;
  keywords?: string;
  region?: number[];
  center?: LatLngTuple;
  material?: string;
  zoom?: number;
}

export interface SearchContextProps {
  options: SearchOptions;
  setOptions: (options: SearchOptions) => void;
}

export const SearchContext = createContext<SearchContextProps>(
  {} as SearchContextProps
);

export const SearchContextProvider = SearchContext.Provider;
