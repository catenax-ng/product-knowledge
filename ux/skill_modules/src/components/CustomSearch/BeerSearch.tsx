//
// Skill Module
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//

import { Box, TextField } from '@mui/material';
import { Button } from 'cx-portal-shared-components';
import React, { useContext } from 'react';
import { useEffect, useState } from 'react';
import { CustomSearchProps } from '.';
import { getConnectorFactory } from '../..';
import { SearchContext } from './SearchContext';
import TreeSelect from 'mui-tree-select';
import { getParent, Node } from './components/Tree';

const beers = [
  new Node('Ale', null, [
    new Node('Browns', null, [new Node('English'), new Node('American Brown')]),
    new Node('Porters', null, [new Node('Baltic'), new Node('Robust')]),
    new Node('Stouts', null, [
      new Node('Dry'),
      new Node('Sweet'),
      new Node('Oatmeal'),
      new Node('Foreign'),
      new Node('Imperial'),
    ]),
    new Node('Pale Ale', null, [
      new Node('Indian'),
      new Node('American Pale Ale'),
      new Node('Bitters'),
    ]),
    new Node('Belgian', null, [
      new Node('Abbey'),
      new Node('Biere de Garde'),
      new Node('Blonde'),
      new Node('Lambic'),
    ]),
    new Node('Sours', null, [new Node('Wild'), new Node('Berliner Weisse')]),
    new Node('Wheats', null, [
      new Node('Hefeweizen'),
      new Node('Dunkelweizen'),
      new Node('Witbear'),
    ]),
  ]),
  new Node('Lager', null, [
    new Node('Ambers', null, [
      new Node('Vienna'),
      new Node('Marzen'),
      new Node('Rauchbier'),
      new Node('Irish/Scottish'),
    ]),
    new Node('Dark Lager', null, [
      new Node('Schwarzbier'),
      new Node('Münchner Dunkles'),
    ]),
    new Node('Pale Lager', null, [
      new Node('Pilsner'),
      new Node('American Light Lager'),
      new Node('Indian Pale Lager'),
      new Node('Münchner Helles'),
    ]),
    new Node('Bock', null, [
      new Node('Maibock'),
      new Node('Doppelbock'),
      new Node('Hellesbock'),
      new Node('Eisbock'),
    ]),
  ]),
];
const flatBeers = function (node: Node): Node[] {
  if (node.children) {
    const subMaterials = node.children.flatMap((child) => flatBeers(child));
    subMaterials.push(node);
    return subMaterials;
  } else {
    return [node];
  }
};
const allBeers = beers.flatMap(flatBeers);
const getBeerChildren = (node: Node | null) =>
  node === null ? beers : node.children;

export default function BeerSearch({ onSearch }: CustomSearchProps) {
  const [searchBeer, setSearchBeer] = useState<string>('');
  const [disableButton, setDisableButton] = useState<boolean>(false);
  const [loading, setLoading] = useState<boolean>(false);
  const context = useContext(SearchContext);
  const { options } = context;

  const onBeerSearchChange = (value: string) => {
    setSearchBeer(value);
  };

  const hasNoValue = (item: string | undefined) => !item || item.length === 0;

  useEffect(() => {
    const isBeerDisabled = hasNoValue(searchBeer);
    setDisableButton(isBeerDisabled);
  }, [searchBeer]);

  const onHurryClick = () => {
    setLoading(true);
    const connector = getConnectorFactory().create();
    connector.execute('BeerSearch', {}).then((result) => {
      onSearch(searchBeer, 'class', result);
      setLoading(false);
    });
  };

  const findBeer = function (value: Node | null | undefined) {
    const material = options.values?.material ?? 'unknown';
    return value && value.value == material;
  };

  const findBeers = function () {
    const material = allBeers.find((node) => findBeer(node));
    return material;
  };

  return (
    <>
      <Box mt={2} mb={2}>
        <TreeSelect
          getChildren={getBeerChildren}
          getParent={getParent}
          renderInput={(params) => <TextField {...params} label="Beer" />}
          value={findBeers()}
          onChange={(event, value) =>
            onBeerSearchChange(value ? value.value : '')
          }
          disabled={loading}
        />
      </Box>
      <Button
        disabled={disableButton || loading}
        fullWidth
        onClick={onHurryClick}
      >
        Hurry Up!
      </Button>
    </>
  );
}
