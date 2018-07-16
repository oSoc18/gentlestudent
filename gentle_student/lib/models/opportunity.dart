import 'package:Gentle_Student/models/category.dart';
import 'package:Gentle_Student/models/difficulty.dart';
import 'package:meta/meta.dart';

//This model represents an opportunity
class Opportunity {
  
  //Declaration of the variables
  final String opportunityId;
  final String name;
  final Difficulty difficulty;
  final Category category;
  final String badgeImageUrl;
  final String opportunityImageUrl;
  final String shortDescription;
  final String longDescription;
  final DateTime beginDate;
  final DateTime endDate;
  final String street;
  final int postalCode;
  final String city;
  final String issuerName;

  Opportunity({
    @required this.opportunityId,
    @required this.name,
    @required this.difficulty,
    @required this.category,
    @required this.badgeImageUrl,
    @required this.opportunityImageUrl,
    @required this.shortDescription,
    @required this.longDescription,
    @required this.beginDate,
    @required this.endDate,
    @required this.street,
    @required this.postalCode,
    @required this.city,
    @required this.issuerName,
  });
  
}