import 'dart:async';
import 'package:Gentle_Student/models/address.dart';
import 'package:Gentle_Student/models/assertion.dart';
import 'package:Gentle_Student/models/badge.dart';
import 'package:Gentle_Student/models/beacon.dart';
import 'package:Gentle_Student/models/experience.dart';
import 'package:Gentle_Student/models/issuer.dart';
import 'package:Gentle_Student/models/news.dart';
import 'package:Gentle_Student/models/opportunity.dart';
import 'package:Gentle_Student/models/participant.dart';
import 'package:Gentle_Student/models/participation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OpportunityApi {
  Future<List<Opportunity>> getAllOpportunities() async {
    return (await Firestore.instance
            .collection('Opportunities')
            .where("authority", isEqualTo: 1)
            .getDocuments())
        .documents
        .map((snapshot) => Opportunity.fromDocumentSnapshot(snapshot))
        .toList();
  }

  Future<Opportunity> getOpportunityById(String opportunityId) async {
    return Opportunity.fromDocumentSnapshot(await Firestore.instance
        .collection("Opportunities")
        .document(opportunityId)
        .get());
  }

  Future<Opportunity> getOpportunityByBeaconId(String beaconId) async {
    return Opportunity.fromDocumentSnapshot((await Firestore.instance
            .collection("Opportunities")
            .where("beaconId", isEqualTo: beaconId)
            .getDocuments())
        .documents
        .first);
  }

  Future<Opportunity> getOpportunityByBadgeId(String badgeId) async {
    return Opportunity.fromDocumentSnapshot((await Firestore.instance
            .collection("Opportunities")
            .where("badgeId", isEqualTo: badgeId)
            .getDocuments())
        .documents
        .first);
  }

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
}

class ParticipationApi {
  Future<List<Participation>> getAllParticipationsFromUser(
      FirebaseUser firebaseUser) async {
    return (await Firestore.instance
            .collection('Participations')
            .where("participantId", isEqualTo: firebaseUser.uid)
            .getDocuments())
        .documents
        .map((snapshot) => Participation.fromDocumentSnapshot(snapshot))
        .toList();
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
    return Participation.fromDocumentSnapshot((await Firestore.instance
            .collection('Participations')
            .where("participantId", isEqualTo: firebaseUser.uid)
            .where("opportunityId", isEqualTo: opportunity.opportunityId)
            .getDocuments())
        .documents
        .first);
  }
}

class ParticipantApi {
  Future<List<Participant>> getAllParticipants() async {
    return (await Firestore.instance.collection('Participants').getDocuments())
        .documents
        .map((snapshot) => Participant.fromDocumentSnapshot(snapshot))
        .toList();
  }

  Future<Participant> getParticipantById(String participantId) async {
    return Participant.fromDocumentSnapshot(await Firestore.instance
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
}

class AddressApi {
  Future<List<Address>> getAllAddresses() async {
    return (await Firestore.instance.collection('Addresses').getDocuments())
        .documents
        .map((snapshot) => Address.fromDocumentSnapshot(snapshot))
        .toList();
  }

  Future<Address> getAddressById(String addressId) async {
    return Address.fromDocumentSnapshot(await Firestore.instance
        .collection("Addresses")
        .document(addressId)
        .get());
  }
}

class IssuerApi {
  Future<List<Issuer>> getAllIssuers() async {
    return (await Firestore.instance.collection('Issuers').getDocuments())
        .documents
        .map((snapshot) => Issuer.fromDocumentSnapshot(snapshot))
        .toList();
  }

  Future<Issuer> getIssuerById(String issuerId) async {
    return Issuer.fromDocumentSnapshot(await Firestore.instance
        .collection("Issuers")
        .document(issuerId)
        .get());
  }
}

class BadgeApi {
  Future<List<Badge>> getAllBadges() async {
    return (await Firestore.instance.collection('Badges').getDocuments())
        .documents
        .map((snapshot) => Badge.fromDocumentSnapshot(snapshot))
        .toList();
  }

  Future<Badge> getBadgeById(String badgeId) async {
    return Badge.fromDocumentSnapshot(
        await Firestore.instance.collection("Badges").document(badgeId).get());
  }
}

class BeaconApi {
  Future<List<IBeacon>> getAllBeacons() async {
    return (await Firestore.instance.collection('Beacons').getDocuments())
        .documents
        .map((snapshot) => IBeacon.fromDocumentSnapshot(snapshot))
        .toList();
  }

  Future<IBeacon> getBeaconById(String major, String minor) async {
    return IBeacon.fromDocumentSnapshot((await Firestore.instance
            .collection('Beacons')
            .where("major", isEqualTo: major)
            .where("minor", isEqualTo: minor)
            .getDocuments())
        .documents
        .first);
  }
}

class AssertionApi {
  Future<List<Assertion>> getAllAssertionsFromUser(String participantId) async {
    return (await Firestore.instance
            .collection('Assertions')
            .where("recipientId", isEqualTo: participantId)
            .getDocuments())
        .documents
        .map((snapshot) => Assertion.fromDocumentSnapshot(snapshot))
        .toList();
  }
}

class ExperiencesApi {
  Future<List<Experience>> getAllExperiences() async {
    return (await Firestore.instance.collection('Experiences').getDocuments())
        .documents
        .map((snapshot) => Experience.fromDocumentSnapshot(snapshot))
        .toList();
  }
}

class NewsApi {
  Future<List<News>> getAllNews() async {
    return (await Firestore.instance.collection('News').getDocuments())
        .documents
        .map((snapshot) => News.fromDocumentSnapshot(snapshot))
        .toList();
  }
}
