import { combineReducers } from 'redux';
import leerkansReducer from './leerkansReducer';

export default combineReducers({
    leerkansen: leerkansReducer
})