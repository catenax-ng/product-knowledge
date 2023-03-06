import { createContext } from 'react';
import { LatLngTuple } from 'leaflet';

export interface SearchOptions {
  skill: string;
  values?: SearchOptionValues;
  zoom?: number;
}

interface SearchOptionValues {
  vin?: string;
  codes?: string;
  keywords?: string;
  region?: number[];
  center?: LatLngTuple;
  material?: string;
}

export interface SearchContextProps {
  options: SearchOptions;
  setOptions: (options: SearchOptions) => void;
}

export const SearchContext = createContext<SearchContextProps>(
  {} as SearchContextProps
);

export const SearchContextProvider = SearchContext.Provider;
