import 'dart:async';

import 'package:Gentle_Student/models/address.dart';
import 'package:Gentle_Student/models/assertion.dart';
import 'package:Gentle_Student/models/badge.dart';
import 'package:Gentle_Student/models/beacon.dart';
import 'package:Gentle_Student/models/category.dart';
import 'package:Gentle_Student/models/difficulty.dart';
import 'package:Gentle_Student/models/experience.dart';
import 'package:Gentle_Student/models/news.dart';
import 'package:Gentle_Student/models/opportunity.dart';
import 'package:Gentle_Student/models/participation.dart';
import 'package:Gentle_Student/models/status.dart';
import 'package:Gentle_Student/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

//OPPORTUNITIES
class OpportunityApi {
  Future<List<Opportunity>> getAllOpportunities() async {
    return (await Firestore.instance
            .collection('Opportunities')
            .where("blocked", isEqualTo: false)
            .getDocuments())
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

  Future<Opportunity> getOpportunityByBeaconId(String beaconId) async {
    return _fromDocumentSnapshot((await Firestore.instance
            .collection("Opportunities")
            .where("beaconId", isEqualTo: beaconId)
            .getDocuments())
        .documents
        .first);
  }

  Future<Opportunity> getOpportunityByBadgeId(String badgeId) async {
    return _fromDocumentSnapshot((await Firestore.instance
            .collection("Opportunities")
            .where("badgeId", isEqualTo: badgeId)
            .getDocuments())
        .documents
        .first);
  }

  Opportunity _fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data;

    return new Opportunity(
      opportunityId: snapshot.documentID,
      beginDate: DateTime.parse(data['beginDate']),
      blocked: data['blocked'],
      category: _dataToCategory(data['category']),
      difficulty: _dataToDifficulty(data['difficulty']),
      endDate: DateTime.parse(data['endDate']),
      international: data['international'],
      issuerId: data['issuerId'],
      longDescription: data['longDescription'],
      opportunityImageUrl: data['oppImageUrl'],
      shortDescription: data['shortDescription'],
      title: data['title'],
      addressId: data['addressId'],
      badgeId: data['badgeId'],
      latitude: data['latitude'],
      longitude: data['longitude'],
      pinImageUrl: data['pinImageUrl'],
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

//PARTICIPATIONS
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

  Future<bool> participationExists(
      FirebaseUser firebaseUser, Opportunity opportunity) async {
    return (await Firestore.instance
                .collection('Participations')
                .where("participantId", isEqualTo: firebaseUser.uid)
                .where("opportunityId", isEqualTo: opportunity.opportunityId)
                .getDocuments())
            .documents
            .length !=
        0;
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

//PARTICIPANTS
class ParticipantApi {
  Future<List<Participant>> getAllParticipant() async {
    return (await Firestore.instance.collection('Participants').getDocuments())
        .documents
        .map((snapshot) => _fromDocumentSnapshot(snapshot))
        .toList();
  }

  Future<Participant> getParticipantById(String participantId) async {
    return _fromDocumentSnapshot(await Firestore.instance
        .collection("Participants")
        .document(participantId)
        .get());
  }

  Future<Null> changeProfilePicture(
      String participantId, String profilePicture) async {
    Map<String, String> data = <String, String>{
      "profilePicture": profilePicture,
    };
    await Firestore.instance
        .collection("Participants")
        .document(participantId)
        .updateData(data)
        .whenComplete(() {
      print("Profile picture changed");
    }).catchError((e) => print(e));
  }

  Participant _fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data;

    return new Participant(
        participantId: snapshot.documentID,
        name: data['name'],
        institute: data['institute'],
        education: data['education'],
        email: data['email'],
        birthdate: DateTime.parse(data['birthdate']),
        profilePicture: data['profilePicture']);
  }
}

//ADDRESSES
class AddressApi {
  Future<List<Address>> getAllAddresses() async {
    return (await Firestore.instance.collection('Addresses').getDocuments())
        .documents
        .map((snapshot) => _fromDocumentSnapshot(snapshot))
        .toList();
  }

  Future<Address> getAddressById(String addressId) async {
    return _fromDocumentSnapshot(await Firestore.instance
        .collection("Addresses")
        .document(addressId)
        .get());
  }

  Address _fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data;

    return new Address(
        addressId: snapshot.documentID,
        bus: data['bus'],
        city: data['city'],
        housenumber: data['housenumber'],
        postalcode: data['postalcode'],
        street: data['street']);
  }
}

//ISSUERS
class IssuerApi {
  Future<List<Issuer>> getAllIssuers() async {
    return (await Firestore.instance.collection('Issuers').getDocuments())
        .documents
        .map((snapshot) => _fromDocumentSnapshot(snapshot))
        .toList();
  }

  Future<Issuer> getIssuerById(String issuerId) async {
    return _fromDocumentSnapshot(await Firestore.instance
        .collection("Issuers")
        .document(issuerId)
        .get());
  }

  Issuer _fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data;

    return new Issuer(
        issuerId: snapshot.documentID,
        addressId: data['addressId'],
        email: data['email'],
        institution: data['institution'],
        name: data['name'],
        phonenumber: data['phonenumber'],
        url: data['url']);
  }
}

//BADGES
class BadgeApi {
  Future<List<Badge>> getAllBadges() async {
    return (await Firestore.instance.collection('Badges').getDocuments())
        .documents
        .map((snapshot) => _fromDocumentSnapshot(snapshot))
        .toList();
  }

  Future<Badge> getBadgeById(String badgeId) async {
    return _fromDocumentSnapshot(
        await Firestore.instance.collection("Badges").document(badgeId).get());
  }

  Badge _fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data;

    return new Badge(
      openBadgeId: snapshot.documentID,
      image: data['image'],
      description: data['description'],
    );
  }
}

//BEACONS
class BeaconApi {
  Future<List<IBeacon>> getAllBeacons() async {
    return (await Firestore.instance.collection('Beacons').getDocuments())
        .documents
        .map((snapshot) => _fromDocumentSnapshot(snapshot))
        .toList();
  }

  Future<IBeacon> getBeaconById(String beaconId) async {
    return _fromDocumentSnapshot(await Firestore.instance
        .collection("Beacons")
        .document(beaconId)
        .get());
  }

  IBeacon _fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data;

    return new IBeacon(
      beaconId: snapshot.documentID,
      opportunityId: data['opportunityId'],
    );
  }
}

//ASSERTIONS
class AssertionApi {
  Future<List<Assertion>> getAllAssertionsFromUser(String participantId) async {
    return (await Firestore.instance
            .collection('Assertions')
            .where("recipientId", isEqualTo: participantId)
            .getDocuments())
        .documents
        .map((snapshot) => _fromDocumentSnapshot(snapshot))
        .toList();
  }

  Assertion _fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data;

    return new Assertion(
      assertionId: snapshot.documentID,
      openBadgeId: data['badgeId'],
      participantId: data['recipientId'],
      issuedOn: DateTime.parse(data['issuedOn']),
    );
  }
}

//EXPERIENCES
class ExperiencesApi {
  Future<List<Experience>> getAllExperiences() async {
    return (await Firestore.instance.collection('Experiences').getDocuments())
        .documents
        .map((snapshot) => _fromDocumentSnapshot(snapshot))
        .toList();
  }

  Experience _fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data;

    return new Experience(
        experienceId: snapshot.documentID,
        title: data['title'],
        shortText: data['shortText'],
        longText: data['longText'],
        author: data['author'],
        published: DateTime.parse(data['published']),
        imageUrl: data['imageUrl']);
  }
}

//NEWS
class NewsApi {
  Future<List<News>> getAllNews() async {
    return (await Firestore.instance.collection('News').getDocuments())
        .documents
        .map((snapshot) => _fromDocumentSnapshot(snapshot))
        .toList();
  }

  News _fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data;

    return new News(
        newsId: snapshot.documentID,
        title: data['title'],
        shortText: data['shortText'],
        longText: data['longText'],
        author: data['author'],
        published: DateTime.parse(data['published']),
        imageUrl: data['imageUrl']);
  }
}
