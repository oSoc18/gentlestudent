import { put, takeEvery } from 'redux-saga/effects';
import axios from 'axios';

import {
	LEERKANSEN_FETCH_LIST,
	LEERKANSEN_FETCH_LIST_SUCCESS,
	LEERKANSEN_FETCH_LIST_FAILED,
} from './../actions/leerkansActions';

function* leerkansenFetch(action) {
	try {
		const result = yield axios({
			method: 'get',
			url: 'https://gentlestudent-api.herokuapp.com/api/v1/leerkans'
		});
		yield put({ type: LEERKANSEN_FETCH_LIST_SUCCESS, data: result.data });
	} catch (e) {
		yield put({ type: LEERKANSEN_FETCH_LIST_FAILED, message: e.message });
	}
}

function* leerkansSagas() {
	yield takeEvery(LEERKANSEN_FETCH_LIST, leerkansenFetch);
}

export default leerkansSagas;