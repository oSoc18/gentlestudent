

//This class is a Singleton that handles REST API
class RestData {
  //Creating the Singleton
  static RestData _instance = new RestData.internal();
  RestData.internal();
  factory RestData() => _instance;

  //The URL used in every CRUD operation
  static const String BASE_URL = "";
}
