import React, { useEffect, useState } from 'react';
import {
  IconButton,
  FormControl,
  InputLabel,
  OutlinedInput,
  InputAdornment,
} from '@mui/material';
import SearchIcon from '@mui/icons-material/Search';
import CloseIcon from '@mui/icons-material/Close';
import KeyboardVoiceIcon from '@mui/icons-material/KeyboardVoice';
import StopCircleIcon from '@mui/icons-material/StopCircle';

interface VoiceInputProps {
  onSearch: (input: string) => void;
  onReset: VoidFunction;
}

const VoiceInput = ({ onSearch, onReset }: VoiceInputProps) => {
  const [isListening, setIsListening] = useState(false);
  const [transcription, setTranscription] = useState('');
  const SpeechRecognition =
    (window as any).SpeechRecognition ||
    (window as any).webkitSpeechRecognition;
  const voiceRecorder = new SpeechRecognition();
  voiceRecorder.continuous = false;
  voiceRecorder.interimResults = true;
  voiceRecorder.lang = 'en-US';
  voiceRecorder.onresult = (event: any) => {
    const transcript = Array.from(event.results)
      .map((result: any) => result[0])
      .map((result: any) => result.transcript)
      .join('');
    setTranscription(transcript);
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
    <FormControl sx={{ mb: 3 }} fullWidth>
      <InputLabel htmlFor="outlined-adornment-password">
        Search via Speech
      </InputLabel>
      <OutlinedInput
        id="outlined-adornment-password"
        type={'text'}
        value={transcription}
        onChange={(e) => setTranscription(e.target.value)}
        endAdornment={
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
              aria-label="use voice recognition"
              onClick={isListening ? onRecordStop : onRecordStart}
              edge="end"
            >
              {isListening ? <StopCircleIcon /> : <KeyboardVoiceIcon />}
            </IconButton>
            {inputHasValue() && (
              <IconButton
                aria-label="submit input for search"
                onClick={() => onSearch(transcription)}
                edge="end"
              >
                <SearchIcon />
              </IconButton>
            )}
          </InputAdornment>
        }
        label="Search via Speech"
      />
    </FormControl>
  );
};

export default VoiceInput;
