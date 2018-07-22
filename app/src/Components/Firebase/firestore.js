import { firestore } from './firebase';

export const onceGetLeerkansen = () =>
  // db.ref('Opportunities').once('value');
  firestore.collection('Opportunities').get()