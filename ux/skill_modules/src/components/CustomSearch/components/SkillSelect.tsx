import {
  FormControl,
  InputLabel,
  Select,
  MenuItem,
  SelectChangeEvent,
  TextField,
} from '@mui/material';
import TreeSelect from 'mui-tree-select';
import React, { useState, useEffect } from 'react';
import { nodeModuleNameResolver } from 'typescript';
import { Node, getParent } from './Tree';

const skills = [
  new Node('All Skills', null, [
    new Node('Trouble Code Search', 'TroubleCodeSearch'),
    new Node('Material Incident Search', 'MaterialIncidentSearch'),
    new Node('Remaining Useful Life', 'Lifetime'),
  ]),
];
const getSkillChildren = (node: Node | null) =>
  node === null ? skills : node.children;

interface SkillSelectProps {
  value: string;
  onChange: (value: string) => void;
  disabled?: boolean;
}

export const SkillSelect = ({
  value,
  onChange,
  disabled,
}: SkillSelectProps) => {
  const [skillList, setSkillList] = useState<any[]>([]);

  useEffect(() => {
    setSkillList(skills);
  });

  return (
    <FormControl fullWidth sx={{ mb: 3 }}>
      <TreeSelect
        getChildren={getSkillChildren}
        getParent={getParent}
        renderInput={(params) => <TextField {...params} label="Skill" />}
        value={skills[0].children!.find((node) => node.value == value)}
        onChange={(event, value, reason, details) => onChange(value!.value)}
      />
    </FormControl>
  );
};
