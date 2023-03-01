import React, { useState } from 'react';
import { IconButton } from '@mui/material';
import KeyboardVoiceIcon from '@mui/icons-material/KeyboardVoice';
import StopCircleIcon from '@mui/icons-material/StopCircle';
import recStart from './../../../sounds/recording-start.mp3';
import recStop from './../../../sounds/recording-stop.mp3';

interface VoiceInput {
  setInputValue: (text: string) => void;
}
const VoiceInput = ({ setInputValue }: VoiceInput) => {
  const [isListening, setIsListening] = useState(false);
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
    console.log(transcript);
    setInputValue(transcript);
  };
  const onRecordStart = () => {
    recStart.play().then(() => console.log('start recording'));
    setIsListening(true);
    voiceRecorder.start();
  };

  const onRecordStop = () => {
    recStop.play().then(() => console.log('stop recording'));
    setIsListening(false);
    voiceRecorder.stop();
  };

  return (
    <IconButton
      sx={{ marginLeft: 1 }}
      aria-label="use voice recognition"
      onClick={isListening ? onRecordStop : onRecordStart}
      edge="end"
    >
      {isListening ? <StopCircleIcon /> : <KeyboardVoiceIcon />}
    </IconButton>
  );
};

export default VoiceInput;
