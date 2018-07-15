import { API_URL, BADGR_URL, API_URL_LOCAL } from './../config';
import { all, put, takeEvery } from 'redux-saga/effects';
import axios from 'axios';
import {
  AUTH_CHECK,
  USER_REGISTER,
  USER_REGISTER_SUCCES,
  USER_REGISTER_FAILED,
  USER_LOGIN,
  USER_LOGIN_SUCCES,
  USER_LOGIN_FAILED
} from './../actions/authActions';

function* registerUser(action) {
  try {
    const result = yield axios({
      method: 'post',
      url: `${API_URL}/api/v1/auth/register`,
      headers: {
        'Content-Type': 'application/json'
      },
			data: action.data
    });
    yield put({ type: USER_REGISTER_SUCCES, data: result.data });
  } catch (e) {
    yield put({ type: USER_REGISTER_FAILED, message: e.message });
  }
}

function* loginUser(action) {
  try {
    const result = yield axios({
      method: 'post',
      url: `${API_URL_LOCAL}/api/v1/auth/login`,
      headers: {
        'Content-Type': 'application/json'
      },
			data: action.data
    });
    yield put({ type: USER_LOGIN_SUCCES, data: result.data });
  } catch (e) {
    yield put({ type: USER_LOGIN_FAILED, message: e.message });
  }
}

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
        url: `${BADGR_URL}/api-auth/token`,
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
    takeEvery(AUTH_CHECK, checkAuth),
    takeEvery(USER_REGISTER, registerUser),
    takeEvery(USER_LOGIN, loginUser)
  ]);
}
