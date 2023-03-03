import { createContext } from 'react';

export interface SearchOptions {
  skill: string;
  values?: SearchOptionValues;
}

interface SearchOptionValues {
  vin?: string;
  codes?: string;
  keywords?: string;
}

export interface SearchContextProps {
  options: SearchOptions;
  setOptions: (options: SearchOptions) => void;
}

export const SearchContext = createContext<SearchContextProps>(
  {} as SearchContextProps
);

export const SearchContextProvider = SearchContext.Provider;
