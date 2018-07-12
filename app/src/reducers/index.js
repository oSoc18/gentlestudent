import { leerkansReducer } from './leerkansReducer';
import { badgesReducer } from './badgesReducer';
import { authReducer } from './authReducer';

const reducer = {
  leerkansen: leerkansReducer,
  badge: badgesReducer,
  auth: authReducer
};

export default reducer;
