import { FETCH_LEERKANSEN } from '../actions/types';

const initialState = {
    items: [],
    item: {}
}

export default (state = initialState, action) => {
    switch(action.type) {
        case FETCH_LEERKANSEN:
        console.log('action FETCH_LEERKANSEN called');
            return {
                ...state,
                items: action.payload
            }
        default:
            return state
    }
}