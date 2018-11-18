import axios from 'axios';

import { openSnackbar } from './notifier.js';

var client = axios.create({
  baseURL: (process.env.API_URL || '') + '/api'
});

client.interceptors.response.use(null, function(error) {
  openSnackbar({
    message: `The request could not be handled (status ${
      error.response.status
    } ), please retry.`
  });
  return Promise.reject(error);
});

export default client;
