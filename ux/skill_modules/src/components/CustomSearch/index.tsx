import { Box, Paper, Grid } from '@mui/material';
import { Button, Input } from 'cx-portal-shared-components';
import { useEffect, useState } from 'react';
import {
  BindingSet,
  getConnectorFactory,
} from '@catenax-ng/skill-framework/dist/src';
import React from 'react';
import { ChipData, ChipList } from './components/ChipList';
import { SkillSelect } from './components/SkillSelect';

import { MapContainer, TileLayer, useMapEvents, Marker, Rectangle, Pane } from 'react-leaflet';
import { LatLngTuple, LatLng } from 'leaflet';

interface CustomSearchProps {
  onSearch: (search: string, key:string, result: BindingSet) => void;
}

export const CustomSearch = ({ onSearch }: CustomSearchProps) => {
  const [selectedSkill, setSelectedSkill] = useState<string>('');
  const [searchVin, setSearchVin] = useState<string>('');
  const [searchVersion, setSearchVersion] = useState<string>('');
  const [keywordInput, setKeywordInput] = useState<string>('');
  const [chipData, setChipData] = useState<ChipData[]>([]);
  const [disableTroubleButton, setTroubleDisableButton] = useState<boolean>(false);
  const [disableMaterialButton, setMaterialDisableButton] = useState<boolean>(false);
  const [loading, setLoading] = useState<boolean>(false);
  const [searchMaterial, setSearchMaterial] = useState<string>('');
  const [geoFence, setGeoFence] = useState<number[]>([12.75,74.75,13.25,75.25]);
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
    const isMDisabled =
    hasNoValue(selectedSkill) ||
    hasNoValue(searchMaterial) ||
    hasNoValue(geoFence);
    setMaterialDisableButton(isMDisabled);
  }, [selectedSkill, searchVin, chipData, keywordInput, searchVersion, searchMaterial, geoFence]);

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
        lonmax: geoFence[3]
      };    
    console.log(queryVars);
    const connector = getConnectorFactory().create();
    connector.execute(selectedSkill, queryVars).then((result) => {
      console.log(result);
      let poss:LatLngTuple[]=[];
      result.results.bindings.forEach( row => {
        if(row.lat != undefined) {
          let pos:LatLngTuple = [ parseFloat(row.lat.value), parseFloat(row.lon.value)];
          console.log(pos);
          poss.push(pos);
        }
      });
      onSearch(searchMaterial, 'sourcePart', result);
      setResults(poss);
      setLoading(false);
    });
  };

  const GeoFence = () => {
    const map = useMapEvents( {
      mousedown: (e) => {
        setDrag(e.latlng);
      },
      mouseup: (e) => {
        let latdiff=e.latlng.lat-drag!.lat;
        let londiff=e.latlng.lng-drag!.lng;
        setGeoFence([geoFence[0]+latdiff,geoFence[1]+londiff,geoFence[2]+latdiff,geoFence[3]+londiff]);
        setDrag(undefined);
        //let map=useMap();
        let center=map.getCenter();
        map.panTo([center.lat+latdiff,center.lng+londiff]);
      }
    });
    return (
      <Rectangle bounds={[[geoFence[0], geoFence[1]], [geoFence[2],geoFence[3]]]}/>
    );
  };

  return (
    <Paper elevation={3} sx={{ padding: 3, minWidth:640 }}>
      <SkillSelect
        value={selectedSkill}
        onChange={(e) => setSelectedSkill(e.target.value)}
        disabled={loading}
      />
      {(selectedSkill == "TroubleCodeSearch") && (
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
            Search Data
          </Button>
        </>
      )}
      {(selectedSkill == "MaterialIncidentSearch") && (
        <>
         <Box mt={2} mb={2}>
          <Input
                helperText="Please enter a material description."
                value={searchMaterial}
                onChange={(e) => onMaterialSearchChange(e.target.value)}
                placeholder="Material"
                disabled={loading}
          />
          </Box>
          <Box mt={1} mb={3}>
          <MapContainer dragging={dragging} center={[13, 75]} zoom={8} scrollWheelZoom={false}>
           <TileLayer
             url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
             attribution='&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
            />
            <Pane name="fence" style={{ zIndex: 499 }}>
              <GeoFence/>
            </Pane>
            {results.map(tuple => {
              return (
                <Marker position={tuple}/>
              );
             })}
          </MapContainer>
          </Box>
          <Button
            disabled={disableMaterialButton || loading}
            fullWidth
            onClick={onMaterialButtonClick}
          >
            Search Data
          </Button>
        </>
      )}
    </Paper>
  );
};
