import {
    LEERKANSEN_FETCH_LIST,
    LEERKANSEN_FETCH_LIST_SUCCES,
    LEERKANSEN_FETCH_LIST_FAILED,
    LEERKANSEN_CREATE_ITEM,
    LEERKANSEN_CREATE_ITEM_SUCCES,
    LEERKANSEN_CREATE_ITEM_FAILED
} from '../actions/leerkansActions';

const initialState = {
    items: [],
    item: {},
    loading: false
}

export function leerkansReducer(state = initialState, action) {
    switch(action.type) {
        case LEERKANSEN_FETCH_LIST:
            return {
                ...state,
                loading: true
            }
        case LEERKANSEN_FETCH_LIST_SUCCES:
            return {
                ...state,
                items: action.data,
                loading: false
            };
        case LEERKANSEN_FETCH_LIST_FAILED:
            return {
                ...state,
                loading: false
            };
        case LEERKANSEN_CREATE_ITEM:
            return {
              ...state,
              loading: true
            };
          case LEERKANSEN_CREATE_ITEM_FAILED:
            return {
              ...state,
              loading: false
            };
          case LEERKANSEN_CREATE_ITEM_SUCCES:
            return {
              ...state,
              loading: false
            };
        default:
            return state
    }
}