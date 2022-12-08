import { Logo, MainNavigation } from 'cx-portal-shared-components';
import { NavLink, Outlet } from 'react-router-dom';
import { Box } from '@mui/material';

export default function App() {
  const menu = [
    { to: '/home', title: "Skill Gym" },
    { to: '/dataspace', title: "Dataspace" },
    { to: '/skill-gym', title: "Vocabulary" },
    { to: '/custom-search', title: 'Intelligence' },
  ];

  return (
    <Box>
      <MainNavigation items={menu} component={NavLink}>
        <Logo altText="Logo CatenaX" variant="text" />
      </MainNavigation>
      <Box sx={{marginRight: 10, marginBottom: 10, marginLeft: 10}}>
        <Outlet />
      </Box>
    </Box>
  );
}
