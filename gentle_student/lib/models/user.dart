import 'package:meta/meta.dart';

// class User {
//   String _username;
//   String _password;
//   String _userId;
//   String _kind;
  
//   User(this._username, this._password, this._userId, this._kind);

//   User.map(dynamic obj) {
//     this._username = obj["username"];
//     this._password = obj["password"];
//     this._userId = obj["userId"];
//     this._kind = obj["kind"];
//   }

//   String get username => _username;
//   String get password => _password;
//   String get userId => _userId;
//   String get kind => _kind;

//   Map<String, dynamic> toMap() {
//     var map = new Map<String, dynamic>();
//     map["username"] = _username;
//     map["password"] = _password;
//     map["userId"] = _userId;
//     map["kind"] = _kind;

//     return map;
//   }
// }

class User{
  String userId;
  String name;
  String password;
  String kind;

  User({
    @required this.userId,
    @required this.name,
    @required this.kind,
    @required this.password,
  });

  User.map(dynamic obj) {
    this.name = obj["name"];
    this.password = obj["password"];
    this.userId = obj["userId"];
    this.kind = obj["kind"];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["name"] = name;
    map["password"] = password;
    map["userId"] = userId;
    map["kind"] = kind;
  }
}

class Participant extends User{
  
}

class Issuer extends User{

}