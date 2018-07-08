import { all, put, takeEvery } from 'redux-saga/effects';
import axios from 'axios';

import {
	LEERKANSEN_FETCH_LIST,
	LEERKANSEN_FETCH_LIST_SUCCES,
	LEERKANSEN_FETCH_LIST_FAILED,
	LEERKANSEN_CREATE_ITEM,
	LEERKANSEN_CREATE_ITEM_SUCCES,
	LEERKANSEN_CREATE_ITEM_FAILED,
	LEERKANSEN_FETCH_BY_ID,
	LEERKANSEN_FETCH_BY_ID_SUCCES,
	LEERKANSEN_FETCH_BY_ID_FAILED,
	LEERKANSEN_DELETE_ITEM,
	LEERKANSEN_DELETE_ITEM_SUCCES,
	LEERKANSEN_DELETE_ITEM_FAILED
} from './../actions/leerkansActions';

function* leerkansenFetch() {
	try {
		const result = yield axios({
			method: 'get',
			url: 'https://gentlestudent-api.herokuapp.com/api/v1/leerkans'
			// url: 'http://localhost:8080/api/v1/leerkans'
		});
		yield put({ type: LEERKANSEN_FETCH_LIST_SUCCES, data: result.data });
	} catch (e) {
		yield put({ type: LEERKANSEN_FETCH_LIST_FAILED, message: e.message });
	}
}
function* leerkansenFetchById(action) {
	try {
		const id = action.id;
		const result = yield axios({
			method: 'get',
			url: `https://gentlestudent-api.herokuapp.com/api/v1/leerkans/${id}`
		})
		yield put({ type: LEERKANSEN_FETCH_BY_ID_SUCCES, data: result.data });
	} catch (e) {
		yield put({ type: LEERKANSEN_FETCH_BY_ID_FAILED, message: e.message });
	}
}
function* leerkansCreateItem(action) {
  try {
    const result = yield axios({
      method: 'post',
			// url: 'https://gentlestudent-api.herokuapp.com/api/v1/leerkans',
			url: 'http://localhost:8080/api/v1/leerkans',
			headers : {
				// 'Content-Type': 'application/x-www-form-urlencoded'
				// 'Content-Type': 'multipart/form-data; boundary=----WebKitFormBoundary'
			},
			data: action.data
    });
    yield put({ type: LEERKANSEN_CREATE_ITEM_SUCCES, data: result.data });
  } catch (e) {
    yield put({ type: LEERKANSEN_CREATE_ITEM_FAILED, message: e.message });
  }
}

function* leerkansDeleteItem(action) {
  try {
		console.log('trying...')
		const id = action.data;
    axios({
      method: 'delete',
			// url: 'https://gentlestudent-api.herokuapp.com/api/v1/leerkans',
			url: `http://localhost:8080/api/v1/leerkans/${id}`
		});
    yield put({ type: LEERKANSEN_DELETE_ITEM_SUCCES, data: action.data });
  } catch (e) {
    yield put({ type: LEERKANSEN_DELETE_ITEM_FAILED, message: e.message });
  }
}

function* leerkansSagas() {
	yield all([
		takeEvery(LEERKANSEN_FETCH_LIST, leerkansenFetch),
		takeEvery(LEERKANSEN_CREATE_ITEM, leerkansCreateItem),
		takeEvery(LEERKANSEN_FETCH_BY_ID, leerkansenFetchById),
		takeEvery(LEERKANSEN_DELETE_ITEM, leerkansDeleteItem),
		takeEvery(LEERKANSEN_DELETE_ITEM_SUCCES, leerkansenFetch),
	]);
}

export default leerkansSagas;