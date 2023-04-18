import React, { useEffect } from 'react';
import Yasgui from '@triply/yasgui';
import '@triply/yasgui/build/yasgui.min.css';
import Tab from '@triply/yasgui/build/ts/src/Tab';
import {
  BindingSet,
  getConnectorFactory,
} from '@catenax-ng/skill-framework/dist/src';
import './styles.sass';
//import 'codemirror/theme/monokai.css';

interface SparqlEditorProps {
  defaultCode: string;
  onSubmit: (result: BindingSet) => void;
}
export default function SparqlEditor({
  defaultCode,
  onSubmit,
}: SparqlEditorProps) {
  useEffect(() => {
    Yasgui.Yasqe.defaults.value = defaultCode;
    const connector = getConnectorFactory().create();
    //Yasgui.Yasqe.defaults.theme = 'monokai';
    const yasgui = new Yasgui(
      document.getElementById('yasgui') as HTMLElement,
      {
        requestConfig: {
          endpoint: connector.currentConnector(),
        },
        copyEndpointOnNewTab: false,
      }
    );

    // Fires when a query is finished
    yasgui.on('queryResponse', (instance: Yasgui, tab: Tab) => {
      const yasqe = tab.getYasqe();
      //defaultCode needs to be replaced by the input of the editor
      const code = yasqe.getValueWithoutComments();
      const url = tab.getEndpoint();
      connector.executeQuery(code, {}, url).then((result) => {
        onSubmit(result);
      });
    });
  }, []);

  return (
    <div>
      <div id="yasgui" />
    </div>
  );
}
