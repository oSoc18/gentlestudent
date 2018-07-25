import 'package:Gentle_Student/models/category.dart';
import 'package:Gentle_Student/models/difficulty.dart';
import 'package:meta/meta.dart';

//This model represents an opportunity
class Opportunity {

  //Declaration of the variables
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
  final bool blocked;
  final String addressId;
  final String badgeId;
  final String issuerId;
  final double latitude;
  final double longitude;
  final String pinImageUrl;

  //Constructor
  Opportunity({
    @required this.opportunityId,
    @required this.title,
    @required this.difficulty,
    @required this.category,
    @required this.opportunityImageUrl,
    @required this.shortDescription,
    @required this.longDescription,
    @required this.beginDate,
    @required this.endDate,
    @required this.international,
    @required this.blocked,
    @required this.addressId,
    @required this.badgeId,
    @required this.issuerId,
    @required this.latitude,
    @required this.longitude,
    @required this.pinImageUrl,
  });
}
