import 'package:Gentle_Student/models/badge.dart';
import 'package:Gentle_Student/models/beacon.dart';
import 'package:Gentle_Student/models/opportunity.dart';
import 'package:meta/meta.dart';

class User{
  String userId;
  String name;
  String password;

  User({
    @required this.userId,
    @required this.name,
    @required this.password,
  });
}

class Participant extends User{
  String institute;
  List<Opportunity> _opportunities;
  List<Badge> _badges;
  String education;
  DateTime birthday;

  Participant(String userId, String name, String password, String institute, String education, DateTime birthday): super(userId: userId,password: password, name:name){
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

class Issuer extends User{
  String institution;
  List<Opportunity> _opportunities;
  List<Beacon> _beacons;
  String urlWebsite;
  String phoneNumber;
  String adresId;
  String signingKey;

  Issuer(String userId, String name, String password, String institution, String phoneNumber, String urlWebsite, String signingKey,  String adresId): super(userId: userId,password: password,name: name){
    this.institution = institution;
    this.urlWebsite = urlWebsite;
    this.phoneNumber = phoneNumber;
    this.adresId = adresId;
    this.signingKey = signingKey;
    this._opportunities = new List<Opportunity>();
    this._beacons = new List<Beacon>();
  }

  void addBeacon(Beacon b){
    if(!_beacons.contains(b)){
      _beacons.add(b);
    }
  }

  void addOpportunity(Opportunity o){
    if(!_opportunities.contains(o)){
      _opportunities.add(o);
    }
  }

  List<Opportunity> getOpportunities(){
    return _opportunities;
  }

  List<Beacon> getBeacons(){
    return _beacons;
  }
}