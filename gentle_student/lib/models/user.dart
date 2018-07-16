import 'package:meta/meta.dart';

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
}

class Participant extends User{
  
}

class Issuer extends User{

}