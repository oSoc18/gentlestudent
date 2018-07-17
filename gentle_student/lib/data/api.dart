import 'dart:async';

import 'package:Gentle_Student/models/assertion.dart';
import 'package:Gentle_Student/models/category.dart';
import 'package:Gentle_Student/models/difficulty.dart';
import 'package:Gentle_Student/models/experience.dart';
import 'package:Gentle_Student/models/opportunity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OpportunityApi {

  Future<List<Opportunity>> getAllOpportunities() async {
    return (await Firestore.instance.collection('Opportunities').getDocuments())
        .documents
        .map((snapshot) => _fromDocumentSnapshot(snapshot))
        .toList();
  }

  StreamSubscription watch(Opportunity opportunity, void onChange(Opportunity opportunity)) {
    return Firestore.instance
        .collection('Opportunities')
        .document(opportunity.opportunityId)
        .snapshots()
        .listen((snapshot) => onChange(_fromDocumentSnapshot(snapshot)));
  }

  Opportunity _fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data;

    return new Opportunity(
      opportunityId: snapshot.documentID,
      name: data['name'],
      difficulty: _dataToDifficulty(data['difficulty']),
      category: _dataToCategory(data['category']),
      badgeImageUrl: data['badgeImageUrl'],
      opportunityImageUrl: data['oppImageUrl'],
      shortDescription: data['shortDescription'],
      longDescription: data['longDescription'],
      beginDate: DateTime.parse(data['beginDate']),
      endDate: DateTime.parse(data['endDate']),
      street: data['street'],
      postalCode: data['postalCode'],
      city: data['city'],
      issuerName: data['issuerName'],
    );
  }

  Difficulty _dataToDifficulty(int difficulty) {
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

  Category _dataToCategory(int category) {
    switch (category) {
      case 0:
        return Category.DUURZAAMHEID;
      case 1:
        return Category.DIGITALEGELETTERDHEID;
      case 2:
        return Category.ONDERNEMINGSZIN;
      case 3:
        return Category.ONDERZOEK;
      case 4:
        return Category.WERELDBURGERSCHAP;
    }
    return Category.DUURZAAMHEID;
  }
}

class ExperiencesApi{
  Future<List<Experience>> getAllExperiencs() async {
    return (await Firestore.instance.collection('Experiences').getDocuments())
        .documents
        .map((snapshot) => _fromDocumentSnapshot(snapshot))
        .toList();
  }

  StreamSubscription watch(Experience experience, void onChange(Experience experience)) {
    return Firestore.instance
        .collection('Experiences')
        .document(experience.experienceId)
        .snapshots()
        .listen((snapshot) => onChange(_fromDocumentSnapshot(snapshot)));
  }

  Experience _fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data;

    return new Experience(
      experienceId: snapshot.documentID,
      content: data['content'],
      recap: data['recap'],
      date: data['date'],
      authorId: data['difficulty']
    );
  }
}

class BadgeApi {

  Future<List<Assertion>> getAllAssertions() async {
    return (await Firestore.instance.collection('Assertions').getDocuments())
        .documents
        .map((snapshot) => _fromDocumentSnapshot(snapshot))
        .toList();
  }

  StreamSubscription watch(Assertion assertion, void onChange(Assertion opportunity)) {
    return Firestore.instance
        .collection('Assertions')
        .document(assertion.entityId)
        .snapshots()
        .listen((snapshot) => onChange(_fromDocumentSnapshot(snapshot)));
  }

  Assertion _fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data;

    return new Assertion(
      entityType: data['entityType'],
      entityId: data['entityId'],
      openBadgeId: data['openBadgeId'],
      createdAt: data['createdAt'],
      createdBy: data['createdBy'],
      badgeclass: data['badgeclass'],
      badgeclassOpenBadgeId: data['badgeclassOpenBadgeId'],
      issuer: data['issuer'],
      issuerOpenBadgeId: data['issuerOpenBadgeId'],
      image: data['image'],
      recipient: data['recipient'],
      issuedOn: data['issuedOn'],
      narrative: data['narrative'],
      evidence: data['evidence'],
      revoked: data['revoked'],
      revocationReason: data['revocationReason'],
      expires: data['expires'],
      extensions: data['extensions'],
    );
  }
}