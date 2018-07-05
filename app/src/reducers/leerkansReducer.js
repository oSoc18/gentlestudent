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
	LEERKANSEN_DELETE_ITEM_FAILED,
	LEERKANSEN_DELETE_ITEM_SUCCES
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
		case LEERKANSEN_FETCH_BY_ID:
			return {
				...state,
				loading: true
			}
		case LEERKANSEN_FETCH_BY_ID_SUCCES:
			return {
				...state,
				item: action.data,
				loading: false
			};
		case LEERKANSEN_FETCH_BY_ID_FAILED:
			return {
				...state,
				loading: false
			};
		case LEERKANSEN_DELETE_ITEM:
      return {
        ...state,
        loading: true
      };
    case LEERKANSEN_DELETE_ITEM_FAILED:
      return {
        ...state,
        loading: false
      };
    case LEERKANSEN_DELETE_ITEM_SUCCES:
      return {
				...state,
        loading: false
      };
		default:
			return state
	}
}