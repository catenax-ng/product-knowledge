import { Box, TextField } from '@mui/material';
import { Button } from 'cx-portal-shared-components';
import {
  MapContainer,
  TileLayer,
  useMapEvents,
  Marker,
  Rectangle,
  Pane,
  Polyline,
} from 'react-leaflet';
import TreeSelect from 'mui-tree-select';
import React, { useContext, useEffect, useState } from 'react';
import { getConnectorFactory } from '../..';
import { getParent, Node } from './components/Tree';
import { LatLng, LatLngTuple } from 'leaflet';
import { CustomSearchProps } from '.';
import { SearchContext } from './SearchContext';

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
    new Node('Rubber', null, [
        new Node('Natural Rubber'),
        new Node('Synthetic Rubber'),
    ]),
    new Node('Ceramics'),
    new Node('Wood'),
  ]),
  new Node('Composites', null, [
    new Node('Glass Fiber'),
    new Node('Carbon Fiber'),
    new Node('FRP'),
  ]),
];
const allMaterials = materials.flatMap((parent) => parent.children);
const getMaterialChildren = (node: Node | null) =>
  node === null ? materials : node.children;

export default function MaterialIncidentSearch({
  onSearch,
}: CustomSearchProps) {
  const context = useContext(SearchContext);
  const { options } = context;
  const [searchMaterial, setSearchMaterial] = useState<string>(options.values?.material ?? '' );
  const [geoFence, setGeoFence] = useState<number[]>(options.values?.region ?? [
    12.75, 74.75, 13.25, 75.25,
  ]);
  const [ mapZoom, setMapZoom] = useState<number>(8);
  const [ mapCenter, setMapCenter] = useState<LatLngTuple>(options.values?.center ?? [13,75]);
  const [results, setResults] = useState<LatLngTuple[][]>([]);
  const [dragging, setDragging] = useState<boolean>(false);
  const [drag, setDrag] = useState<LatLng>();
  const [disabledButton, setDisabledButton] = useState<boolean>(true);
  const [loading, setLoading] = useState<boolean>(false);
  const colors = [ 'blue', 'green', 'red', 'yellow'];

  const onMaterialSearchChange = (value: string) => {
    setSearchMaterial(value);
  };

  const hasNoValue = (item: string | number[]) => item.length === 0;

  useEffect(() => {
    const isDisabled = hasNoValue(searchMaterial) || hasNoValue(geoFence);
    setDisabledButton(isDisabled);
  }, [searchMaterial, geoFence]);

  const onMaterialButtonClick = () => {
    setLoading(true);
    setDragging(false);
    const queryVars = {
      material: searchMaterial,
      latmin: geoFence[0],
      lonmin: geoFence[1],
      latmax: geoFence[2],
      lonmax: geoFence[3],
    };
    const connector = getConnectorFactory().create();
    connector.execute('MaterialIncidentSearch', queryVars).then((result) => {
      const poss: LatLngTuple[][] = [];
      result.results.bindings.forEach((row) => {
        const posss: LatLngTuple[] = [];
        poss.push(posss);
        if (row.lat != undefined) {
          const pos: LatLngTuple = [
            parseFloat(row.lat.value),
            parseFloat(row.lon!.value),
          ];
          posss.push(pos);
        }
        if (row.lat2 != undefined) {
          const pos2: LatLngTuple = [
            parseFloat(row.lat2.value),
            parseFloat(row.lon2!.value),
          ];
          posss.push(pos2);
        }
        if (row.lat3 != undefined) {
          const pos3: LatLngTuple = [
            parseFloat(row.lat3.value),
            parseFloat(row.lon3!.value),
          ];
          posss.push(pos3);
        }
        if (row.lat4 != undefined) {
          const pos4: LatLngTuple = [
            parseFloat(row.lat4.value),
            parseFloat(row.lon4!.value),
          ];
          posss.push(pos4);
        }
        if (row.lat5 != undefined) {
          const pos5: LatLngTuple = [
            parseFloat(row.lat5.value),
            parseFloat(row.lon5!.value),
          ];
          posss.push(pos5);
        }
      });
      setMapZoom(2);
      onSearch(searchMaterial, 'sourcePart', result);
      setResults(poss);
      setLoading(false);
    });
  };

  useEffect(() => {
    if (options.values === undefined) return;
    if (options.skill === 'MaterialIncidentSearch') {
      if (options.values.region) {
        setGeoFence(options.values.region);
      }
      if (options.values.center) {
        setMapCenter(options.values.center);
      }
      if(options.values.material) {
        setSearchMaterial(options.values.material)
      }
    }
  }, [options]);

  const GeoFence = () => {
    const map = useMapEvents({
      mousedown: (e) => {
        setDrag(e.latlng);
      },
      mouseup: (e) => {
        if (drag) {
          const latdiff = e.latlng.lat - drag.lat;
          const londiff = e.latlng.lng - drag.lng;
          setGeoFence([
            geoFence[0] + latdiff,
            geoFence[1] + londiff,
            geoFence[2] + latdiff,
            geoFence[3] + londiff,
          ]);
          setDrag(undefined);
          const center = map.getCenter();
          map.panTo([center.lat + latdiff, center.lng + londiff]);
        }
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

  const findMaterial = function(value:Node | null | undefined) {
    const material=searchMaterial;
    return value && value.value == material;
  };

  return (
    <>
      <Box mt={2} mb={2}>
        <TreeSelect
          getChildren={getMaterialChildren}
          getParent={getParent}
          renderInput={(params) => <TextField {...params} label="Material" />}
          value={allMaterials.find( node => findMaterial(node))}
          onChange={(event, value) =>
            onMaterialSearchChange(value ? value.value : '')
          }
          disabled={loading}
        />
      </Box>
      <Box mt={1} mb={3}>
        <MapContainer
          dragging={dragging}
          center={mapCenter}
          zoom={mapZoom}
          scrollWheelZoom={false}
        >
          <TileLayer
            url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
            attribution='&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
          />
          <Pane name="fence" style={{ zIndex: 499 }}>
            <GeoFence />
          </Pane>
          {
           results.flatMap((result, rindex) => {
            return result.map((tuple, index) => {
                return <Marker key={rindex.toString()+"#"+index.toString()} position={tuple} />;
            });
           })
          }
          {
            results.flatMap((result,index) => {
             return <Polyline positions={result} color={colors[index]} />
            })
          }
        </MapContainer>
      </Box>
      <Button
        disabled={disabledButton || loading}
        fullWidth
        onClick={onMaterialButtonClick}
      >
        Search Incident Space
      </Button>
    </>
  );
}
