import { Typography } from "cx-portal-shared-components";

export default function Home(){
  return(
    <>
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
        The Catena-X Skill Gym(nasium)
      </Typography>
      <Typography  sx={{
          mt: 2,
          mb: 2,
          fontFamily: 'LibreFranklin-Light',
          textAlign: 'center',
        }} variant="body1" gutterBottom>
           Welcome to the Knowledge Agents Gym!
      </Typography>
      <Typography sx={{
          mt: 1,
          mb: 1,
          fontFamily: 'LibreFranklin-Light',
          textAlign: 'center',
        }} variant="body2" gutterBottom>
           Knowledge Agents is the approach to create a Semantic-Web Driven Dataspace.
      </Typography>
      <Typography sx={{
          mt: 1,
          mb: 1,
          fontFamily: 'LibreFranklin-Light',
          textAlign: 'center',
        }} variant="body2" gutterBottom>
        <a href="/dataspace">Data (sources/assets)</a> from the individual Dataspace Tenants (or: Connectors) are hereby described as (virtual) Graphs following shared <a href="/ontology">Domain Vocabularies or Ontologies</a>.
      </Typography>
      <Typography sx={{
          mt: 1,
          mb: 1,
          fontFamily: 'LibreFranklin-Light',
          textAlign: 'center',
        }} variant="body2" gutterBottom>
           Agents are active, queriable components of the Connectors which allow to execute and delegate business logic in the form of <a href="/custom-search">Graph Scripts or Skills</a>.
      </Typography>
      <Typography sx={{
          mt: 1,
          mb: 1,
          fontFamily: 'LibreFranklin-Light',
          textAlign: 'center',
        }} variant="body2" gutterBottom>
            The Skill Gym is a standalone application/portal which allows developers to develop and test-run Graphs & Skills in the Catena-X Dataspace.
      </Typography>
      <Typography sx={{
          mt: 1,
          mb: 1,
          fontFamily: 'LibreFranklin-Light',
          textAlign: 'center',
        }} variant="body2" gutterBottom>
            The Skill Gym also showcases reusable Semantic UX Components which are able to interact with the Semantic Dataspace Graph.
      </Typography>
    </>
  );
}
