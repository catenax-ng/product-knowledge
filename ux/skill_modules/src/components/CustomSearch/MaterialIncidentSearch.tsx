//
// Skill Module
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//

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
const flatMaterials = function (node: Node): Node[] {
  if (node.children) {
    const subMaterials = node.children.flatMap((child) => flatMaterials(child));
    subMaterials.push(node);
    return subMaterials;
  } else {
    return [node];
  }
};
const allMaterials = materials.flatMap(flatMaterials);
const getMaterialChildren = (node: Node | null) =>
  node === null ? materials : node.children;

export default function MaterialIncidentSearch({
  onSearch,
}: CustomSearchProps) {
  const context = useContext(SearchContext);
  const { options, setOptions } = context;
  const [results, setResults] = useState<LatLngTuple[][]>([]);
  const [dragging, setDragging] = useState<boolean>(false);
  const [disabledButton, setDisabledButton] = useState<boolean>(true);
  const [loading, setLoading] = useState<boolean>(false);
  const colors = ['blue', 'green', 'red', 'yellow'];

  const hasNoValue = (item: string | number[] | undefined) =>
    !item || item.length === 0;

  useEffect(() => {
    const isDisabled =
      hasNoValue(options.values?.material) ||
      hasNoValue(options.values?.region);
    setDisabledButton(isDisabled);
  }, [options]);

  const onMaterialButtonClick = () => {
    setLoading(true);
    setDragging(false);
    const searchMaterial = options.values?.material ?? 'unknown';
    const queryVars = {
      material: searchMaterial,
      latmin: options.values!.region![0],
      lonmin: options.values!.region![1],
      latmax: options.values!.region![2],
      lonmax: options.values!.region![3],
    };
    const connector = getConnectorFactory().create();
    connector.execute('MaterialIncidentSearch', queryVars).then((result) => {
      const poss: LatLngTuple[][] = [];
      let coss: LatLngTuple | undefined;
      result.results.bindings.forEach((row) => {
        const posss: LatLngTuple[] = [];
        poss.push(posss);
        if (row.lat && row.lon) {
          const pos: LatLngTuple = [
            parseFloat(row.lat.value),
            parseFloat(row.lon.value),
          ];
          if (!coss) {
            coss = pos;
          } else {
            coss = [
              pos[0] + (coss[0] - pos[0]) / 2,
              pos[1] + (coss[1] - pos[1]) / 2,
            ];
          }
          posss.push(pos);
        }
        if (row.lat2 && row.lon2) {
          const pos2: LatLngTuple = [
            parseFloat(row.lat2.value),
            parseFloat(row.lon2.value),
          ];
          coss = [
            pos2[0] + (coss![0] - pos2[0]) / 2,
            pos2[1] + (coss![1] - pos2[1]) / 2,
          ];
          posss.push(pos2);
        }
        if (row.lat3 && row.lon3) {
          const pos3: LatLngTuple = [
            parseFloat(row.lat3.value),
            parseFloat(row.lon3.value),
          ];
          coss = [
            pos3[0] + (coss![0] - pos3[0]) / 2,
            pos3[1] + (coss![1] - pos3[1]) / 2,
          ];
          posss.push(pos3);
        }
        if (row.lat4 && row.lon4) {
          const pos4: LatLngTuple = [
            parseFloat(row.lat4.value),
            parseFloat(row.lon4.value),
          ];
          coss = [
            pos4[0] + (coss![0] - pos4[0]) / 2,
            pos4[1] + (coss![1] - pos4[1]) / 2,
          ];
          posss.push(pos4);
        }
        if (row.lat5 && row.lon5) {
          const pos5: LatLngTuple = [
            parseFloat(row.lat5.value),
            parseFloat(row.lon5.value),
          ];
          coss = [
            pos5[0] + (coss![0] - pos5[0]) / 2,
            pos5[1] + (coss![1] - pos5[1]) / 2,
          ];
          posss.push(pos5);
        }
      });
      onSearch(searchMaterial, 'sourcePart', result);
      setResults(poss);
      options.values!.zoom = 1;
      if (coss) {
        options.values!.center = coss;
      }
      setOptions(options);
      setLoading(false);
    });
  };

  const GeoFence = () => {
    const context = useContext(SearchContext);
    const { options, setOptions } = context;
    const [drag, setDrag] = useState<LatLng>();

    const map = useMapEvents({
      mousedown: (e) => {
        setDrag(e.latlng);
      },
      mouseup: (e) => {
        if (drag) {
          const latdiff = e.latlng.lat - drag.lat;
          const londiff = e.latlng.lng - drag.lng;
          options.values!.region = [
            options.values!.region![0] + latdiff,
            options.values!.region![1] + londiff,
            options.values!.region![2] + latdiff,
            options.values!.region![3] + londiff,
          ];
          options.values!.center = [
            options.values!.center![0] + latdiff,
            options.values!.center![1] + londiff,
          ];
          setOptions(options);
          setDrag(undefined);
        }
      },
    });

    useEffect(() => {
      map.flyTo(options.values!.center!, options.values!.zoom!, {
        duration: 2,
      });
    }, [options]);

    return (
      <Rectangle
        bounds={[
          [options.values!.region![0], options.values!.region![1]],
          [options.values!.region![2], options.values!.region![3]],
        ]}
      />
    );
  };

  const findMaterial = function (value: Node | null | undefined) {
    const material = options.values?.material ?? 'unknown';
    return value && value.value == material;
  };

  const findMaterials = function () {
    const material = allMaterials.find((node) => findMaterial(node));
    return material;
  };

  const onMaterialSearchChange = (value: string) => {
    setOptions({ ...options, values: { material: value } });
  };

  return (
    <>
      <Box mt={2} mb={2}>
        <TreeSelect
          getChildren={getMaterialChildren}
          getParent={getParent}
          renderInput={(params) => <TextField {...params} label="Material" />}
          value={findMaterials()}
          onChange={(event, value) =>
            onMaterialSearchChange(value ? value.value : '')
          }
          disabled={loading}
        />
      </Box>
      <Box mt={1} mb={3}>
        <MapContainer
          dragging={dragging}
          center={options.values!.center!}
          zoom={options.values!.zoom!}
          scrollWheelZoom={false}
        >
          <TileLayer
            url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
            attribution='&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
          />
          <Pane name="fence" style={{ zIndex: 499 }}>
            <GeoFence />
          </Pane>
          {results.flatMap((result, rindex) => {
            return result.map((tuple, index) => {
              return (
                <Marker
                  key={rindex.toString() + '#' + index.toString()}
                  position={tuple}
                />
              );
            });
          })}
          {results.flatMap((result, index) => {
            return <Polyline positions={result} color={colors[index]} />;
          })}
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
