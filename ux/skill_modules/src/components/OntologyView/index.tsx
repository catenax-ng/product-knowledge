import React, { useEffect, useState } from 'react';
import {
  Box,
  FormControl,
  InputLabel,
  MenuItem,
  Select,
  SelectChangeEvent,
  Typography,
} from '@mui/material';
import CytoscapeComponent from 'react-cytoscapejs';
import { Layouts } from './Layouts';
import setupCy from './setupCy';
import { GraphObject, NodeData } from './types';
import { DefaultStyleSheet } from './DefaultGraphStyles';
import { Stylesheet } from 'cytoscape';

setupCy();

interface OntologyViewType {
  dataUrl: string;
}

export const OntologyView = ({ dataUrl }: OntologyViewType) => {
  const cyRef = React.useRef<cytoscape.Core | undefined>();
  const [graphData, setGraphData] = useState<GraphObject>({
    nodes: [],
    edges: [],
  });
  const [layout, setLayout] = useState(Layouts.circle);
  const [activeNode, setActiveNode] = useState<NodeData>();
  const [categories, setCategories] = useState<string[]>([]);
  const [stylesheet, setStylesheet] =
    React.useState<Stylesheet[]>(DefaultStyleSheet);

  useEffect(() => {
    fetch(dataUrl)
      .then((response) => response.json())
      .then((responseJson: GraphObject) => {
        setGraphData(responseJson);
        const uniqueCategories = responseJson.nodes
          .map((n) => n.data.category)
          .filter((value, index, self) => self.indexOf(value) === index);
        setCategories(uniqueCategories);
      });
  }, []);

  useEffect(() => {
    if (categories.length > 0) {
      categories.map((cat, i) => {
        const hslDegree = (360 / categories.length) * (i + 1);
        const hslColor = `hsl(${hslDegree}, 100%, 50%)`;
        const darkHslColor = `hsl(${hslDegree}, 100%, 35%)`;
        const catStyles = [
          {
            selector: `node[category='${cat}']`,
            style: {
              backgroundColor: hslColor,
              color: darkHslColor,
            },
          },
          {
            selector: `node[category='${cat}']:selected`,
            style: {
              backgroundColor: darkHslColor,
              'border-color': hslColor,
              color: '#333',
            },
          },
        ];
        setStylesheet((s) => [...s, ...catStyles]);
      });
    }
  }, [categories]);

  const onSelectChange = (e: SelectChangeEvent) => {
    setLayout({ ...Layouts[e.target.value] });
  };

  return (
    <>
      <Box p={4}>
        <Typography p={2} mb={4} variant="h4">
          Welcome to the Ontology view
        </Typography>
        {activeNode && (
          <Box mb={3}>
            <Typography variant="h5">
              Selected Node:{' '}
              {activeNode.label ? activeNode.label : activeNode.id}
            </Typography>
            <Typography>
              {activeNode.category && (
                <span>
                  <b>Category:</b> {activeNode.category},{' '}
                </span>
              )}
              {activeNode.type && (
                <span>
                  <b>Type:</b> {activeNode.type},{' '}
                </span>
              )}
              <b>ID:</b> {activeNode.id}
            </Typography>
          </Box>
        )}
        <FormControl>
          <InputLabel id="select-layout-label">Layout</InputLabel>
          <Select
            labelId="select-layout-label"
            id="select-layout"
            value={layout.name}
            label="Layout"
            onChange={onSelectChange}
            sx={{ minWidth: '150px' }}
          >
            {Object.keys(Layouts).map((l) => (
              <MenuItem key={`select-layout_${l}`} value={l}>
                {Layouts[l].label}
              </MenuItem>
            ))}
          </Select>
        </FormControl>
        <Box mt={2} border="1px solid #ccc">
          {graphData.nodes.length > 0 && (
            <CytoscapeComponent
              elements={CytoscapeComponent.normalizeElements(graphData)}
              style={{ width: '100%', height: '100%', minHeight: '500px' }}
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
                  const node = evt.target;
                  setActiveNode(node.data());
                });
              }}
            />
          )}
        </Box>
      </Box>
    </>
  );
};
