import { firestore } from './firebase';

export const onceGetLeerkansen = () =>
  // db.ref('Opportunities').once('value');
  firestore.collection('Opportunities').get()

export const onceGetBadges = () => 
  firestore.collection('Badges').get()