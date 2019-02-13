import 'package:cloud_firestore/cloud_firestore.dart';

class Address {
  final String addressId;
  final String street;
  final int housenumber;
  final int postalcode;
  final String city;
  final String bus;
  final double latitude;
  final double longitude;

  Address({
    this.addressId,
    this.street,
    this.city,
    this.postalcode,
    this.housenumber,
    this.bus,
    this.latitude,
    this.longitude,
  });

  static Address fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data;

    return new Address(
      addressId: snapshot.documentID,
      bus: data['bus'],
      city: data['city'],
      housenumber: data['housenumber'],
      postalcode: data['postalcode'],
      street: data['street'],
      latitude: data['latitude'],
      longitude: data['longitude'],
    );
  }
}
