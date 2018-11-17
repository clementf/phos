import React from "react";
import BottomNavigation from '@material-ui/core/BottomNavigation';
import BottomNavigationAction from '@material-ui/core/BottomNavigationAction';
import HomeIcon from '@material-ui/icons/Home';
import AlarmIcon from '@material-ui/icons/Alarm';
import { Link } from "react-router-dom";
import { withStyles } from '@material-ui/core/styles';

const styles = {
  stickToBottom: {
    width: '100%',
    position: 'fixed',
    bottom: 0,
  },
};

class Menu extends React.Component {
  state = {
    value: 0,
  };

  handleChange = (event, value) => {
    this.setState({ value });
  };

  render() {
    const { value } = this.state;
    const { classes } = this.props;

    return (
      <BottomNavigation
        onChange={this.handleChange}
        showLabels
        value={value}
        className={classes.stickToBottom}
      >
        <BottomNavigationAction
          component={Link}
          icon={<HomeIcon />}
          label="Home"
          to="/"
        />
        <BottomNavigationAction
          component={Link}
          icon={<AlarmIcon />}
          label="Alarms"
          to="/alarms"
        />
      </BottomNavigation>
    );
  }
}

export default withStyles(styles)(Menu);
