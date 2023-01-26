import { AssetView } from '@catenax-ng/skill-modules';
import { Box } from '@mui/material';
import { useLocation } from 'react-router-dom';

export default function Dataspace() {
  const { search } = useLocation()
  const params = new URLSearchParams(search)
  const ontologyFilter = params.get('ontology')
  return (
    <Box mt={4}>
      <AssetView filter={ontologyFilter ? ontologyFilter : ''} />
    </Box>
  );
}
