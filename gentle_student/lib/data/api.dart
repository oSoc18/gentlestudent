import 'dart:async';

import 'package:Gentle_Student/models/badge.dart';
import 'package:Gentle_Student/models/beacon.dart';
import 'package:Gentle_Student/models/category.dart';
import 'package:Gentle_Student/models/difficulty.dart';
import 'package:Gentle_Student/models/experience.dart';
import 'package:Gentle_Student/models/opportunity.dart';
import 'package:Gentle_Student/models/adres.dart';
import 'package:Gentle_Student/models/participation.dart';
import 'package:Gentle_Student/models/status.dart';
import 'package:Gentle_Student/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdressApi{
  Future<List<Adress>> getAllAdress() async {
    return (await Firestore.instance.collection('Adresses').getDocuments())
        .documents
        .map((snapshot) => _fromDocumentSnapshot(snapshot))
        .toList();
  }

  Future<Adress> getAdressById(String adresId) async{
    DocumentReference adressDoc = Firestore.instance.collection('Adresses').document(adresId);
    DocumentSnapshot docsnap = await adressDoc.get();
    return new Adress(
      adresId: adresId,
      street: docsnap.data['street'],
      housenumber: docsnap.data['housenumber'],
      city: docsnap.data['city'],
      postalcode: docsnap.data['postalcode']);
  }

  StreamSubscription watch(Adress adress, void onChange(Adress adress)) {
    return Firestore.instance
        .collection('Adresses')
        .document(adress.adresId)
        .snapshots()
        .listen((snapshot) => onChange(_fromDocumentSnapshot(snapshot)));
  }

  Adress _fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data;

    return new Adress(
      adresId: snapshot.documentID,
      street: data['street'],
      housenumber: data['housenumber'],
      city: data['city'],
      postalcode: data['postalcode']
    );
  }
}

class BeaconApi{
  Future<List<Beacon>> getAllAdress() async {
    return (await Firestore.instance.collection('Beacons').getDocuments())
        .documents
        .map((snapshot) => _fromDocumentSnapshot(snapshot))
        .toList();
  }

  Future<Beacon> getBeaconById(String beaconId) async{
    DocumentReference beaconDoc = Firestore.instance.collection('Beacons').document(beaconId);
    DocumentSnapshot docsnap = await beaconDoc.get();
    return new Beacon(
      beaconId: beaconId,
      opportunityId: docsnap.data['opportunityId'],
      latitude: docsnap.data['latitude'],
      longitude: docsnap.data['longitude'],
      issuerId: docsnap.data['issuerId']);
  }

  StreamSubscription watch(Beacon beacon, void onChange(Beacon beacon)) {
    return Firestore.instance
        .collection('Beacons')
        .document(beacon.beaconId)
        .snapshots()
        .listen((snapshot) => onChange(_fromDocumentSnapshot(snapshot)));
  }

  Beacon _fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data;

    return new Beacon(
      beaconId: data['beaconId'],
      opportunityId: data['opportunityId'],
      latitude: data['latitude'],
      longitude: data['longitude'],
      issuerId: data['issuerId']);
  }
}

class ParticipantApi{
  Future<List<Participant>> getAllAdress() async {
    return (await Firestore.instance.collection('Participants').getDocuments())
        .documents
        .map((snapshot) => _fromDocumentSnapshot(snapshot))
        .toList();
  }

  Future<Participant> getParticipantById(String participantId) async{
    DocumentReference participantDoc = Firestore.instance.collection('Participants').document(participantId);
    DocumentSnapshot docsnap = await participantDoc.get();
    return new Participant(
      participantId,
      docsnap.data['name'],
      docsnap.data['password'],
      docsnap.data['institute'],
      docsnap.data['education'],
      docsnap.data['birthday']
      );
  }

  StreamSubscription watch(Participant participant, void onChange(Participant participant)) {
    return Firestore.instance
        .collection('Participants')
        .document(participant.userId)
        .snapshots()
        .listen((snapshot) => onChange(_fromDocumentSnapshot(snapshot)));
  }

  Participant _fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data;

    return new Participant(
      data['participantId'],
      data['name'],
      data['password'],
      data['institute'],
      data['education'],
      data['birthday']);
  }
}

class IssuerApi{
  Future<List<Issuer>> getAllAdress() async {
    return (await Firestore.instance.collection('Issuers').getDocuments())
        .documents
        .map((snapshot) => _fromDocumentSnapshot(snapshot))
        .toList();
  }

  Future<Issuer> getIssuerById(String issuerId) async{
    DocumentReference issuerDoc = Firestore.instance.collection('Issuers').document(issuerId);
    DocumentSnapshot docsnap = await issuerDoc.get();
    return new Issuer(
      issuerId,
      docsnap.data['name'],
      docsnap.data['password'],
      docsnap.data['institution'],
      docsnap.data['phoneNumber'],
      docsnap.data['urlWebsite'],
      docsnap.data['urlWebsite'],
      docsnap.data['adresId']
      );
  }

  StreamSubscription watch(Issuer issuer, void onChange(Issuer issuer)) {
    return Firestore.instance
        .collection('Issuers')
        .document(issuer.userId)
        .snapshots()
        .listen((snapshot) => onChange(_fromDocumentSnapshot(snapshot)));
  }

  Issuer _fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data;

    return new Issuer(
      data['issuerId'],
      data['name'],
      data['password'],
      data['institution'],
      data['phoneNumber'],
      data['urlWebsite'],
      data['urlWebsite'],
      data['adresId']);
  }
}

class OpportunityApi {
  Future<List<Opportunity>> getAllOpportunities() async {
    return (await Firestore.instance.collection('Opportunities').getDocuments())
        .documents
        .map((snapshot) => _fromDocumentSnapshot(snapshot))
        .toList();
  }

  Future<Opportunity> getOpportunityById(String opportunityId) async {
    return _fromDocumentSnapshot(await Firestore.instance
        .collection("Opportunities")
        .document(opportunityId)
        .get());
  }

  Opportunity _fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data;
    Adress adres = new Adress(adresId: "", street: data['street'], postalcode: data['postalCode'], city: data['city'], housenumber: data['housenumber']);

    return new Opportunity(
      opportunityId: snapshot.documentID,
      title: data['name'],
      difficulty: _dataToDifficulty(data['difficulty']),
      category: _dataToCategory(data['category']),
      badge: new Badge(data['badgeImageUrl']),
      opportunityImageUrl: data['oppImageUrl'],
      shortDescription: data['shortDescription'],
      longDescription: data['longDescription'],
      beginDate: DateTime.parse(data['beginDate']),
      endDate: DateTime.parse(data['endDate']),
      adresId: adres.adresId,
      issuerId: data['issuerName'],
      international: data['international'],
      beacon: data['beaconid']
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

class ParticipationApi {
  Future<List<Participation>> getAllParticipationsFromUser(
      FirebaseUser firebaseUser) async {
    return (await Firestore.instance
            .collection('Participations')
            .where("participantId", isEqualTo: firebaseUser.uid)
            .getDocuments())
        .documents
        .map((snapshot) => _fromDocumentSnapshotParticipation(snapshot))
        .toList();
  }

  Participation _fromDocumentSnapshotParticipation(DocumentSnapshot snapshot) {
    final data = snapshot.data;

    return new Participation(
      participationId: snapshot.documentID,
      participantId: data['participantId'],
      opportunityId: data['opportunityId'],
      reason: data['reason'],
      status: _dataToStatus(data['status']),
    );
  }

  Future<bool> participationExists(FirebaseUser firebaseUser, Opportunity opportunity) async {
    return (await Firestore.instance.collection('Participations').where("participantId", isEqualTo: firebaseUser.uid).where("opportunityId", isEqualTo: opportunity.opportunityId).getDocuments()).documents.length != 0;
  }

  Status _dataToStatus(int status) {
    switch (status) {
      case 0:
        return Status.PENDING;
      case 1:
        return Status.APPROVED;
      case 2:
        return Status.REFUSED;
    }
    return Status.PENDING;
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
