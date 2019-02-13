import 'package:Gentle_Student/models/authority.dart';
import 'package:Gentle_Student/models/category.dart';
import 'package:Gentle_Student/models/difficulty.dart';
import 'package:Gentle_Student/utils/firebase_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Opportunity {
  final String opportunityId;
  final String title;
  final Difficulty difficulty;
  final Category category;
  final String opportunityImageUrl;
  final String shortDescription;
  final String longDescription;
  final DateTime beginDate;
  final DateTime endDate;
  final bool international;
  final String addressId;
  final String badgeId;
  final String issuerId;
  final String pinImageUrl;
  final int participations;
  final Authority authority;
  final String contact;
  final String website;

  Opportunity({
    this.opportunityId,
    this.title,
    this.difficulty,
    this.category,
    this.opportunityImageUrl,
    this.shortDescription,
    this.longDescription,
    this.beginDate,
    this.endDate,
    this.international,
    this.addressId,
    this.badgeId,
    this.issuerId,
    this.pinImageUrl,
    this.participations,
    this.authority,
    this.contact,
    this.website,
  });

  static Opportunity fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data;

    return new Opportunity(
      opportunityId: snapshot.documentID,
      beginDate: DateTime.parse(data['beginDate']),
      category: FirebaseUtils.dataToCategory(data['category']),
      difficulty: FirebaseUtils.dataToDifficulty(data['difficulty']),
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
      authority: FirebaseUtils.dataToAuthority(data['authority']),
      contact: data['contact'],
      website: data['website'],
    );
  }
}
