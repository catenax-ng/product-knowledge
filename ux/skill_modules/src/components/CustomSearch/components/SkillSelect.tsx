import {
  FormControl,
  InputLabel,
  Select,
  MenuItem,
  SelectChangeEvent,
} from '@mui/material';
import React, { useState, useEffect } from 'react';

const defaultSkills = [
  {
    title: 'Trouble Code Search',
    value: 'TroubleCodeSearch',
  },
  {
    title: 'Example Skill',
    value: 'example',
  },
];

interface SkillSelectProps {
  value: string;
  onChange: (event: SelectChangeEvent) => void;
  disabled?: boolean;
}

export const SkillSelect = ({
  value,
  onChange,
  disabled,
}: SkillSelectProps) => {
  const [skillList, setSkillList] = useState<any[]>([]);

  useEffect(() => {
    setSkillList(defaultSkills);
  });

  return (
    <FormControl fullWidth sx={{ mb: 3 }}>
      <InputLabel id="skill-select-label">Select a skill</InputLabel>
      <Select
        labelId="skill-select-label"
        id="skill-select"
        value={value}
        label="Select a skill"
        onChange={onChange}
        disabled={disabled}
      >
        {skillList.map((skill) => (
          <MenuItem key={skill.value} value={skill.value}>
            {skill.title}
          </MenuItem>
        ))}
      </Select>
    </FormControl>
  );
};
