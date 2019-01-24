import 'package:firebase_auth/firebase_auth.dart';

class FirebaseUtils {

  static FirebaseAuth mAuth = FirebaseAuth.instance;
  static Future<FirebaseUser> firebaseUser = mAuth.currentUser();

}