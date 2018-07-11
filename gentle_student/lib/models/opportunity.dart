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
  String description;
  DateTime beginDate;
  DateTime endDate;
  String address;
  int postalCode;
  String city;
  final String issuerName;

  Opportunity({
    @required this.opportunityId,
    @required this.name,
    @required this.difficulty,
    @required this.category,
    @required this.issuerName,
  });

  @override
  String toString() {
    return "Opportunity $opportunityId is named $name";
  }
}