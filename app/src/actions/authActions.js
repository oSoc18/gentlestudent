export const AUTH_CHECK = 'gentlestudent/AUTH_CHECK';
export const AUTHENTICATED = 'gentlestudent/AUTHENTICATED';
export const UNAUTHENTICATED = 'gentlestudent/UNAUTHENTICATED';
export const AUTHENTICATION_ERROR = 'gentlestudent/AUTHENTICATION_ERROR';

export const USER_REGISTER = 'gentlestudent/USER_REGISTER';
export const USER_REGISTER_SUCCES = 'gentlestudent/USER_REGISTER_SUCCES';
export const USER_REGISTER_FAILED = 'gentlestudent/USER_REGISTER_FAILED';

export const USER_LOGIN = 'gentlestudent/USER_LOGIN';
export const USER_LOGIN_SUCCES = 'gentlestudent/USER_LOGIN_SUCCES';
export const USER_LOGIN_FAILED = 'gentlestudent/USER_LOGIN_FAILED';

// Register
export function UserRegister(data) {
  return {
    type: USER_REGISTER,
    data
  };
}
// Login
export function UserLogin(data) {
  return {
    type: USER_LOGIN,
    data
  };
}

export const authenticatedCheck = () => {
  return {
    type: AUTH_CHECK
  };
};