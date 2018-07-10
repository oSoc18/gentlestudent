import 'package:Gentle_Student/models/category.dart';
import 'package:Gentle_Student/models/difficulty.dart';

//This model represents an opportunity
class Opportunity {
  
  //Declaration of the variables
  int opportunityId;
  String name;
  Difficulty difficulty;
  Category category;
  String description;
  DateTime beginDate;
  DateTime endDate;
  String address;
  int postalCode;
  String city;
  String issuerName;

  Opportunity(int _opportunityId, String _name, Difficulty _difficulty, Category _category, String _issuerName) {
    this.opportunityId = _opportunityId;
    name = _name;
    difficulty = _difficulty;
    category = _category;
    issuerName = _issuerName;
  }
}