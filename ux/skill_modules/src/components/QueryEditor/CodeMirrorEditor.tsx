import {
  getConnectorFactory,
  BindingSet,
} from '@catenax-ng/skill-framework/dist/src';
import React, { useCallback, useState } from 'react';
import CodeMirror from '@uiw/react-codemirror';
import 'codemirror/theme/monokai.css';
import 'codemirror/theme/eclipse.css';
import 'codemirror/keymap/sublime';
import 'codemirror/mode/sparql/sparql';
import { Box } from '@mui/material';
import { IconButton, LoadingButton } from 'cx-portal-shared-components';
import Brightness7Icon from '@mui/icons-material/Brightness7';
import NightlightIcon from '@mui/icons-material/Nightlight';
import PlayArrowIcon from '@mui/icons-material/PlayArrow';

interface EditorProps {
  defaultCode: string;
  onSubmit: (result: BindingSet) => void;
}
export default function CodeMirrorEditor({
  defaultCode,
  onSubmit,
}: EditorProps) {
  const [theme, setTheme] = useState<string>('monokai');
  const [code, setCode] = useState<string | undefined>(defaultCode);
  const onChange = React.useCallback((value, viewUpdate) => {
    console.log('value:', value);
    setCode(value);
  }, []);
  const [loading, setLoading] = useState<boolean>(false);

  const toggleTheme = useCallback(() => {
    setTheme((theme) => (theme === 'monokai' ? 'eclipse' : 'monokai'));
  }, []);

  const runCode = () => {
    console.log(code);
    setLoading(true);
    if (code) {
      const connector = getConnectorFactory().create();
      connector.executeQuery(code, {}).then((result) => {
        onSubmit(result);
        console.log(result);
        setLoading(false);
      });
    }
  };
  return (
    <>
      <Box display="flex" justifyContent="flex-end">
        <IconButton
          aria-label="theme-toggle"
          onClick={toggleTheme}
          title="Toggle Theme"
        >
          {theme === 'monokai' ? <Brightness7Icon /> : <NightlightIcon />}
        </IconButton>
      </Box>
      <CodeMirror
        value={defaultCode}
        height="50vh"
        onChange={onChange}
        options={{
          theme: theme,
          keyMap: 'sublime',
          mode: 'sparql',
        }}
      />
      <Box display="flex">
        <LoadingButton
          startIcon={<PlayArrowIcon />}
          loading={loading}
          variant="outlined"
          label={'Run SPARQL'}
          loadIndicator={'Loading...'}
          onButtonClick={runCode}
        />
      </Box>
    </>
  );
}
