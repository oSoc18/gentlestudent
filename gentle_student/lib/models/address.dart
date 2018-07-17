import 'package:meta/meta.dart';

class Address{
  String addressId;
  String street;
  int housenumber;
  int postalcode;
  String city;
  String bus;

  Address({
    @required this.addressId,
    @required this.street,
    @required this.city,
    @required this.postalcode,
    @required this.housenumber,
    @required this.bus,
  });
}