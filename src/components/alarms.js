import React from 'react';
import { Link } from 'react-router-dom';
import Switch from '@material-ui/core/Switch';

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

    client.get('/alarms').then(function(response) {
      reactContext.setState({ alarms: response.data });
    });
  }
  handleChangeActive = index => event => {
    const alarms = this.state.alarms.map((item, j) => {
      if (j === index) {
        item.active = !item.active;
      }
      return item;
    });

    const alarm = alarms[index];
    client.put(`/alarms/${alarm.id}`, alarm);
    this.setState({ alarms });
  };

  render() {
    const alarms = [];
    const listAlarms = this.state.alarms.map((alarm, index) => (
      <li key={alarm.id}>
        {`${alarm.hour}:${alarm.min}`}
        <Switch
          checked={alarm.active}
          onChange={this.handleChangeActive(index)}
        />
      </li>
    ));
    return (
      <div>
        <ul>{listAlarms}</ul>
      </div>
    );
  }
}
export default Alarms;
