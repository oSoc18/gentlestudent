import { all, put, takeEvery } from 'redux-saga/effects';
import axios from 'axios';

import {
	LEERKANSEN_FETCH_LIST,
	LEERKANSEN_FETCH_LIST_SUCCES,
	LEERKANSEN_FETCH_LIST_FAILED,
	LEERKANSEN_CREATE_ITEM,
	LEERKANSEN_CREATE_ITEM_SUCCES,
	LEERKANSEN_CREATE_ITEM_FAILED,
} from './../actions/leerkansActions';

function* leerkansenFetch(action) {
	try {
		const result = yield axios({
			method: 'get',
			url: 'https://gentlestudent-api.herokuapp.com/api/v1/leerkans'
		});
		yield put({ type: LEERKANSEN_FETCH_LIST_SUCCES, data: result.data });
	} catch (e) {
		yield put({ type: LEERKANSEN_FETCH_LIST_FAILED, message: e.message });
	}
}
function* leerkansCreateItem(action) {
  try {
    const result = yield axios({
      method: 'post',
      url: 'https://gentlestudent-api.herokuapp.com/api/v1/leerkans',
			data: action.data,
			// Auth
      // headers: { Authorization: `Bearer ${action.headers}` }
    });
    yield put({ type: LEERKANSEN_CREATE_ITEM_SUCCES, data: result.data });
  } catch (e) {
    yield put({ type: LEERKANSEN_CREATE_ITEM_FAILED, message: e.message });
  }
}

function* leerkansSagas() {
	yield all([
		takeEvery(LEERKANSEN_FETCH_LIST, leerkansenFetch),
		takeEvery(LEERKANSEN_CREATE_ITEM, leerkansCreateItem)
	]);
}

export default leerkansSagas;