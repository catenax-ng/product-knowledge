import React, { useEffect, useState } from "react";
import { Box, Typography } from '@mui/material';
import CytoscapeComponent from "react-cytoscapejs";

export const OntologyView = () => {
  const [graphData, setGraphData] = useState({nodes: [], edges: []})

  useEffect(() => {
    fetch('https://raw.githubusercontent.com/catenax-ng/product-knowledge/feature/ka-38-edc-assets/infrastructure/consumer/resources/cx-ontology.json')
      .then((response) => response.json())
      .then((responseJson) => {
        console.log(responseJson)
        setGraphData(responseJson);
      })
  }, [])

  const testData = {
    nodes: [
      { data: { id: '1', label: 'IP 1', type: 'ip' } },
      { data: { id: '2', label: 'Device 1', type: 'device' } },
      { data: { id: '3', label: 'IP 2', type: 'ip' } },
      { data: { id: '4', label: 'Device 2', type: 'device' } },
      { data: { id: '5', label: 'Device 3', type: 'device' } },
      { data: { id: '6', label: 'IP 3', type: 'ip' } },
      { data: { id: '7', label: 'Device 5', type: 'device' } },
      { data: { id: '8', label: 'Device 6', type: 'device' } },
      { data: { id: '9', label: 'Device 7', type: 'device' } },
      { data: { id: '10', label: 'Device 8', type: 'device' } },
      { data: { id: '11', label: 'Device 9', type: 'device' } },
      { data: { id: '12', label: 'IP 3', type: 'ip' } },
      { data: { id: '13', label: 'Device 10', type: 'device' } },
    ],
    edges: [
      {
        data: { source: '1', target: '2', label: 'Node2' },
      },
      {
        data: { source: '3', target: '4', label: 'Node4' },
      },
      {
        data: { source: '3', target: '5', label: 'Node5' },
      },
      {
        data: { source: '6', target: '5', label: ' 6 -> 5' },
      },
      {
        data: { source: '6', target: '7', label: ' 6 -> 7' },
      },
      {
        data: { source: '6', target: '8', label: ' 6 -> 8' },
      },
      {
        data: { source: '6', target: '9', label: ' 6 -> 9' },
      },
      {
        data: { source: '3', target: '13', label: ' 3 -> 13' },
      },
    ],
  };

  const layout = {
    name: 'circle',
    fit: true,
    // circle: true,
    directed: true,
    padding: 50,
    // spacingFactor: 1.5,
    animate: true,
    animationDuration: 1000,
    avoidOverlap: true,
    nodeDimensionsIncludeLabels: false,
  };


  const styleSheet = [
    {
      selector: "node",
      style: {
        backgroundColor: '#ffa600',
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
        color: '#ffa600',
        fontSize: 20
      }
    },
    {
      selector: "node:selected",
      style: {
        borderWidth: "2px",
        borderColor: '#b3cb2d',
        borderOpacity: "0.5",
        backgroundColor: '#b3cb2d',
        width: 50,
        height: 50,
        //text props
        color: '#b3cb2d',
      }
    },
    {
      selector: "node[category='https://github.com/catenax-ng/product-knowledge/ontology/cx.ttl']",
      style: {
        backgroundColor: '#D91E18',
        color: '#D91E18',
        shape: "rectangle"
      }
    },
    {
      selector: "edge",
      style: {
        width: 3,
        lineColor: '#0f71cb',
        targetArrowColor: '#0d55af',
        targetArrowShape: "triangle",
        curveStyle: "bezier"
      }
    }
  ];

  let myCyRef;
  return (
    <Box p={4}>
      <Typography p={2} variant='h4'>Welcome to the Ontology view</Typography>
      <CytoscapeComponent
        elements={CytoscapeComponent.normalizeElements(graphData)}
        // pan={{ x: 200, y: 200 }}
        style={{ width: '400px', height:  '400px'}}
        zoomingEnabled={true}
        maxZoom={3}
        minZoom={0.1}
        autounselectify={false}
        boxSelectionEnabled={true}
        layout={layout}
        stylesheet={styleSheet}
        cy={(cy) => {
          myCyRef = cy;
          console.log(cy.data())

          cy.on('tap', 'node', (evt) => {
            var node = evt.target;
            console.log('EVT', evt);
            console.log('TARGET', node.data());
            console.log('TARGET TYPE', typeof node[0]);
          });
        }}
      />
    </Box>
  );
};
