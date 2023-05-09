import { OntologyHub, getSkillBackend } from '@catenax-ng/skill-modules';
import { useState } from 'react';
import { Box, Typography } from '@mui/material';
import { useLocation, useNavigate } from 'react-router-dom';

export default function Vocabulary() {
  const [selectedOntology, setSelectedOntology] = useState<string>('');
  const { search } = useLocation();
  const navigate = useNavigate();

  const onNavigateToAsset = (ontologyName: string) => {
    let path = `/dataspace?ontology=${ontologyName.replace(' ', '')}`; 
    navigate(path);
  }

  const valRegex = /([^&=]+)/;
  const params = new URLSearchParams(search);
  const assetFilter = params.get('ontologies').match(valRegex)[1];

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
          filter={assetFilter ? assetFilter : ''}
          onShowOntologyGraph={setSelectedOntology}
          onShowAssetList={onNavigateToAsset}
          pageSize={selectedOntology.length > 0 ? 5 : 12}
        />
      </Box>
    </Box>
  );
}
