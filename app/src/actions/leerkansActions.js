import { FETCH_LEERKANSEN } from './types';

export const fetchLeerkansen = () => (dispatch) => {
	console.log('fetching data...');
	fetch('https://gentlestudent-api.herokuapp.com/api/v1/leerkans')
		.then(res => res.json())
		.then(leerkansen => dispatch({
			type: FETCH_LEERKANSEN,
			payload: leerkansen
		}));
}
