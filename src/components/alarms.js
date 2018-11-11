import React from 'react';
import { Link } from "react-router-dom";

import client from './client.js';

class Alarms extends React.Component {
  constructor(props, context) {
    super(props, context);
    this.state = {
      alarms: []
    };
  }

  componentDidMount() {
    const reactContext = this;

    client.get('/alarms')
      .then(function (response) {
        reactContext.setState({ alarms: response.data });
      });
  }

  render() {
    const alarms = []
    const listAlarms = this.state.alarms.map((alarm) =>
      <li key={alarm.id}>{`${alarm.hour}:${alarm.min}`}</li>
    );
    return (
      <div>
        <h2>Alarms</h2>
        <ul>
          {listAlarms}
        </ul>

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
