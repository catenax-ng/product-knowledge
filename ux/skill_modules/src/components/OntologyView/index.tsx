import React, { useEffect, useState } from "react";
import { Box, FormControl, InputLabel, MenuItem, Select, SelectChangeEvent, Typography } from '@mui/material';
import CytoscapeComponent from "react-cytoscapejs";
import { Layouts } from "./Layouts";
import setupCy from "./setupCy";
import { GraphObject, NodeData } from "./types";
import { DefaultStyleSheet } from "./DefaultGraphStyles";
import { Stylesheet } from "cytoscape";
setupCy();

export const OntologyView = () => {
  const cyRef = React.useRef<cytoscape.Core | undefined>();
  const [width, setWith] = useState('100%');
  const [height, setHeight] = useState('100%');
  const [graphData, setGraphData] = useState<GraphObject>({nodes: [], edges: []});
  const [layout, setLayout] = useState(Layouts.circle);
  const [activeNode, setActiveNode] = useState<NodeData>();
  const [categories, setCategories] = useState<string[]>([])
  const [stylesheet, setStylesheet] = React.useState<Stylesheet[]>(DefaultStyleSheet);

  useEffect(() => {
    fetch('https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/infrastructure/consumer/resources/cx-ontology.json')
      .then((response) => response.json())
      .then((responseJson: GraphObject) => {
        setGraphData(responseJson);
        const uniqueCategories = responseJson.nodes.map(n => n.data.category).filter((value, index, self) => self.indexOf(value) === index);
        setCategories(uniqueCategories);
      })
  }, [])

  useEffect(() => {
    if(categories.length > 0){
      categories.map((cat, i) => {
        const hslDegree = (360/categories.length) * (i + 1)
        const catStyles = {
          selector: `node[category='${cat}']`,
          style: {
            backgroundColor: `hsl(${hslDegree}, 100%, 50%)`,
            color: `hsl(${hslDegree}, 100%, 50%)`,
            shape: "rectangle"
          }
        };
        setStylesheet(s => [...s, catStyles])
      })
    }
  }, [categories])

  const onSelectChange = (e: SelectChangeEvent) => {
    setLayout({ ...Layouts[e.target.value] });
  }

  return (
    <>
      <Box p={4}>
        <Typography p={2} mb={4} variant='h4'>Welcome to the Ontology view</Typography>
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
          mt={2}
          border="1px solid #ccc"
        >
          {graphData.nodes.length > 0 &&
            <CytoscapeComponent
              elements={CytoscapeComponent.normalizeElements(graphData)}
              style={{ width: width, height: height, minHeight: '500px' }}
              zoomingEnabled={true}
              maxZoom={3}
              minZoom={0.1}
              autounselectify={false}
              boxSelectionEnabled={true}
              layout={layout}
              stylesheet={stylesheet}
              cy={(cy) => {
                cyRef.current = cy;
                cy.on('click', 'node', (evt) => {
                  var node = evt.target;
                  setActiveNode(node.data());
                });
              }}
            />
          }
        </Box>
        {activeNode &&
          <Box>
            <Typography variant="h2">{activeNode.id}</Typography>
          </Box>
        }
      </Box>
    </>
  );
};