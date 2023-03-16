import React, { useEffect } from 'react';
import Yasgui from '@triply/yasgui';
import '@triply/yasgui/build/yasgui.min.css';
import Tab from '@triply/yasgui/build/ts/src/Tab';
import { BindingSet } from '@catenax-ng/skill-framework/dist/src';

interface SparqlEditorProps {
  defaultCode: string;
  onSubmit: (result: BindingSet) => void;
}
export default function SparqlEditor({
  defaultCode,
  onSubmit,
}: SparqlEditorProps) {
  useEffect(() => {
    const yasgui = new Yasgui(
      document.getElementById('yasgui') as HTMLElement,
      {
        requestConfig: {
          endpoint:
            'https://knowledge.dev.demo.catena-x.net/consumer-edc-data/BPNL00000003CQI9/api/agent?()',
        },
        copyEndpointOnNewTab: false,
      }
    );
    // Fires when a query is executed
    yasgui.on('query', (instance: Yasgui, tab: Tab) => {
      console.log('on Query');
      console.log(tab);
      console.log(tab);
      console.log(tab.getYasqe());
    });
    // Fires when a query is finished
    yasgui.on('queryResponse', (instance: Yasgui, tab: Tab) => {
      console.log('on queryResponse');
      const yasqe = tab.getYasqe();
      console.log(instance);
      console.log(tab);
      console.log(yasqe.value);
    });
  }, []);

  return (
    <div>
      <div id="yasgui" />
    </div>
  );
}
