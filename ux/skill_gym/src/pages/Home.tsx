import { Typography } from 'cx-portal-shared-components';
import logo from '../images/ka_arch.png';
import { Box } from '@mui/material';

export default function Home() {
  return (
    <>
      <Box mb={2}>
        <iframe
          title="SparqlEditor"
          width="100%"
          height={1024}
          frameBorder="0"
          scrolling="no"
          src={`${process.env.REACT_APP_FOLDER}/SkillEditor/index.html?lang=en`}
        />
      </Box>
    </>
  );
}
