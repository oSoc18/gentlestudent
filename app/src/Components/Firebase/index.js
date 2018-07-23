// This is a simple entry point file to the Firebase module (src/firebase/ folder) by grouping and exposing all the functionalities from the module to other modules in one file.
// Thus it shouldn’t be necessary for other modules in your application to access any other file than this one to use its functionalities.
import * as auth from './auth';
import * as firestore from './firestore';
import * as firebase from './firebase';
import * as storage from './storage';

export {
    auth,
    firestore,
    firebase,
    storage
};