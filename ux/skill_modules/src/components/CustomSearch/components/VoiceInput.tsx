//
// Skill Module
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//

import React, { useState } from 'react';
import { IconButton, InputAdornment, TextField } from '@mui/material';
import CloseIcon from '@mui/icons-material/Close';
import KeyboardVoiceIcon from '@mui/icons-material/KeyboardVoice';
import StopCircleIcon from '@mui/icons-material/StopCircle';
import SearchIcon from '@mui/icons-material/Search';

/* import recStart from './../../../sounds/recording-start.mp3';
import recStop from './../../../sounds/recording-stop.mp3'; */

interface VoiceInput {
  onSearch: (input: string) => void;
  onReset: VoidFunction;
  noResult: boolean;
}
const VoiceInput = ({ onSearch, onReset, noResult }: VoiceInput) => {
  const [isListening, setIsListening] = useState(false);
  const [transcription, setTranscription] = useState('');
  const SpeechRecognition =
    (window as any).SpeechRecognition ||
    (window as any).webkitSpeechRecognition;
  if (!SpeechRecognition) {
    return <div>Browser is not supporting speech recognition!</div>;
  }
  const voiceRecorder = new SpeechRecognition();
  voiceRecorder.continuous = false;
  voiceRecorder.interimResults = true;
  voiceRecorder.lang = 'en-US';
  voiceRecorder.onresult = (event: any) => {
    const transcript = Array.from(event.results)
      .map((result: any) => result[0])
      .map((result: any) => result.transcript)
      .join('');
    setTranscription(transcription + transcript);
  };

  const onRecordStart = () => {
    setIsListening(true);
    voiceRecorder.start();
  };

  const onRecordStop = () => {
    setIsListening(false);
    voiceRecorder.stop();
  };

  const onDeleteInput = () => {
    setTranscription('');
    onReset();
  };

  const inputHasValue = () => transcription.length > 0;

  return (
    <TextField
      fullWidth
      sx={{ mb: 2, pl: 0 }}
      error={noResult}
      id="voice-search"
      label="Search via Speech"
      value={transcription}
      helperText={
        noResult && 'No result found! Please specify your search input.'
      }
      onChange={(e) => setTranscription(e.target.value)}
      InputProps={{
        endAdornment: (
          <InputAdornment position="end">
            {inputHasValue() && (
              <IconButton
                aria-label="remove input text"
                onClick={onDeleteInput}
                edge="end"
              >
                <CloseIcon />
              </IconButton>
            )}
            <IconButton
              sx={{ marginLeft: 1 }}
              aria-label="use voice recognition"
              onClick={isListening ? onRecordStop : onRecordStart}
              edge="end"
            >
              {isListening ? <StopCircleIcon /> : <KeyboardVoiceIcon />}
            </IconButton>
            {inputHasValue() && (
              <IconButton
                sx={{ marginLeft: 1 }}
                aria-label="submit input for search"
                onClick={() => onSearch(transcription)}
                edge="end"
              >
                <SearchIcon />
              </IconButton>
            )}
          </InputAdornment>
        ),
      }}
    />
  );
};

export default VoiceInput;
