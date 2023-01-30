import { AssetView } from '@catenax-ng/skill-modules';
import { Box } from '@mui/material';
import { useLocation, useNavigate } from 'react-router-dom';

export default function Dataspace() {
  const { search } = useLocation()
  const params = new URLSearchParams(search)
  const ontologyFilter = params.get('ontology')
  const navigate = useNavigate();

  const onNavigateToOntologies = (ontologyNames: string) => {
    let path = `/vocabulary?ontologies=${ontologyNames}`; 
    navigate(path);
  }

  return (
    <Box mt={4}>
      <AssetView filter={ontologyFilter ? ontologyFilter : ''} onShowOntologies={onNavigateToOntologies} />
    </Box>
  );
}
