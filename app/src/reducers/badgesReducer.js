import {
	BADGE_FETCH_LIST,
	BADGE_FETCH_LIST_SUCCES,
	BADGE_FETCH_LIST_FAILED,
	BADGE_ISSUE_RECIPIENT,
	BADGE_ISSUE_RECIPIENT_SUCCES,
	BADGE_ISSUE_RECIPIENT_FAILED
} from '../actions/badgesActions';

const initialState = {
	list: [],
	items: [],
	item: {},
	loading: false
}

export function badgesReducer(state = initialState, action) {
	switch(action.type) {
		case BADGE_FETCH_LIST:
			return {
				...state,
				loading: true
			}
		case BADGE_FETCH_LIST_SUCCES:
			return {
				...state,
				list: action.data,
				loading: false
			};
		case BADGE_FETCH_LIST_FAILED:
			return {
				...state,
				loading: false
			};
		case BADGE_ISSUE_RECIPIENT:
			return {
				...state,
				loading: true
			}
		case BADGE_ISSUE_RECIPIENT_SUCCES:
			return {
				...state,
				item: action.data,
				loading: false
			};
		case BADGE_ISSUE_RECIPIENT_FAILED:
			return {
				...state,
				loading: false
			};
		default:
			return state
	}
}