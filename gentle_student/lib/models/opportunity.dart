import 'package:Gentle_Student/models/category.dart';
import 'package:Gentle_Student/models/difficulty.dart';

class Opportunity {
  
  int opportunityId;
  String name;
  Difficulty difficulty;
  Category category;
  DateTime beginDate;
  DateTime endDate;
  String address;
  int postalCode;
  String city;
  String issuer;
}