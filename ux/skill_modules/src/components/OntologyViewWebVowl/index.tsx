import React, { useEffect, useState } from "react";
import { Box, FormControl, InputLabel, MenuItem, Select, SelectChangeEvent, Typography } from '@mui/material';

const d3Script = document.createElement("script");
d3Script.src = "d3.min.js";
d3Script.async = true;
document.body.appendChild(d3Script);

const webvowlScript = document.createElement("script");
webvowlScript.src = "webvowl.js";
webvowlScript.async = true;
document.body.appendChild(webvowlScript);

const webvowlCss = document.createElement("link");
webvowlCss.href = "vowl.css";
webvowlCss.type  =  'text/css';
webvowlCss.rel  =  'stylesheet';
document.head.append(webvowlCss);

interface OntologyViewType {
  dataUrl: string
}

type LifecycleStatus = "unmounted" | "mounted" | "remounted" | "render";

export const OntologyViewWebVowl = ({dataUrl}: OntologyViewType) => {
  const [graphData, setGraphData] = useState<any | undefined>({
    namespace: [],
    header: {
      languages: [],
      title: {
        undefined: "Empty Graph"
      },
      iri: "",
      version: "",
      author: [
      ],
      description: {
      },
      other: {
      }
    },
      metrics: {
        classCount: 0,
        datatypeCount: 0,
        objectPropertyCount: 0,
        datatypePropertyCount: 0,
        propertyCount: 0,
        nodeCount: 0,
        axiomCount: 0,
        individualCount: 0
      },
      class: [],
      classAttribute: [],
      datatype: [],
      datatypeAttribute: [],
      property: [],
      propertyAttribute: []
   });
  const [activeNode, setActiveNode] = useState<any>();
  const [categories, setCategories] = useState<string[]>([])
  const [mounted, setMounted] = React.useState<LifecycleStatus>("unmounted");
  const graph = React.useRef<any | undefined>();

  const warningModule = {
    closeFilterHint:function() {},
    showEditorHint:function() {},
    showExporterWarning:function() {},
    showFilterHint:function() {},
    responseWarning:function() {},
    showMultiFileUploadWarning:function() {},
    addMessageBox:function() {},
    createMessageContext:function(id:any) {},
    showMessage:function(id:any) {},
    closeMessage:function(id:any) {},
    showWarning:function ( header:any, reason:any, action:any, type:any, forcedWarning:any, additionalOpts:any ){}
  };
  
  const loadingModule = {
    checkForScreenSize:function (){},
    getMessageVisibilityStatus:function (){ return false;},
    getProgressBarMode:function (){ return 1; },
    successfullyLoadedOntology:function () { return true; },
    missingImportsWarning:function (){ return false; },
    setOntologyMenu:function ( menu:any ){ },
    showErrorDetailsMessage:function (){},
    showWarningDetailsMessage:function (){},
    scrollDownDetails:function (){},
    hideLoadingIndicator:function (){},
    showLoadingIndicator:function (){},
    setup:function (){},
    updateSize:function (){},
    getDetailsState:function (){return false;},
    expandDetails:function (){},
    collapseDetails:function (){},
    setBusyMode:function (){},
    setSuccessful:function (){},
    setErrorMode:function (){},
    setPercentMode:function (){},
    setPercentValue:function ( percent:any){},
    emptyGraphContentError:function (){},
    isThreadCanceled:function (){},
    initializeLoader:function (){},
    parseUrlAndLoadOntology: function ( storeCache:any ){},
    from_JSON_URL:function (fileName:any){},
    requestServerTimeStampForDirectInput:function ( callback:any, text:any ){},
    from_IRI_URL:function ( fileName:any ){},
    fromFileDrop:function ( fileName:any, file:any ){},
    from_FileUpload:function ( fileName:any ){},
    directInput: function ( text:any ){},
    loadFromOWL2VOWL : function ( ontoContent:any, filename:any ){}
  };

  const ontologyMenu = {
    getLoadingFunction: function (){ return undefined; },
    clearCachedVersion: function (){ },
    reloadCachedOntology: function (){},
    cachedOntology: function ( ontoName:any ){},
    setCachedOntology:function ( ontoName:any, ontoContent:any ){},
    getErrorStatus: function (){ return false; },
    setup:function ( _loadOntologyFromText:any ){},
    setIriText:function ( text:any ){},
    stopLoadingTimer: function (){ },
    clearDetailInformation: function (){ },
    append_message: function ( msg:any ){},
    append_message_toLastBulletPoint: function ( msg:any ){},
    append_bulletPoint: function ( msg:any ){},
    setLoadingStatusInfo: function ( msg:any ){},
    setConversionID:function ( id:any ){},
    callbackLoad_Ontology_FromIRI:function ( parameter:any ){},
    callbackLoad_Ontology_From_DirectInput : function ( text:any, parameter:any ){},
    getConversionId : function (){ return undefined; },
    callbackLoad_JSON_FromURL : function ( parameter:any ){},
    callbackLoadFromOntology : function ( selectedFile:any, filename:any, local_threadId:any ){},
    conversionFinished : function ( id:any ){},
    showLoadingStatus : function ( visible:any ){ },
    
  };

  const editSideBar = {
    clearMetaObjectValue : function (){},
    updatePrefixUi : function (){},
    setup : function (){},
    updateEditDeleteButtonIds :function ( oldPrefi:any, newPrefix:any ){},
    checkForExistingURL : function ( url:any ){ return false;},
    checkProperIriChange : function ( element:any, url:any ){ return false; },
    updateSelectionInformation :function ( element:any ){},
    updateGeneralOntologyInfo :function (){},
    updateElementWidth : function (){}
  };

  const filterMenu = {
    setDefaultDegreeValue : function ( val:any ){},
    getDefaultDegreeValue : function (){ return 0; },
    getGraphObject : function (){ return graph.current; },
    getCheckBoxContainer : function (){ return undefined; },
    getDegreeSliderValue : function (){ return 0; },
    setup : function ( datatypeFilter:any, objectPropertyFilter:any, subclassFilter:any, disjointFilter:any, setOperatorFilter:any, nodeDegreeFilter:any ){},
    reset : function (){},
    killButtonAnimation : function (){},
    highlightForDegreeSlider : function ( enable:any ){},
    setCheckBoxValue : function ( id:any, checked:any ){},
    getCheckBoxValue : function ( id:any ){ return false },
    setDegreeSliderValue : function ( val:any ){},
    updateSettings : function (){}
  };

  const searchMenu = {
    requestDictionaryUpdate : function (){},
    setup : function (){},
    hideSearchEntries : function (){},
    showSearchEntries : function (){},
    getSearchString : function (){ return undefined; },
    clearText : function (){}
  };

  const zoomSlider = {
    setup : function (){},
    showSlider : function ( val:any ){},
    zooming : function (){},
    updateZoomSliderValue : function ( val:any ){}
  };

  const leftSideBar = {
    setup : function (){},
    hideCollapseButton : function ( val:any ){},
    isSidebarVisible : function (){ return false;},
    updateSideBarVis : function ( init:any ){},
    initSideBarAnimation : function (){},
    showSidebar : function ( val:any, init:any ){},
    getSidebarVisibility : function (){return String(0);}
  };  // initialize libs

  useEffect(() => {
    console.log("OntologyView: Mount Change.");
    // Skip the first render (mount).
    if (mounted == "mounted" || mounted == "remounted") {
      const webvowl=window.webvowl;
      if(webvowl==undefined || window.d3 == undefined) {
        console.log("OntologyView: Wait for d3/webvowl initialization.");
        const nextMount= mounted == "mounted" ? "remounted" : "mounted";
        (async () => { 
          await delay(500);
          // Do something after
          setMounted(nextMount);
        })();
      } else {
        console.log("OntologyView: Prepare rendering.");
      setMounted("render");
      console.log(webvowl);
      graph.current = webvowl.graph("#graph");
      console.log(graph.current);
      const options = graph.current.graphOptions();
      options.warningModule(warningModule);
      options.loadingModule(loadingModule);
      options.ontologyMenu(ontologyMenu);
      options.editSidebar(editSideBar);
      options.searchMenu(searchMenu);
      options.zoomSlider(zoomSlider);
      options.leftSidebar(leftSideBar);
      const literalFilter=webvowl.modules.emptyLiteralFilter();
      literalFilter.enabled(false);
      options.filterModules().push(literalFilter);
      options.literalFilter(literalFilter);
      //const nodeFilter=webvowl.modules.nodeDegreeFilter(filterMenu);
      //options.filterModules().push(nodeFilter);
      //options.nodeDegreeFilter(nodeFilter);
      const focuser = webvowl.modules.focuser(graph.current);
      options.focuserModule(focuser);
      options.selectionModules().push(focuser);
      options.data(graphData);
      options.setEditorModeForDefaultObject(false);
      graph.current.load();
      graph.current.start();
      //window.d3.select(window).on("resize", adjustSize);
      adjustSize();
      fetch(dataUrl)
      .then((response) => response.json())
      .then((responseJson: any) => {
        setGraphData(responseJson);
      })
      }
    } else if(mounted == "unmounted") {
      console.log("OntologyView: About to mount.");
      setMounted("mounted");
    }
  },[mounted]);
  
  useEffect(() => {
    console.log("OntologyView: Data Change.");
    if(mounted=="render" && graphData != undefined) {
      console.log("OntologyView: update graph.",graphData);
      const options = graph.current.graphOptions();
      options.data(graphData);
      graph.current.load();
    }
        //const uniqueCategories = responseJson.nodes.map(n => n.data.category).filter((value, index, self) => self.indexOf(value) === index);
        //setCategories(uniqueCategories); 
  }, [graphData])

  useEffect(() => {
    console.log("adjustCategories",categories);
    if(categories.length > 0){
      categories.map((cat, i) => {
        const hslDegree = (360/categories.length) * (i + 1)
        const hslColor = `hsl(${hslDegree}, 100%, 50%)`;
        const darkHslColor = `hsl(${hslDegree}, 100%, 35%)`
        const catStyles = [
          {selector: `node[category='${cat}']`,
            style: {
              backgroundColor: hslColor,
              color: darkHslColor
            }
          },
          {selector: `node[category='${cat}']:selected`,
            style: {
              backgroundColor: darkHslColor,
              'border-color': hslColor,
              color: '#333'
            }
          },
        ]
      })
    }
  }, [categories])

  const delay = function(ms: number) {
    return new Promise( resolve => setTimeout(resolve, ms) );
  }

  const adjustSize= () => {
    console.log("adjustSize",graph.current);
      const graphContainer = window.d3.select("#graph");
      const svg = graphContainer.select("svg");
      const height = window.innerHeight - 500;
      const width = window.innerWidth - (window.innerWidth * 0.22);
      graphContainer.style("height", height + "px");
      svg.attr("width", width)
         .attr("height", height);
      const options=graph.current.options();
      options.width(width)
        .height(height);
      graph.current.updateStyle();
  }

  return (
    <>
      <Box p={4}>
        <Typography p={2} mb={4} variant='h4'>Welcome to the Ontology view</Typography>
        {activeNode &&
          <Box mb={3}>
            <Typography variant="h5">Selected Node: {activeNode.label ? activeNode.label : activeNode.id}</Typography>
            <Typography>
              {activeNode.category && <span><b>Category:</b> {activeNode.category}, </span>}
              {activeNode.type && <span><b>Type:</b> {activeNode.type}, </span>} 
              <b>ID:</b> {activeNode.id}</Typography>
          </Box>
        }
        <Box
          mt={2}
          border="1px solid #ccc"
        >
          <div id="graph"></div>
          <a style={{padding: "0 8px 5px 8px"}} draggable="false" title="Nothing to locate, enter search term." href="#" id="locateSearchResult">&#8982;</a>
          <div id="progressBarValue"></div>
          <div id="emptyContainer" hidden><a href="#opts=editorMode=true;#new_ontology1" id="emptyDisabled">Create new ontology</a></div>
        </Box>
      </Box>
    </>
  );
};