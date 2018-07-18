// This is where all the configuration goes for Firebase.
// In addition, Firebase itself will be instantiated in this file.
import firebase from 'firebase/app';
import 'firebase/auth';

const config = {
    apiKey: "AIzaSyCc4BynJgqfL5liup-DFdnboo-VZGNmBRQ",
    authDomain: "gentle-student.firebaseapp.com",
    databaseURL: "https://gentle-student.firebaseio.com",
    projectId: "52934623602",
    storageBucket: '',
    messagingSenderId: "52934623602",
  };

if (!firebase.apps.length) {
    firebase.initializeApp(config);
}

const auth = firebase.auth();

export {
  auth,
};