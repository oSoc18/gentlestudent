import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import '../models/user.dart';

//This file is for storing the credentials of the user in a local database
//so they only have to enter their email and password once
class DatabaseHelper {

  //Using the Singleton design pattern
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
  
  //Create the local database the first time the user launches the app
  void _onCreate(Database db, int version) async {
    await db.execute(
    "CREATE TABLE User(id INTEGER PRIMARY KEY, username TEXT, password TEXT)");

    print("Created table User");
  }

  //Save user to the datbase
  Future<int> saveUser(User user) async {
    var dbClient = await db;
    int res = await dbClient.insert("User", user.toMap());
    return res;
  }

  //Update the user in the database
  Future<int> updateUser(User user) async {
    var dbClient = await db;
    int res = await dbClient.update("User", user.toMap());
    return res;
  }

  //Delete the user in the database
  Future<int> deleteUser() async {
    var dbClient = await db;
    int res = await dbClient.delete("User");
    return res;
  }

  //Get the user int the database
  Future<User> getUser() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query("User",
      columns: ["username", "password"]);
    if (maps.length > 0)
      return new User.map(maps.first);
    return null;
  }

}