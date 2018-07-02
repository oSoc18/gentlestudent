export const AUTH_CHECK = 'gentlestudent/AUTH_CHECK';
export const AUTHENTICATED = 'gentlestudent/AUTHENTICATED';
export const UNAUTHENTICATED = 'gentlestudent/UNAUTHENTICATED';
export const AUTHENTICATION_ERROR = 'gentlestudent/AUTHENTICATION_ERROR';

export const authenticatedCheck = () => {
  return {
    type: AUTH_CHECK
  };
};

export function signInActionLocalStrategy({ email, password }, history) {
  return async (dispatch) => {
    try {
      const postData = new Blob([JSON.stringify({
            email: email,
            password: password
        }, null, 2)],
        {
          type : 'application/json'
        }
      );
      const options = {
          method: 'POST',
          body: postData,
          mode: 'cors',
          cache: 'default'
      };
      const response = await fetch('https://localhost:8080/api/v1/auth/local', options);
      const responseJson = await response.json();

      dispatch({ 
        type: AUTHENTICATED,
        payload: responseJson
      });
      localStorage.setItem('', JSON.stringify(responseJson));

    } catch(error) {
      dispatch({
        type: AUTHENTICATION_ERROR,
        payload: 'Invalid email or password'
      });
    }
  };
}
