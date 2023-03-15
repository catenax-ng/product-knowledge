import React, { useEffect, useRef } from 'react';
import 'sparnatural';
import 'sparnatural/dist/sparnatural.css';
// import the JSON-LD config file
import config from './config.json';

interface SparnaturalEvent extends Event {
  detail?: {
    queryString: string;
    queryJson: string;
    querySparqlJs: string;
  };
}

export default function SupernaturlaEditor() {
  const sparnaturalRef = useRef<HTMLElement>(null);
  useEffect(() => {
    sparnaturalRef?.current?.addEventListener(
      'queryUpdated',
      (event: SparnaturalEvent) => {
        console.log(event?.detail?.queryString);
        console.log(event?.detail?.queryJson);
        console.log(event?.detail?.querySparqlJs);
      }
    );
  }, []);

  return (
    <>
      <link
        rel="stylesheet"
        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css"
      />
      <div id="ui-search">
        <spar-natural
          ref={sparnaturalRef}
          src={JSON.stringify(config)}
          lang={'en'}
          endpoint={
            'https://knowledge.dev.demo.catena-x.net/consumer-edc-data/BPNL00000003CQI9/api/agent'
          }
          distinct={'true'}
          limit={'1000'}
          prefix={
            'skos:http://www.w3.org/2004/02/skos/core# rico:https://www.ica.org/standards/RiC/ontology#'
          }
          debug={'true'}
        />
      </div>
    </>
  );
}
