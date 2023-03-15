import React from 'react';
import CodeMirror from '@uiw/react-codemirror';
import 'codemirror/theme/monokai.css';
import 'codemirror/keymap/sublime';
import 'codemirror/mode/sparql/sparql';

export default function CodeMirrorEditor() {
  const onChange = React.useCallback((value, viewUpdate) => {
    console.log('value:', value);
  }, []);
  return (
    <CodeMirror
      value="console.log('hello world!');"
      height="50vh"
      onChange={onChange}
      options={{
        theme: 'monokai',
        keyMap: 'sublime',
        mode: 'sparql',
      }}
    />
  );
}
