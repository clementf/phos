import React from "react";
import { render } from 'react-dom';
import { BrowserRouter as Router, Route } from "react-router-dom";

import Menu from './components/menu';
import Home from './components/home';
import Alarms from './components/alarms';

function App() {
  return (
    <div>
      <Router>
        <div>
          <Route
            component={Home}
            exact
            path="/"
          />
          <Route
            component={Alarms}
            path="/alarms"
          />
          <Menu />
        </div>
      </Router>
    </div>
  );
}

export default App;

render(<App />, document.getElementById('root'));
