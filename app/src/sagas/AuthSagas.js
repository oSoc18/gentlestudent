import { all, takeEvery } from 'redux-saga/effects';
import axios from 'axios';
import {
  AUTH_CHECK
} from './../actions/authActions';

function* checkAuth() {
  // Check if there is a token for the user
  const token = localStorage.getItem('token_badgr');
  if (token) {
    console.log('Your already have a token', token)
  } else {
    console.log('No token found. Adding a token...');
    try {
      // Temporary
      const username = 'ismail.kutlu94@gmail.com';
      const password = 'TempGentlestudentPass2387';
      yield axios({
        method: 'post',
        url: `https://api.badgr.io/api-auth/token`,
        data: {
          username : username,
          password: password
        },
        headers: { 'Accept': 'application/json' }
      })
        .then((d) => {
          console.log(d.data);
          localStorage.setItem('token_badgr', d.data.token);
        })
        .catch((e) => {
          console.log(e);
        });
    }
    catch(e) {
      console.log('Error', e);
    }
  }
}

export default function* authSagas() {
  yield all([
    takeEvery(AUTH_CHECK, checkAuth)
  ]);
}
