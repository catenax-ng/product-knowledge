import Editor from "@monaco-editor/react";
import { Box } from "@mui/material";
import { Button } from "cx-portal-shared-components";
import React, { useCallback, useEffect, useState } from "react";

interface MonacoEditorProps{
  defaultCode: string
}
export default function MonacoEditor({defaultCode}: MonacoEditorProps) {
  const [code, setCode] = useState<string | undefined>(defaultCode);
  const [theme, setTheme] = useState<string>('light');
  function onCodeChange(value: string | undefined) {
    console.log('hello onCodeChange');
    console.log(value);
    setCode(value);
  }

  const showValue = () => {
    console.log('hello value');
    console.log(code);
  };

  const toggleTheme = useCallback(() => {
    console.log('change theme');
    setTheme((theme) => (theme === 'light' ? 'vs-dark' : 'light'));
  }, []);

  useEffect(() => {
    console.log(theme);
  }, [theme]);
  return (
    <>
      <Editor
        height="50vh"
        defaultLanguage="sparql"
        defaultValue={defaultCode}
        theme={theme}
        onChange={onCodeChange}
      />
      <Box>
        <Button onClick={toggleTheme}>Toggle Theme</Button>
        <Button onClick={showValue}>Run SPARQL</Button>
      </Box>
    </>
  );
}
