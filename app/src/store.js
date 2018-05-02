import {
    createStore,
    applyMiddleware,
    combineReducers,
    compose 
} from 'redux';
import thunkMiddleware from 'redux-thunk';
import { createLogger } from 'redux-logger';
import createSagaMiddleware from 'redux-saga';

import reducers from './reducers/';
import { reducer as formReducer } from 'redux-form';
import sagas from './sagas/';

const sagaMiddleware = createSagaMiddleware();
const devTools = window.__REDUX_DEVTOOLS_EXTENSION_COMPOSE__ && window.__REDUX_DEVTOOLS_EXTENSION_COMPOSE__();

let middleware = applyMiddleware(
    sagaMiddleware,
    thunkMiddleware,
    createLogger({
        collapsed: true
    })
);
let store = createStore(
    combineReducers({
        ...reducers,
        form: formReducer
    }),
    compose( devTools ),
    middleware,
);

sagaMiddleware.run(sagas);

export default store;