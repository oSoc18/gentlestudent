import { leerkansReducer } from './leerkansReducer';
import { badgesReducer } from './badgesReducer';

const reducer = {
  leerkansen: leerkansReducer,
  badgeIssued: badgesReducer
};

export default reducer;
