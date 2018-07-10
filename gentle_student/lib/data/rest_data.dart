import 'dart:async';

import 'package:Gentle_Student/utils/network_util.dart';
import 'package:Gentle_Student/models/user.dart';

//This class is a Singleton that handles REST API
class RestData {
  //Creating the Singleton
  static RestData _instance = new RestData.internal();
  RestData.internal();
  factory RestData() => _instance;

  //The URL used in every CRUD operation
  static const String BASE_URL = "";
}

class RestDatasource {
  NetworkUtil _netUtil = new NetworkUtil();
  static final BASE_URL = "https://api.badgr.io/";
  static final LOGIN_URL = BASE_URL + "api-auth/token";
  static final _API_KEY = "somerandomkey";

  Future<User> login(String username, String password) {
    return _netUtil.post(LOGIN_URL, body: {
      "token": _API_KEY,
      "username": username,
      "password": password
    }).then((dynamic res) {
      print(res.toString());
      if(res["error"]) throw new Exception(res["error_msg"]);
      return new User.map(res["user"]);
    });
  }
}