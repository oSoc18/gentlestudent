import 'package:Gentle_Student/models/user.dart';

class UserToken {
  User _user;
  String _token;
  UserToken(this._user, this._token);

  UserToken.map(dynamic obj) {
    this._user = obj["user"];
    this._token = obj["token"];
  }

  User get user => _user;
  String get token => _token;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["user"] = _user;
    map["token"] = _token;

    return map;
  }
}