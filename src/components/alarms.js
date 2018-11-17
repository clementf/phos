import React from 'react';
import { Link } from 'react-router-dom';
import { withStyles } from '@material-ui/core/styles';
import deepPurple from '@material-ui/core/colors/deepPurple';
import Switch from '@material-ui/core/Switch';
import Avatar from '@material-ui/core/Avatar';
import update from 'immutability-helper';

import client from './client.js';

const weekdays = new Array(7);
weekdays[0] = 'M';
weekdays[1] = 'T';
weekdays[2] = 'W';
weekdays[3] = 'T';
weekdays[4] = 'F';
weekdays[5] = 'S';
weekdays[6] = 'S';

const styles = {
  row: {
    display: 'flex',
    justifyContent: 'left'
  },
  avatar: {
    margin: 5,
    width: 30,
    height: 30,
    'font-size': '1em'
  },
  activeAvatar: {
    'background-color': deepPurple[500]
  }
};

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

  findAlarm = alarmId => {
    return this.state.alarms.find(alarm => alarm.id == alarmId);
  };

  findAlarmIndex = alarmId => {
    return this.state.alarms.findIndex(alarm => alarm.id == alarmId);
  };

  handleChangeActive = alarmId => event => {
    const alarm = this.findAlarm(alarmId);
    const index = this.findAlarmIndex(alarmId);

    alarm.active = !alarm.active;

    const newState = update(this.state.alarms, { index: { $set: alarm } });

    client.put(`/alarms/${alarm.id}`, alarm);
    this.setState({ newState });
  };

  toggleArrayElement = (array, element) => {
    const index = array.indexOf(element);
    if (index >= 0) delete array[index];
    else array.push(element);

    return array;
  };

  handleChangeDay = (alarmId, dayIndex) => event => {
    const alarm = this.findAlarm(alarmId);
    const index = this.findAlarmIndex(alarmId);

    alarm.days = this.toggleArrayElement(alarm.days, dayIndex);

    const newState = update(this.state.alarms, { index: { $set: alarm } });

    client.put(`/alarms/${alarm.id}`, alarm);
    this.setState({ newState });
  };

  render() {
    const { classes } = this.props;

    const listDays = (alarmId, activeDays) => {
      return weekdays.map((day, dayIndex) => (
        <Avatar
          key={dayIndex}
          onClick={this.handleChangeDay(alarmId, dayIndex)}
          className={`${classes.avatar} ${
            activeDays.includes(dayIndex) ? classes.activeAvatar : ''
          }`}
        >
          {day}
        </Avatar>
      ));
    };

    const listAlarms = this.state.alarms.map((alarm, index) => (
      <li key={alarm.id}>
        <div>
          {`${alarm.hour}:${alarm.min}`}
          <Switch
            checked={alarm.active}
            onChange={this.handleChangeActive(alarm.id)}
            color="primary"
          />
        </div>
        <div className={classes.row}>{listDays(alarm.id, alarm.days)}</div>
      </li>
    ));
    return (
      <div>
        <ul>{listAlarms}</ul>
      </div>
    );
  }
}
export default withStyles(styles)(Alarms);
