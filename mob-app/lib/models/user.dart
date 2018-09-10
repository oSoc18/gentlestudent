import 'package:meta/meta.dart';

//This file is a bit different because it contains 3 different user types
//We'll go over each of them

//This model represents a user stored in the local database
//So it's a model for saving the login credentials in the local database
class User {

  //Declaration of the variables
  String _username;
  String _password;

  //Constructor
  User(this._username, this._password);

  //Turning a database object into a User object
  User.map(dynamic obj) {
    this._username = obj["username"];
    this._password = obj["password"];
  }

  //Getters
  String get username => _username;
  String get password => _password;

  //Saving the user to the local database
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["username"] = _username;
    map["password"] = _password;

    return map;
  }
}

//This model represents a participant
class Participant {

  //Declaration of the variables
  final String participantId;
  final String email;
  final String name;
  final String institute;
  final String education;
  final String profilePicture;
  final List<String> favorites;

  //Constructor
  Participant({
    @required this.participantId,
    @required this.institute,
    @required this.email,
    @required this.education,
    @required this.name,
    @required this.profilePicture,
    @required this.favorites,
  });
}

//This model repesents an issuer
class Issuer {

  //Declaration of the variables
  final String issuerId;
  final String addressId;
  final String email;
  final String institution;
  final String name;
  final String phonenumber;
  final String url;

  //Constructor
  Issuer({
    @required this.issuerId,
    @required this.addressId,
    @required this.email,
    @required this.institution,
    @required this.name,
    @required this.phonenumber,
    @required this.url,
  });
}
