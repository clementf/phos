import React from 'react';
import { Link } from "react-router-dom";

import client from './client.js';

class Alarms extends React.Component {
  componentDidMount() {
    const reactContext = this;

    client.get('/alarms')
      .then(function (response) {
        reactContext.setState({ alarms: response.data });
      });
  }

  render() {
    return (
      <div>
        <h2>Alarms</h2>
        <ul>
          <li>
            <Link to="/">Home</Link>
          </li>
        </ul>
      </div>
    );
  }
}
export default Alarms;
