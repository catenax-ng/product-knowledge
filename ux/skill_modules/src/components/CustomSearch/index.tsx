import { Box, Paper, Grid, TextField } from '@mui/material';
import { Button, Input } from 'cx-portal-shared-components';
import { useEffect, useState } from 'react';
import {
  BindingSet,
  getConnectorFactory,
} from '@catenax-ng/skill-framework/dist/src';
import React from 'react';
import { ChipData, ChipList } from './components/ChipList';
import { SkillSelect } from './components/SkillSelect';

import {
  MapContainer,
  TileLayer,
  useMapEvents,
  Marker,
  Rectangle,
  Pane,
  Polyline,
} from 'react-leaflet';
import { LatLngTuple, LatLng } from 'leaflet';
import { Node, getParent } from './components/Tree';
import { TreeSelect } from 'mui-tree-select';

interface CustomSearchProps {
  onSearch: (search: string, key: string, result: BindingSet) => void;
}

const materials = [
  new Node('Metals', null, [
    new Node('Ferrous', null, [
      new Node('Cast Iron'),
      new Node('Steel'),
      new Node('HSS'),
      new Node('Alloy Steel'),
      new Node('Cathode'),
    ]),
    new Node('Non-Ferrous', null, [
      new Node('Brass'),
      new Node('Copper'),
      new Node('Tin'),
      new Node('Aluminium'),
    ]),
  ]),
  new Node('Non-Metals', null, [
    new Node('Plastics'),
    new Node('Glass'),
    new Node('Rubber'),
    new Node('Ceramics'),
    new Node('Wood'),
  ]),
  new Node('Composites', null, [
    new Node('Glass Fiber'),
    new Node('Carbon Fiber'),
    new Node('FRP'),
  ]),
];
const allMaterials = materials.flatMap((parent) => parent.children!);
const getMaterialChildren = (node: Node | null) =>
  node === null ? materials : node.children;

export const CustomSearch = ({ onSearch }: CustomSearchProps) => {
  const [selectedSkill, setSelectedSkill] = useState<string>('');
  const [searchVin, setSearchVin] = useState<string>('');
  const [searchVersion, setSearchVersion] = useState<string>('');
  const [keywordInput, setKeywordInput] = useState<string>('');
  const [chipData, setChipData] = useState<ChipData[]>([]);
  const [disableTroubleButton, setTroubleDisableButton] =
    useState<boolean>(false);
  const [disableMaterialButton, setMaterialDisableButton] =
    useState<boolean>(false);
  const [disableLifetimeButton, setLifetimeDisableButton] =
    useState<boolean>(false);
  const [loading, setLoading] = useState<boolean>(false);
  const [searchMaterial, setSearchMaterial] = useState<string>('');
  const [geoFence, setGeoFence] = useState<number[]>([
    12.75, 74.75, 13.25, 75.25,
  ]);
  const [results, setResults] = useState<LatLngTuple[]>([]);
  const [dragging, setDragging] = useState<boolean>(false);
  const [drag, setDrag] = useState<LatLng>();

  const onVinSearchChange = (value: string) => {
    setSearchVin(value);
  };

  const onMaterialSearchChange = (value: string) => {
    setSearchMaterial(value);
  };

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
  const hasNoValue = (item: any) => item.length === 0;

  useEffect(() => {
    const isDisabled =
      hasNoValue(selectedSkill) ||
      hasNoValue(searchVin) ||
      hasNoValue(searchVersion) ||
      (hasNoValue(chipData) && hasNoValue(keywordInput));
    setTroubleDisableButton(isDisabled);
    const isLifetimeDisabled =
      hasNoValue(selectedSkill) ||
      hasNoValue(searchVin) ||
      (hasNoValue(chipData) && hasNoValue(keywordInput));
    setLifetimeDisableButton(isLifetimeDisabled);
    const isMDisabled =
      hasNoValue(selectedSkill) ||
      hasNoValue(searchMaterial) ||
      hasNoValue(geoFence);
    setMaterialDisableButton(isMDisabled);
  }, [
    selectedSkill,
    searchVin,
    chipData,
    keywordInput,
    searchVersion,
    searchMaterial,
    geoFence,
  ]);

  const onTroubleButtonClick = () => {
    setLoading(true);
    let queryVars;
    if (hasNoValue(chipData)) {
      queryVars = {
        vin: searchVin,
        problemArea: keywordInput,
        minVersion: searchVersion,
      };
    } else {
      queryVars = chipData.map((keyword) => ({
        vin: searchVin,
        problemArea: keyword.label,
        minVersion: searchVersion,
      }));
    }
    console.log(queryVars);
    const connector = getConnectorFactory().create();
    connector.execute(selectedSkill, queryVars).then((result) => {
      console.log(result);
      setResults([]);
      onSearch(searchVin, 'codeNumber', result);
      setLoading(false);
    });
  };

  const onMaterialButtonClick = () => {
    setLoading(true);
    let queryVars;
    queryVars = {
      material: searchMaterial,
      latmin: geoFence[0],
      lonmin: geoFence[1],
      latmax: geoFence[2],
      lonmax: geoFence[3],
    };
    console.log(queryVars);
    const connector = getConnectorFactory().create();
    connector.execute(selectedSkill, queryVars).then((result) => {
      console.log(result);
      const poss: LatLngTuple[] = [];
      result.results.bindings.forEach((row) => {
        if (row.lat != undefined) {
          const pos: LatLngTuple = [
            parseFloat(row.lat.value),
            parseFloat(row.lon.value),
          ];
          poss.push(pos);
        }
        if (row.lat2 != undefined) {
          const pos2: LatLngTuple = [
            parseFloat(row.lat2.value),
            parseFloat(row.lon2.value),
          ];
          poss.push(pos2);
        }
        if (row.lat3 != undefined) {
          const pos3: LatLngTuple = [
            parseFloat(row.lat3.value),
            parseFloat(row.lon3.value),
          ];
          poss.push(pos3);
        }
        if (row.lat4 != undefined) {
          const pos4: LatLngTuple = [
            parseFloat(row.lat4.value),
            parseFloat(row.lon4.value),
          ];
          poss.push(pos4);
        }
        if (row.lat5 != undefined) {
          const pos5: LatLngTuple = [
            parseFloat(row.lat5.value),
            parseFloat(row.lon5.value),
          ];
          poss.push(pos5);
        }
      });
      onSearch(searchMaterial, 'sourcePart', result);
      setResults(poss);
      setLoading(false);
    });
  };

  const onLifetimeButtonClick = () => {
    setLoading(true);
    let queryVars;
    if (hasNoValue(chipData)) {
      queryVars = {
        vin: searchVin,
        troubleCode: keywordInput,
      };
    } else {
      queryVars = chipData.map((keyword) => ({
        vin: searchVin,
        troubleCode: keyword.label,
      }));
    }
    console.log(queryVars);
    const connector = getConnectorFactory().create();
    connector.execute(selectedSkill, queryVars).then((result) => {
      console.log(result);
      setResults([]);
      onSearch(searchVin, 'vin', result);
      setLoading(false);
    });
  };

  const GeoFence = () => {
    const map = useMapEvents({
      mousedown: (e) => {
        setDrag(e.latlng);
      },
      mouseup: (e) => {
        const latdiff = e.latlng.lat - drag!.lat;
        const londiff = e.latlng.lng - drag!.lng;
        setGeoFence([
          geoFence[0] + latdiff,
          geoFence[1] + londiff,
          geoFence[2] + latdiff,
          geoFence[3] + londiff,
        ]);
        setDrag(undefined);
        //let map=useMap();
        const center = map.getCenter();
        map.panTo([center.lat + latdiff, center.lng + londiff]);
      },
    });
    return (
      <Rectangle
        bounds={[
          [geoFence[0], geoFence[1]],
          [geoFence[2], geoFence[3]],
        ]}
      />
    );
  };

  return (
    <Paper elevation={3} sx={{ padding: 3, minWidth: 640 }}>
      <SkillSelect
        value={selectedSkill}
        onChange={(e) => setSelectedSkill(e)}
        disabled={loading}
      />
      {selectedSkill == 'TroubleCodeSearch' && (
        <>
          <Grid container spacing={1}>
            <Grid item xs={12} md={10}>
              <Input
                helperText="Please enter a valid VIN."
                value={searchVin}
                onChange={(e) => onVinSearchChange(e.target.value)}
                placeholder="VIN"
                disabled={loading}
              />
            </Grid>
            <Grid item xs={12} md={2}>
              <Input
                value={searchVersion}
                onChange={(e) => setSearchVersion(e.target.value)}
                placeholder="Version"
                type="number"
                disabled={loading}
              />
            </Grid>
          </Grid>
          <Box mt={2} mb={3}>
            <ChipList chipData={chipData} onChipDelete={onChipDelete} />
            <Input
              value={keywordInput}
              onChange={(e) => onKeywordInputChange(e.target.value)}
              placeholder="Enter a key word"
              disabled={loading}
            />
          </Box>
          <Button
            disabled={disableTroubleButton || loading}
            fullWidth
            onClick={onTroubleButtonClick}
          >
            Search Troublecodes
          </Button>
        </>
      )}
      {selectedSkill == 'MaterialIncidentSearch' && (
        <>
          <Box mt={2} mb={2}>
            <TreeSelect
              getChildren={getMaterialChildren}
              getParent={getParent}
              renderInput={(params) => (
                <TextField {...params} label="Material" />
              )}
              value={allMaterials.find((node) => node.value == searchMaterial)}
              onChange={(event, value, reason, details) =>
                onMaterialSearchChange(value!.value)
              }
              disabled={loading}
            />
          </Box>
          <Box mt={1} mb={3}>
            <MapContainer
              dragging={dragging}
              center={[13, 75]}
              zoom={8}
              scrollWheelZoom={false}
            >
              <TileLayer
                url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
                attribution='&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
              />
              <Pane name="fence" style={{ zIndex: 499 }}>
                <GeoFence />
              </Pane>
              {results.map((tuple, index) => {
                return <Marker key={index.toString()} position={tuple} />;
              })}
              <Polyline positions={results} />
            </MapContainer>
          </Box>
          <Button
            disabled={disableMaterialButton || loading}
            fullWidth
            onClick={onMaterialButtonClick}
          >
            Search Incident Space
          </Button>
        </>
      )}
      {selectedSkill == 'Lifetime' && (
        <>
          <Box mt={2} mb={3}>
            <Input
              helperText="Please enter a valid VIN."
              value={searchVin}
              onChange={(e) => onVinSearchChange(e.target.value)}
              placeholder="VIN"
              disabled={loading}
            />
          </Box>
          <Box mt={2} mb={3}>
            <ChipList chipData={chipData} onChipDelete={onChipDelete} />
            <Input
              value={keywordInput}
              onChange={(e) => onKeywordInputChange(e.target.value)}
              placeholder="Enter Trouble Codes"
              disabled={loading}
            />
          </Box>
          <Button
            disabled={disableLifetimeButton || loading}
            fullWidth
            onClick={onLifetimeButtonClick}
          >
            Perform Prognosis
          </Button>
        </>
      )}
    </Paper>
  );
};
