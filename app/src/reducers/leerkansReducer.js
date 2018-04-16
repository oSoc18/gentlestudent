import {
    LEERKANSEN_FETCH_LIST,
    LEERKANSEN_FETCH_LIST_SUCCESS,
    LEERKANSEN_FETCH_LIST_FAILED
} from '../actions/leerkansActions';

const initialState = {
    items: [],
    item: {}
}

export function leerkansReducer(state = initialState, action) {
    switch(action.type) {
        case LEERKANSEN_FETCH_LIST:
            console.log('action LEERKANSEN_FETCH_LIST called');
            return {
                ...state,
                loading: true
            }
        case LEERKANSEN_FETCH_LIST_SUCCESS:
            console.log('LEERKANSEN_FETCH_LIST_SUCCESS');
            return {
                ...state,
                items: action.data,
                loading: false
            };
        case LEERKANSEN_FETCH_LIST_FAILED:
            console.log('LEERKANSEN_FETCH_LIST_FAILED');
            return {
                ...state,
                loading: false
            };
        default:
            return state
    }
}