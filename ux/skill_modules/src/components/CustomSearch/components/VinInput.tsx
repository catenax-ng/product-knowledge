import { Input } from 'cx-portal-shared-components';
import React from 'react';

interface VinInputProps {
  value: string;
  onChange: (e: any) => void;
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
