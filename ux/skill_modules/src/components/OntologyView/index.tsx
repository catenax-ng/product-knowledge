import React, { useEffect, useState } from "react";
import { Box, FormControl, InputLabel, MenuItem, Select, SelectChangeEvent, Typography } from '@mui/material';
import CytoscapeComponent from "react-cytoscapejs";
import { Layouts } from "./Layouts";
import setupCy from "./setupCy";
setupCy();

export const OntologyView = () => {
  const cyRef = React.useRef<cytoscape.Core | undefined>();
  const [width, setWith] = useState('100%');
  const [height, setHeight] = useState('100%');
  const [graphData, setGraphData] = useState({nodes: [], edges: []});
  const [layout, setLayout] = useState(Layouts.circle);
  const primary = '#ffa600'
  const secondary = '#b3cb2d'
  const cxCategory = '#D91E18'

  useEffect(() => {
    fetch('https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/infrastructure/consumer/resources/cx-ontology.json')
      .then((response) => response.json())
      .then((responseJson) => {
        setGraphData(responseJson);

      })
  }, [])

  const styleSheet = [
    {
      selector: "node",
      style: {
        backgroundColor: primary,
        width: 30,
        height: 30,
        label: "data(label)",

        // "width": "mapData(score, 0, 0.006769776522008331, 20, 60)",
        // "height": "mapData(score, 0, 0.006769776522008331, 20, 60)",
        // "text-valign": "center",
        // "text-halign": "center",
        overlayPadding: "6px",
        zIndex: "10",
        //text props
        color: primary,
        fontSize: 20,
        transition: "width 2s, height 2s"
      }
    },
    {
      selector: "node:selected",
      style: {
        borderWidth: "2px",
        borderColor: primary,
        backgroundColor: secondary,
        width: 40,
        height: 40,
        //text props
        color: secondary,
        transition: "width 2s, height 2s"
      }
    },
    {
      selector: "node[category='https://github.com/catenax-ng/product-knowledge/ontology/cx.ttl']",
      style: {
        backgroundColor: cxCategory,
        color: cxCategory,
        shape: "rectangle"
      }
    },
    {
      selector: "edge",
      style: {
        width: 3,
        lineColor: '#eee',
        targetArrowColor: '#ddd',
        targetArrowShape: "triangle",
        curveStyle: "bezier"
      }
    }
  ];

  let myCyRef;

  const onSelectChange = (e: SelectChangeEvent) => {
    console.log(e.target.value)
    setLayout({ ...Layouts[e.target.value] });
  }

  return (
    <>
      <Box p={4}>
        <Typography p={2} variant='h4'>Welcome to the Ontology view</Typography>
        <FormControl>
          <InputLabel id="select-layout-label">Layout</InputLabel>
          <Select
            labelId="select-layout-label"
            id="select-layout"
            value={layout.name}
            label="Layout"
            onChange={onSelectChange}
            sx={{minWidth: '150px'}}
          >
            {Object.keys(Layouts).map((l) => (
              <MenuItem
                key={`select-layout_${l}`}
                value={l}
              >
                {Layouts[l].label}
              </MenuItem>
              ))}
          </Select>
        </FormControl>
        <Box
          style={{
            border: `1px solid #ccc`,
            marginTop: 2
          }}
        >
          {graphData.nodes.length > 0 &&
            <CytoscapeComponent
              elements={CytoscapeComponent.normalizeElements(graphData)}
              // pan={{ x: 200, y: 200 }}
              style={{ width: width, height: height, minHeight: '500px' }}
              zoomingEnabled={true}
              maxZoom={3}
              minZoom={0.1}
              autounselectify={false}
              boxSelectionEnabled={true}
              layout={layout}
              stylesheet={styleSheet}
              cy={(cy) => {
                myCyRef = cy;

                console.log('EVT', cy);

                cy.on('tap', 'node', (evt) => {
                  var node = evt.target;
                  console.log('EVT', evt);
                  console.log('TARGET', node.data());
                  console.log('TARGET TYPE', typeof node[0]);
                });
              }}
            />
          }
        </Box>
      </Box>
    </>
  );
};