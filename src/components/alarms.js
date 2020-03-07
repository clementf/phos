import React from 'react';
import { withStyles } from '@material-ui/core/styles';
import Fab from '@material-ui/core/Fab';
import Switch from '@material-ui/core/Switch';
import TextField from '@material-ui/core/TextField';
import AddIcon from '@material-ui/icons/Add';
import DeleteIcon from '@material-ui/icons/Delete';
import Divider from '@material-ui/core/Divider';
import Avatar from '@material-ui/core/Avatar';
import update from 'immutability-helper';
import Notifier, { openSnackbar } from './notifier.js';

import { alarms as styles } from './styles.js';
import { weekdays, toggleArrayElement } from '../utils.js';
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

  findAlarm = alarmId => {
    return this.state.alarms.find(alarm => alarm.id == alarmId);
  };

  findAlarmIndex = alarmId => {
    return this.state.alarms.findIndex(alarm => alarm.id == alarmId);
  };

  handleChangeActive = alarmId => event => {
    const alarm = this.findAlarm(alarmId);

    alarm.active = !alarm.active;
    this.updateAlarm(alarm);
  };

  handleChangeTime = alarmId => event => {
    const alarm = this.findAlarm(alarmId);
    [alarm.hour, alarm.min] = event.target.value.split(':');

    this.updateAlarm(alarm);
  };

  handleChangeDay = (alarmId, dayIndex) => event => {
    const alarm = this.findAlarm(alarmId);

    alarm.days = toggleArrayElement(alarm.days, dayIndex);
    this.updateAlarm(alarm);
  };

  updateAlarm = alarm => {
    client.put(`/alarms/${alarm.id}`, alarm).then(response => {
      openSnackbar({ message: 'Alarm updated' });
      const newState = update(this.state.alarms, { index: { $set: alarm } });
      this.setState({ newState });
    });
  };

  handleAddAlarm = () => {
    const alarm = {
      hour: 7,
      min: 0,
      days: [],
      active: true
    };

    client.post('/alarms', alarm).then(response => {
      openSnackbar({ message: 'Alarm added' });
      const alarms = update(this.state.alarms, { $push: [response.data] });
      this.setState({ alarms });
    });
  };

  handleDeleteAlarm = alarmId => {
    const index = this.findAlarmIndex(alarmId);

    client.delete(`/alarms/${alarmId}`).then(response => {
      openSnackbar({ message: 'Alarm deleted' });
      const alarms = update(this.state.alarms, { $splice: [[index, 1]] });
      this.setState({ alarms });
    });
  };

  render() {
    const { classes } = this.props;

    const listDays = (alarmId, activeDays) => {
      return weekdays.map((day, dayIndex) => (
        <Avatar
          className={`${classes.avatar} ${
            activeDays.includes(dayIndex) ? classes.activeAvatar : ''
          }`}
          key={dayIndex}
          onClick={this.handleChangeDay(alarmId, dayIndex)}
        >
          {day}
        </Avatar>
      ));
    };

    const time = alarm => {
      return (
        <TextField
          InputLabelProps={{
            shrink: true
          }}
          className={classes.time}
          defaultValue={`${alarm.hour}:${alarm.min}`}
          inputProps={{
            className: classes.time,
            step: 300 // 5 min
          }}
          onChange={this.handleChangeTime(alarm.id)}
          type="time"
        />
      );
    };

    const deleteButton = alarmId => {
      return (
        <Fab
          aria-label="Delete"
          className={classes.smallButton}
          color="secondary"
          onClick={() => this.handleDeleteAlarm(alarmId)}
        >
          <DeleteIcon />
        </Fab>
      );
    };

    const listAlarms = this.state.alarms.map((alarm, index) => (
      <li key={alarm.id}>
        <div className={classes.row}>
          {time(alarm)}
          <Switch
            checked={alarm.active}
            color="primary"
            onChange={this.handleChangeActive(alarm.id)}
          />
          {deleteButton(alarm.id)}
        </div>
        <div className={classes.row}>{listDays(alarm.id, alarm.days)}</div>
        <Divider />
      </li>
    ));

    return (
      <div className={classes.center}>
        <ul className={classes.list}>{listAlarms}</ul>
        <Fab
          aria-label="Add"
          color="primary"
          onClick={this.handleAddAlarm}
          variant="fab"
        >
          <AddIcon />
        </Fab>
        <Notifier />
      </div>
    );
  }
}

export default withStyles(styles)(Alarms);
