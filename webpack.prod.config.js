const config = require('./webpack.config.js');
const webpack = require('webpack');
const CompressionPlugin = require('compression-webpack-plugin');

config.mode = 'production';

config.optimization = {
  minimize: true
};

config.plugins.push(
  new CompressionPlugin()
);

module.exports = config;
