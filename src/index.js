import React from "react";
import { render } from 'react-dom';
import { BrowserRouter as Router, Route } from "react-router-dom";

import Home from './components/home';
import Alarms from './components/alarms';

function App() {
  return (
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
      </div>
    </Router>
  );
}

export default App;

render(<App />, document.getElementById('root'));
