const config = require('./webpack.config.js');
const webpack = require('webpack');
const CompressionPlugin = require('compression-webpack-plugin');
const BundleAnalyzerPlugin = require('webpack-bundle-analyzer').BundleAnalyzerPlugin;

config.mode = 'production';

config.optimization = {
  minimize: true
};

config.plugins.push(
  new CompressionPlugin(),
  new BundleAnalyzerPlugin()
);

module.exports = config;
