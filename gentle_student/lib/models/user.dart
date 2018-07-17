import 'package:Gentle_Student/models/badge.dart';
import 'package:Gentle_Student/models/opportunity.dart';
import 'package:meta/meta.dart';

class User{
  String userId;
  String name;
  String email;

  User({
    @required this.userId,
    @required this.name,
    @required this.email,
  });
}

class Participant extends User{
  String institute;
  List<Opportunity> _opportunities;
  List<Badge> _badges;
  String education;
  DateTime birthday;

  Participant(String userId, String name, String email, String institute, String education, DateTime birthday): super(userId: userId, email: email, name:name){
    this.institute = institute;
    this.education = education;
    this.birthday = birthday;
    this._opportunities = new List<Opportunity>();
    this._badges = new List<Badge>();
  }

  void addBadge(Badge b){
    if(_badges.contains(b)){
      _badges.add(b);
    }
  }

  List<Badge> getBadges(){
    return _badges;
  }

  void addOpportunity(Opportunity o){
    if(_opportunities.contains(o)){
      _opportunities.add(o);
    }
  }

  List<Opportunity> getOpportunities(){
    return _opportunities;
  }
}

class IssuerM extends User{
  String institution;
  String urlWebsite;
  String phoneNumber;
  String adresId;
  String signingKey;

  IssuerM(String userId, String name, String email, String institution, String phoneNumber, String urlWebsite, String signingKey,  String adresId): super(userId: userId,email: email,name: name){
    this.institution = institution;
    this.urlWebsite = urlWebsite;
    this.phoneNumber = phoneNumber;
    this.adresId = adresId;
    this.signingKey = signingKey;
  }
}