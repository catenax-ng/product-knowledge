import { OntologyHub, getSkillBackend } from '@catenax-ng/skill-modules';
import { useState } from 'react';
import { Box, Typography } from '@mui/material';

export default function Vocabulary() {
  const [selectedOntology, setSelectedOntology] = useState<string>('');

  return (
    <Box mt={4}>
      {selectedOntology.length > 0 && (
        <Box mb={2}>
          <iframe
            title="WebVowl"
            width="100%"
            height={500}
            src={`${getSkillBackend()}#url=${selectedOntology}`}
          />
        </Box>
      )}
      {selectedOntology.length <= 0 && (
        <Box
          mt={1}
          mb={1}
          sx={{
            width: '100%',
          }}
        >
          <Typography
            sx={{
              mt: 2,
              mb: 2,
              fontFamily: 'LibreFranklin-Light',
              textAlign: 'center',
            }}
            variant="h4"
            gutterBottom
          >
            The Catena-X Ontology Hub
          </Typography>
          <Typography
            sx={{
              mt: 1,
              mb: 1,
              fontFamily: 'LibreFranklin-Light',
              textAlign: 'center',
            }}
            variant="body1"
            gutterBottom
          >
            The listed Domain Ontologies bring together Provided Graph
            Assets/Offers and Consuming Skill Requests.
          </Typography>
        </Box>
      )}
      <Box mt={1} mb={1}>
        <OntologyHub
          onOntologySelect={setSelectedOntology}
          pageSize={selectedOntology.length > 0 ? 5 : 12}
        />
      </Box>
    </Box>
  );
}
