// This is where all the configuration goes for Firebase.
// In addition, Firebase itself will be instantiated in this file.
import firebase from 'firebase';
import 'firebase/auth/dist/index.cjs';
import 'firebase/firestore/dist/index.cjs';

const config = {
    apiKey: "AIzaSyCc4BynJgqfL5liup-DFdnboo-VZGNmBRQ",
    authDomain: "gentle-student.firebaseapp.com",
    databaseURL: "https://gentle-student.firebaseio.com",
    projectId: "gentle-student",
    storageBucket: 'gentle-student.appspot.com',
    messagingSenderId: "52934623602",
  };

if (!firebase.apps.length) {
    firebase.initializeApp(config);
}

const firestore = firebase.firestore();
const settings = {/* your settings... */ timestampsInSnapshots: true};
firestore.settings(settings);
const auth = firebase.auth();

export {
  firestore,
  auth,
};