import 'package:Gentle_Student/models/category.dart';
import 'package:Gentle_Student/models/difficulty.dart';
import 'package:meta/meta.dart';

//This model represents an opportunity
class Opportunity {
  //Declaration of the variables
  String opportunityId;
  String title;
  Difficulty difficulty;
  Category category;
  String opportunityImageUrl;
  String shortDescription;
  String longDescription;
  DateTime beginDate;
  DateTime endDate;
  bool international;
  bool blocked;
  String addressId;
  String badgeId;
  String issuerId;

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
  });
}
