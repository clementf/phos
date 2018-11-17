import deepPurple from '@material-ui/core/colors/deepPurple';

export const alarms = {
  time: {
    'font-size': '2rem',
    'line-height': '2rem',
    color: 'white'
  },
  list: {
    margin: '0',
    padding: '2rem',
    'list-style': 'none'
  },
  center: {
    textAlign: 'center'
  },
  row: {
    display: 'flex',
    justifyContent: 'space-between',
    alignItems: 'center',
    margin: '1rem 0'
  },
  avatar: {
    margin: 5,
    width: 30,
    height: 30,
    'font-size': '1em'
  },
  activeAvatar: {
    'background-color': deepPurple[500]
  },
  smallButton: {
    height: 36,
    width: 36
  }
};
