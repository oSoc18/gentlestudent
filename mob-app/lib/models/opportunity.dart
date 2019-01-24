import 'package:Gentle_Student/models/authority.dart';
import 'package:Gentle_Student/models/category.dart';
import 'package:Gentle_Student/models/difficulty.dart';

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
}
