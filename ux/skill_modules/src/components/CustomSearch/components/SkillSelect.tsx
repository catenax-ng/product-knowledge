import { FormControl, TextField } from '@mui/material';
import TreeSelect from 'mui-tree-select';
import React, { useState } from 'react';
import { Node, getParent } from './Tree';
import VoiceInput from './VoiceInput';

const initialSkills = [
  new Node('All Skills', null, [
    new Node('Trouble Code Search', 'TroubleCodeSearch'),
    new Node('Material Incident Search', 'MaterialIncidentSearch'),
    new Node('Remaining Useful Life', 'Lifetime'),
  ]),
];

interface SkillSelectProps {
  selectedSkill: string;
  onSkillChange: (value: string) => void;
}

export const SkillSelect = ({
  selectedSkill,
  onSkillChange,
}: SkillSelectProps) => {
  const [skillList, setSkillList] = useState<Node[]>(initialSkills);
  const [errorMessage, setErrorMessage] = useState<string>('');

  const getSkillChildren = (node: Node | null) =>
    node === null ? skillList : node.children;

  const onSearchSkill = (value: string) => {
    console.log(value);
    let filteredSkills: Node[] = [];
    const searchParams = value.split(' ');
    if (skillList[0].children) {
      //something is wrong here
      filteredSkills = skillList[0].children.filter((skill) =>
        searchParams.some((word) => skill.value.includes(word))
      );
    } else {
      setErrorMessage('No items found');
    }
    console.log(filteredSkills);
    if (filteredSkills.length > 0) {
      if (filteredSkills.length == 1) onSkillChange(filteredSkills[0].value);
      setSkillList(filteredSkills);
    } else {
      onResetSkills();
    }
  };

  const onResetSkills = () => {
    setSkillList(initialSkills);
  };

  return (
    <>
      <VoiceInput onSearch={onSearchSkill} onReset={onResetSkills} />
      <FormControl fullWidth sx={{ mb: 3 }} error={errorMessage.length > 0}>
        {skillList[0].children && (
          <TreeSelect
            getChildren={getSkillChildren}
            getParent={getParent}
            renderInput={(params) => <TextField {...params} label="Skill" />}
            value={skillList[0].children.find(
              (node) => node.value == selectedSkill
            )}
            onChange={(_, value) => onSkillChange(value ? value.value : '')}
          />
        )}
      </FormControl>
    </>
  );
};
