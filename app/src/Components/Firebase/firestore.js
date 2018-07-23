import { firestore } from './firebase';

export const onceGetLeerkansen = () =>
  // db.ref('Opportunities').once('value');
  firestore.collection('Opportunities').get()

  export const onceGetBadges = () =>
  // db.ref('Opportunities').once('value');
  firestore.collection('Badges').get()