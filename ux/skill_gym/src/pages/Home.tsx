import { Typography } from 'cx-portal-shared-components';
import logo from '../images/ka_arch.png';
import { Box } from '@mui/material';

export default function Home() {
  return (
    <>
      <Typography
        sx={{
          mt: 3,
          mb: 3,
          fontFamily: 'LibreFranklin-Light',
          textAlign: 'center',
        }}
        variant="h3"
        className="section-title"
      >
        The Skill Gym(nasium)
      </Typography>
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
        Welcome to Catena-X Knowledge Agents!
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
        Knowledge Agents is the approach to create a Semantic Dataspace.
      </Typography>
      <Typography
        sx={{
          mt: 1,
          mb: 1,
          fontFamily: 'LibreFranklin-Light',
          textAlign: 'center',
        }}
        variant="body2"
        gutterBottom
      >
        <a href="/dataspace">Data (Sources/Assets)</a> are catalogued as
        Knowledge Graphs following shared{' '}
        <a href="/vocabulary">Domain Vocabularies/Ontologies</a>.
      </Typography>
      <Typography
        sx={{
          mt: 1,
          mb: 3,
          fontFamily: 'LibreFranklin-Light',
          textAlign: 'center',
        }}
        variant="body2"
        gutterBottom
      >
        Agents are active Connector components which federatedly execute
        business logic expressed as{' '}
        <a href="/custom-search">Graph Queries/Skills</a>.
      </Typography>
      <Box display="flex" alignItems="center" justifyContent="center">
        <img alt="Knowledge Agent Architecture" src={logo} width="640" />
      </Box>
      <Typography
        sx={{
          mt: 3,
          mb: 1,
          fontFamily: 'LibreFranklin-Light',
          textAlign: 'center',
        }}
        variant="body2"
        gutterBottom
      >
        This Skill Gym is a standalone application/portal for consumer and
        provider developers in order to test-run their Graphs & Skills in the
        Catena-X Dataspace.
      </Typography>
      <Typography
        sx={{
          mt: 1,
          mb: 1,
          fontFamily: 'LibreFranklin-Light',
          textAlign: 'center',
        }}
        variant="body2"
        gutterBottom
      >
        The Skill Gym also showcases the reusable Semantic UX Components
        interacting with the Catena-X Knowledge.
      </Typography>
    </>
  );
}
