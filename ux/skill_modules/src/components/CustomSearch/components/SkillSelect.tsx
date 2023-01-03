import { FormControl, TextField } from '@mui/material';
import TreeSelect from 'mui-tree-select';
import React, { useState, useEffect } from 'react';
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
  selectedSkill: string;
  onChange: (value: string) => void;
}

export const SkillSelect = ({ selectedSkill, onChange }: SkillSelectProps) => {
  const [skillList, setSkillList] = useState<Node[]>(skills);

  useEffect(() => {
    setSkillList(skills);
  });

  return (
    <FormControl fullWidth sx={{ mb: 3 }}>
      {skillList[0].children && (
        <TreeSelect
          getChildren={getSkillChildren}
          getParent={getParent}
          renderInput={(params) => <TextField {...params} label="Skill" />}
          value={skillList[0].children.find(
            (node) => node.value == selectedSkill
          )}
          onChange={(_, value) => onChange(value ? value.value : '')}
        />
      )}
    </FormControl>
  );
};
