import 'dart:async';
import 'dart:io' as io;

import 'package:Gentle_Student/models/user_token.dart';
import 'package:path/path.dart';
import 'package:Gentle_Student/models/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  static Database _db;

  Future<Database> get db async {
    if(_db != null)
      return _db;
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "main.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }
  

  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute(
    "CREATE TABLE User(id INTEGER PRIMARY KEY, username TEXT, password TEXT)");
    print("Created tables");
  }

  Future<int> saveUser(User user) async {
    var dbClient = await db;
    int res = await dbClient.insert("User", user.toMap());
    return res;
  }

  Future<int> saveUserToken(UserToken userToken) async {
    var dbClient = await db;
    int res = await dbClient.insert("UserToken", userToken.toMap());
    return res;
  }

  Future<int> deleteUsers() async {
    var dbClient = await db;
    int res = await dbClient.delete("User");
    return res;
  }

  Future<int> deleteUserTokens() async {
    var dbClient = await db;
    int res = await dbClient.delete("UserToken");
    return res;
  }

  // Future<bool> isLoggedIn() async {
  //   var dbClient = await db;
  //   var res = await dbClient.query("User");
  //   return res.length > 0? true: false;
  // }

  Future<String> getToken() async {
    var dbClient = await db;
    var res = await dbClient.query("UserToken");
    String token = res[0]["Token"];
    return token;
  }

}