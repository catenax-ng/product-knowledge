import React from 'react';
import ReactDOM from 'react-dom';
import './index.css';
import {
  BrowserRouter as Router,
  Routes,
  Route,
  Navigate,
} from 'react-router-dom';
import Search from './pages/Search';
import SkillGym from './pages/SkillGym';
import App from './App';
import {
  SharedThemeProvider,
  SharedCssBaseline,
} from 'cx-portal-shared-components';

ReactDOM.render(
  <React.StrictMode>
    <SharedCssBaseline />
    <SharedThemeProvider>
      <Router>
        <Routes>
          <Route element={<App />}>
            <Route path="/" element={<Navigate replace to="/skill-gym" />} />
            <Route path="/skill-gym" element={<SkillGym />} />
            <Route path="/custom-search" element={<Search />} />
          </Route>
        </Routes>
      </Router>
    </SharedThemeProvider>
  </React.StrictMode>,
  document.getElementById('app')
);
