import {
  USER_REGISTER,
  USER_REGISTER_FAILED,
  USER_REGISTER_SUCCES, 
	USER_LOGIN,
	USER_LOGIN_SUCCES,
	USER_LOGIN_FAILED
} from '../actions/authActions';

const initialState = {
	user: {},
	loading: true
}

export function authReducer(state = initialState, action) {
	switch(action.type) {
		case USER_REGISTER:
			return {
			  ...state,
			  loading: true
			};
		case USER_REGISTER_SUCCES:
			return {
			  ...state,
			  loading: false
			};
		case USER_REGISTER_FAILED:
			return {
			  ...state,
			  loading: false
			};
		case USER_LOGIN:
			return {
			  ...state,
			  loading: true
			};
		case USER_LOGIN_SUCCES:
			return {
				...state,
				user: action.data,
			  loading: false
			};
		case USER_LOGIN_FAILED:
			return {
			  ...state,
			  loading: false
      };
    default:
      return state;
  }
}