import 'package:meta/meta.dart';

//This model represents an address
class Address{

  //Declaration of the variables
  final String addressId;
  final String street;
  final int housenumber;
  final int postalcode;
  final String city;
  final String bus;

  //Constructor
  Address({
    @required this.addressId,
    @required this.street,
    @required this.city,
    @required this.postalcode,
    @required this.housenumber,
    @required this.bus,
  });
}