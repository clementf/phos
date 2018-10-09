import axios from 'axios';
import React from 'react';
import PropTypes from 'prop-types';
import { SketchPicker } from 'react-color';

import '../assets/styles/App.scss';

class App extends React.Component {

  handleChangeComplete(color) {
    axios.post('/colors', {
      color: color['rgb']
    });
  };

  render() {
    return (
      <SketchPicker
        onChangeComplete={this.handleChangeComplete}
      />
    );
  }
}


export default App;
