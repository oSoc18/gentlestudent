import 'dart:async';

import 'package:Gentle_Student/models/opportunity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class OpportunityApi {
  static FirebaseAuth _auth = FirebaseAuth.instance;
  static GoogleSignIn _googleSignIn = new GoogleSignIn();

  FirebaseUser firebaseUser;

  OpportunityApi(FirebaseUser user) {
    this.firebaseUser = user;
  }

  static Future<OpportunityApi> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final FirebaseUser user = await _auth.signInWithGoogle(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    assert(user.email != null);
    assert(user.displayName != null);
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    return new OpportunityApi(user);
  }

  Future<List<Opportunity>> getAllOpportunities() async {
    return (await Firestore.instance.collection('opportunities').getDocuments())
        .documents
        .map((snapshot) => _fromDocumentSnapshot(snapshot))
        .toList();
  }

  StreamSubscription watch(Opportunity opportunity, void onChange(Opportunity opportunity)) {
    return Firestore.instance
        .collection('opportunities')
        .document(opportunity.opportunityId)
        .snapshots
        .listen((snapshot) => onChange(_fromDocumentSnapshot(snapshot)));
  }

  Opportunity _fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data;

    return new Opportunity(
      opportunityId: snapshot.documentID,
      name: data['name'],
      difficulty: data['difficulty'],
      category: data['category'],
      issuerName: data['issuerName'],
    );
  }
}
