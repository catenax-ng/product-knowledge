import { Input } from 'cx-portal-shared-components';
import React, { ChangeEvent } from 'react';

interface VinInputProps {
  value: string;
  onChange: (e: ChangeEvent<HTMLTextAreaElement | HTMLInputElement>) => void;
  disabled: boolean;
}
export default function VinInput({ value, onChange, disabled }: VinInputProps) {
  return (
    <Input
      helperText="Please enter a valid VIN."
      value={value}
      onChange={onChange}
      placeholder="VIN"
      disabled={disabled}
    />
  );
}
