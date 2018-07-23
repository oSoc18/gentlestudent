import { firestore } from './firebase';

export const createOpportunity = (data) =>
  firestore.collection('Opportunities').add(data)

export const onceGetOpportunities = () =>
  // db.ref('Opportunities').once('value');
  firestore.collection('Opportunities').get()

export const createAddress = (data) =>
  firestore.collection('Addresses').add(data);

export const onceGetBadges = () =>
  // db.ref('Opportunities').once('value');
  firestore.collection('Badges').get()

 