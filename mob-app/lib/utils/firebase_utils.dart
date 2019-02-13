import 'package:Gentle_Student/models/authority.dart';
import 'package:Gentle_Student/models/category.dart';
import 'package:Gentle_Student/models/difficulty.dart';
import 'package:Gentle_Student/models/status.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseUtils {

  static FirebaseAuth mAuth = FirebaseAuth.instance;
  static Future<FirebaseUser> firebaseUser = mAuth.currentUser();

  static Difficulty dataToDifficulty(int difficulty) {
    switch (difficulty) {
      case 0:
        return Difficulty.BEGINNER;
      case 1:
        return Difficulty.INTERMEDIATE;
      case 2:
        return Difficulty.EXPERT;
    }
    return Difficulty.BEGINNER;
  }

  static Authority dataToAuthority(int authority) {
    switch (authority) {
      case 0:
        return Authority.BLOCKED;
      case 1:
        return Authority.APPROVED;
      case 2:
        return Authority.DELETED;
    }
    return Authority.APPROVED;
  }

  static Category dataToCategory(int category) {
    switch (category) {
      case 0:
        return Category.DIGITALEGELETTERDHEID;
      case 1:
        return Category.DUURZAAMHEID;
      case 2:
        return Category.ONDERNEMINGSZIN;
      case 3:
        return Category.ONDERZOEK;
      case 4:
        return Category.WERELDBURGERSCHAP;
    }
    return Category.DUURZAAMHEID;
  }

  static Status dataToStatus(int status) {
    switch (status) {
      case 0:
        return Status.PENDING;
      case 1:
        return Status.APPROVED;
      case 2:
        return Status.REFUSED;
      case 3:
        return Status.ACCOMPLISHED;
    }
    return Status.PENDING;
  }

}