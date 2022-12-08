import { OntologyHub, OntologyView, getSkillBackend } from '@catenax-ng/skill-modules';
import { useState } from 'react';
import { Box } from "@mui/material";

export default function SkillGym() {
  const [selectedOntology, setSelectedOntology] = useState<string>('')

  return (
    <>
      {selectedOntology.length > 0 &&
        <Box mt={1} mb={1}>
          <iframe title="WebVowl" width="100%" height={500} src={`${getSkillBackend()}#url=${selectedOntology}`} />
        </Box>
      }
      <Box mt={1} mb={1}>
        <OntologyHub onOntologySelect={setSelectedOntology} />
      </Box>
    </>
  );
}
