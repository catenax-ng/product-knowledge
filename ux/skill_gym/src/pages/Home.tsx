import { Typography } from 'cx-portal-shared-components';
import { Box } from '@mui/material';
import { QueryEditor } from '@catenax-ng/skill-modules';

export default function Home() {
  return (
    <>
      <Box mb={2}>
        <Typography
          sx={{
            mt: 3,
            mb: 3,
            fontFamily: 'LibreFranklin-Light',
            textAlign: 'center',
          }}
          variant="h4"
          className="section-title"
        >
          Query Editor
        </Typography>
        {/* <iframe
          title="SparqlEditor"
          width="100%"
          height={1024}
          frameBorder="0"
          scrolling="no"
          src={`${process.env.REACT_APP_FOLDER}/SkillEditor/index.html?lang=en`}
        /> */}
        <QueryEditor />
      </Box>
    </>
  );
}
