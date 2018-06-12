import { all, spawn } from 'redux-saga/effects';
import leerkansSagas from './LeerkansSagas';
import badgesSagas from './BadgesSagas';
import authSagas from './AuthSagas';

export default function* rootSaga() {
  yield all([
    spawn(leerkansSagas),
    spawn(badgesSagas),
    spawn(authSagas)
  ]);
}
