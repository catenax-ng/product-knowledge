import { Logo, MainNavigation } from 'cx-portal-shared-components';
import { NavLink, Outlet } from 'react-router-dom';
import { Box } from '@mui/material';

export default function App() {
  const menu = [
    { to: '/skill-gym', title: "Skill Gym" },
    { to: '/custom-search', title: 'Custom Search' },
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
