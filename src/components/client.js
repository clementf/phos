import axios from 'axios';

var client = axios.create({
  baseURL: (process.env.API_URL || '') + '/api'
});

export default client;
