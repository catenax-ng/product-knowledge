import {
  BindingSet,
  getConnectorFactory,
} from '@catenax-ng/skill-framework/dist/src';
import Editor from '@monaco-editor/react';
import { Box } from '@mui/material';
import { IconButton, LoadingButton } from 'cx-portal-shared-components';
import React, { useCallback, useState } from 'react';
import PlayArrowIcon from '@mui/icons-material/PlayArrow';
import Brightness7Icon from '@mui/icons-material/Brightness7';
import NightlightIcon from '@mui/icons-material/Nightlight';

interface MonacoEditorProps {
  defaultCode: string;
  onSubmit: (result: BindingSet) => void;
}
export default function MonacoEditor({
  defaultCode,
  onSubmit,
}: MonacoEditorProps) {
  const [code, setCode] = useState<string | undefined>(defaultCode);
  const [theme, setTheme] = useState<string>('light');
  const [loading, setLoading] = useState<boolean>(false);

  function onCodeChange(value: string | undefined) {
    setCode(value);
  }

  const runCode = () => {
    setLoading(true);
    console.log(code);
    if (code) {
      const connector = getConnectorFactory().create();
      connector.executeQuery(code, {}).then((result) => {
        onSubmit(result);
        console.log(result);
        setLoading(false);
      });
    }
  };

  const toggleTheme = useCallback(() => {
    setTheme((theme) => (theme === 'light' ? 'vs-dark' : 'light'));
  }, []);

  return (
    <>
      <Box display="flex" justifyContent="flex-end" mb={2}>
        <IconButton
          aria-label="theme-toggle"
          onClick={toggleTheme}
          title="Toggle Theme"
        >
          {theme === 'light' ? <Brightness7Icon /> : <NightlightIcon />}
        </IconButton>
      </Box>
      <Editor
        height="50vh"
        defaultLanguage="sparql"
        defaultValue={defaultCode}
        theme={theme}
        onChange={onCodeChange}
      />
      <Box display="flex" mt={2}>
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
