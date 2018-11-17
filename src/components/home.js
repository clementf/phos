import React from 'react';
import { Link } from 'react-router-dom';

import client from './client.js';
import iro from '@jaames/iro';
import Button from '@material-ui/core/Button';
import { withStyles } from '@material-ui/core/styles';

import '../assets/styles/app.scss';

class Home extends React.Component {
  constructor(props, context) {
    super(props, context);
    this.dimmer = this.dimmer.bind(this);
  }

  componentDidMount() {
    const reactContext = this;

    client.get('/colors/current').then(function(response) {
      const color = response.data;
      reactContext.setState({ color: color });

      var demoColorPicker = new iro.ColorPicker('#color-picker-container', {
        width: 240,
        height: 240,
        color: color
      });

      demoColorPicker.on('color:change', function(color, changes) {
        color = color['rgb'];
        reactContext.setState({ color: color });

        client.post('/colors', {
          color: color
        });
      });
    });
  }

  dimmer() {
    client.post('/modes', {
      mode: 'dimmer'
    });
  }

  render() {
    const { classes } = this.props;

    return (
      <div>
        <div id="color-picker-container" />
        <Button
          variant="contained"
          onClick={this.dimmer}
          className={classes.button}
        >
          Dimmer
        </Button>
      </div>
    );
  }
}

const styles = theme => ({
  button: {
    display: 'flex',
    margin: 'auto'
  }
});
export default withStyles(styles)(Home);