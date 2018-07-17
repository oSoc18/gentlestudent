import 'package:meta/meta.dart';

class Adress{
  String adresId;
  String street;
  int housenumber;
  int postalcode;
  String city;
  String bus;

  Adress({
    @required this.adresId,
    @required this.street,
    @required this.city,
    @required this.postalcode,
    @required this.housenumber,
  }){
    this.bus = bus;
  }
}