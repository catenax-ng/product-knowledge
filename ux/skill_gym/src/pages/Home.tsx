import { Typography } from "cx-portal-shared-components";
import { Grid } from "@mui/material";
import { useState } from "react";

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
        The Catena-X Skill Gym
      </Typography>
      <Typography  sx={{
          mt: 2,
          mb: 2,
          fontFamily: 'LibreFranklin-Light',
          textAlign: 'center',
        }} variant="body1" gutterBottom>
            Welcome to the Catena-X Knowledge Agents Skill Gym(nasium)!
      </Typography>
      <Typography sx={{
          mt: 1,
          mb: 1,
          fontFamily: 'LibreFranklin-Light',
          textAlign: 'center',
        }} variant="body2" gutterBottom>
            The Skill Gym is a standalone application which allows to develop and run Logic Scripts (=Skills) against the Catena-X Dataspace.
      </Typography>
      <Typography sx={{
          mt: 1,
          mb: 1,
          fontFamily: 'LibreFranklin-Light',
          textAlign: 'center',
        }} variant="body2" gutterBottom>
            It is as well a showcase of so-called Semantic UX Components which interact with the Dataspace Meta-Data (=Ontology).
      </Typography>
    </>
  );
}
