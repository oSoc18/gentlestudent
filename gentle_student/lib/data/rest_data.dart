import 'dart:async';

import 'package:Gentle_Student/models/badge.dart';
import 'package:Gentle_Student/utils/network_util.dart';
import 'package:Gentle_Student/models/user.dart';

//This class is a Singleton that handles REST API
class RestDatasource {
  //Creating the Singleton
  static RestDatasource _instance = new RestDatasource.internal();
  RestDatasource.internal();
  factory RestDatasource() => _instance;

  NetworkUtil _netUtil = new NetworkUtil();
  static final BASE_URL = "https://api.badgr.io/";
  static final LOGIN_URL = BASE_URL + "api-auth/token";

  //login expects token as return
  Future<String> login(String username, String password) {
    return _netUtil.post(LOGIN_URL, body: {
      "username": username,
      "password": password
    }).then((dynamic res) {
      // print(res.toString());
      if(res["error"]) throw new Exception(res["error_msg"]);
      return res.toString();
    });
  }
}