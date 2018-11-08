import client from './client.js';
import React from 'react';
import iro from "@jaames/iro";

import '../assets/styles/App.scss';

class App extends React.Component {

  constructor(props, context) {
    super(props, context);
    this.dimmer = this.dimmer.bind(this)
  }

  componentDidMount() {
    const reactContext = this

    client.get('/colors/current')
      .then(function (response) {
        const color = response.data;
        reactContext.setState({ color: color })

        var demoColorPicker = new iro.ColorPicker("#color-picker-container", {
          width: 240,
          height: 240,
          color: color
        });

        demoColorPicker.on("color:change", function(color, changes) {
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
    return (
      <div>
        <div id="color-picker-container" />
        <div id="dimmer-button" onClick={this.dimmer}>Dimmer</div>
      </div>
    );
  }
}

export default App;
