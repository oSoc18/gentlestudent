import 'dart:async';
import 'dart:collection';
import 'package:Gentle_Student/models/address.dart';
import 'package:Gentle_Student/models/assertion.dart';
import 'package:Gentle_Student/models/authority.dart';
import 'package:Gentle_Student/models/badge.dart';
import 'package:Gentle_Student/models/beacon.dart';
import 'package:Gentle_Student/models/category.dart';
import 'package:Gentle_Student/models/difficulty.dart';
import 'package:Gentle_Student/models/experience.dart';
import 'package:Gentle_Student/models/issuer.dart';
import 'package:Gentle_Student/models/news.dart';
import 'package:Gentle_Student/models/opportunity.dart';
import 'package:Gentle_Student/models/participant.dart';
import 'package:Gentle_Student/models/participation.dart';
import 'package:Gentle_Student/models/status.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

//This file is for all communication with the database
//Every model has an API
//All functions return Futures because everything database related happens asynchronous

//OPPORTUNITIES
class OpportunityApi {
  //Get all opportunities
  Future<List<Opportunity>> getAllOpportunities() async {
    return (await Firestore.instance
            .collection('Opportunities')
            .where("authority", isEqualTo: 1)
            .getDocuments())
        .documents
        .map((snapshot) => _fromDocumentSnapshot(snapshot))
        .toList();
  }

  //Get an opportunity by opportunityId
  Future<Opportunity> getOpportunityById(String opportunityId) async {
    return _fromDocumentSnapshot(await Firestore.instance
        .collection("Opportunities")
        .document(opportunityId)
        .get());
  }

  //Get an opportunity by beaconId
  Future<Opportunity> getOpportunityByBeaconId(String beaconId) async {
    return _fromDocumentSnapshot((await Firestore.instance
            .collection("Opportunities")
            .where("beaconId", isEqualTo: beaconId)
            .getDocuments())
        .documents
        .first);
  }

  //Get an opportunity by badgeId
  Future<Opportunity> getOpportunityByBadgeId(String badgeId) async {
    return _fromDocumentSnapshot((await Firestore.instance
            .collection("Opportunities")
            .where("badgeId", isEqualTo: badgeId)
            .getDocuments())
        .documents
        .first);
  }

  //Update opportunity after participation creation.
  Future<Null> updateOpportunityAfterParticipationCreation(
      Opportunity opportunity, int participations) async {
    Map<String, int> data = <String, int>{
      "participations": participations + 1,
    };
    await Firestore.instance
        .collection("Opportunities")
        .document(opportunity.opportunityId)
        .updateData(data)
        .whenComplete(() {
      print("Opportunity updated");
    }).catchError((e) => print(e));
  }

  //Create an opportunity from a DocumentSnapshot of the Firebase
  //Basically turning JSON code into an Opportunity object
  Opportunity _fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data;

    return new Opportunity(
      opportunityId: snapshot.documentID,
      beginDate: DateTime.parse(data['beginDate']),
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
      pinImageUrl: data['pinImageUrl'],
      participations: data['participations'],
      authority: _dataToAuthority(data['authority']),
      contact: data['contact'],
      website: data['website'],
    );
  }

  //Function for turning the Integer in the database into a Difficulty
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

  //Function for turning the Integer in the database into an Authority
  Authority _dataToAuthority(int authority) {
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

  //Function for turning the Integer in the database into a Category
  Category _dataToCategory(int category) {
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
}
//This is the end of the OpportunityApi
//All the other APIs are very similar so I didn't document them
//If you understand the OpportunityApi, you will understand all the other APIs

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

  Future<Null> updateParticipationAfterBadgeClaim(
      Participation participation, String message) async {
    Map<String, dynamic> data = <String, dynamic>{
      "status": 1,
      "message": message,
    };
    await Firestore.instance
        .collection("Participations")
        .document(participation.participationId)
        .updateData(data)
        .whenComplete(() {
      print("Participation updated");
    }).catchError((e) => print(e));
  }

  Future<Participation> getParticipantByUserAndOpportunity(
      FirebaseUser firebaseUser, Opportunity opportunity) async {
    return _fromDocumentSnapshotParticipation((await Firestore.instance
            .collection('Participations')
            .where("participantId", isEqualTo: firebaseUser.uid)
            .where("opportunityId", isEqualTo: opportunity.opportunityId)
            .getDocuments())
        .documents
        .first);
  }

  Status _dataToStatus(int status) {
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

  Future<Null> changeFavorites(String participantId, List<String> likes) async {
    Map<String, List<String>> data = <String, List<String>>{
      "favorites": likes,
    };
    await Firestore.instance
        .collection("Participants")
        .document(participantId)
        .updateData(data)
        .whenComplete(() {})
        .catchError((e) => print(e));
  }

  Participant _fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data;

    List<dynamic> listDynamic = data['favorites'];
    List<String> listStrings = new List();
    listDynamic.forEach((d) => listStrings.add(d));

    return new Participant(
        participantId: snapshot.documentID,
        name: data['name'],
        institute: data['institute'],
        email: data['email'],
        profilePicture: data['profilePicture'],
        favorites: listStrings);
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
      street: data['street'],
      latitude: data['latitude'],
      longitude: data['longitude'],
    );
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

  Future<IBeacon> getBeaconById(String major, String minor) async {
    return _fromDocumentSnapshot((await Firestore.instance
            .collection('Beacons')
            .where("major", isEqualTo: major)
            .where("minor", isEqualTo: minor)
            .getDocuments())
        .documents
        .first);
  }

  IBeacon _fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data;

    return new IBeacon(
      beaconId: snapshot.documentID,
      addressId: data['addressId'],
      major: data['major'],
      minor: data['minor'],
      name: data['name'],
      opportunities:
          new LinkedHashMap<String, bool>.from(data['opportunities']),
      range: data['range'],
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
