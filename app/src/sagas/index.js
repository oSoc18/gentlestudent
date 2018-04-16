import { spawn } from 'redux-saga/effects';
import LeerkansSagas from './LeerkansSagas';

export default function* rootSaga() {
  yield [
    spawn(LeerkansSagas),
  ];
}
