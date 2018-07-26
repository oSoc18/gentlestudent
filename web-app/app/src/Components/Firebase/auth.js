// This is where the Firebase authentication API will be defined to sign up, sign in, sign out etc. a user in your application.
// It is the interface between the official Firebase API and your React application.
import { auth } from './firebase';

var id = "";
var email = "";

// Sign Up
export const doCreateUserWithEmailAndPassword = (email, password) =>
    auth.createUserWithEmailAndPassword(email, password);

// Sign In
export const doSignInWithEmailAndPassword = (email, password) =>
    auth.signInWithEmailAndPassword(email, password);

auth.onAuthStateChanged((user) => {
    if (user) {
        id = user.uid;
        email = user.email;
    }
});

// Sign out
export const doSignOut = () =>
    auth.signOut();

// Password Reset
export const doPasswordReset = (email) =>
    auth.sendPasswordResetEmail(email);

// Password Change
export const doPasswordUpdate = (password) =>
    auth.currentUser.updatePassword(password);

export const getUserId = () =>
{return id;}

export const getUserEmail = () =>
{return email;}
