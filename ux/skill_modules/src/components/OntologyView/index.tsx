import React, { useEffect, useState } from "react";
import { Box, Typography } from '@mui/material';
import { SharedThemeProvider, theme } from "cx-portal-shared-components";
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
        backgroundColor: theme.palette.primary.main,
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
        color: theme.palette.primary.main,
        fontSize: 20
      }
    },
    {
      selector: "node:selected",
      style: {
        borderWidth: "2px",
        borderColor: theme.palette.success.main,
        borderOpacity: "0.5",
        backgroundColor: theme.palette.success.main,
        width: 50,
        height: 50,
        //text props
        color: theme.palette.success.main,
      }
    },
    {
      selector: "node[category='https://github.com/catenax-ng/product-knowledge/ontology/cx.ttl']",
      style: {
        backgroundColor: theme.palette.warning.main,
        color: theme.palette.warning.main,
        shape: "rectangle"
      }
    },
    {
      selector: "edge",
      style: {
        width: 3,
        lineColor: theme.palette.secondary.main,
        targetArrowColor: theme.palette.secondary.dark,
        targetArrowShape: "triangle",
        curveStyle: "bezier"
      }
    }
  ];

  let myCyRef;
  return (
    <SharedThemeProvider>
      <Typography>Welcome to the Ontology view</Typography>
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
    </SharedThemeProvider>
  );
};
