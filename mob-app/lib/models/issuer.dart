import 'package:cloud_firestore/cloud_firestore.dart';

class Issuer {
  final String issuerId;
  final String addressId;
  final String email;
  final String institution;
  final String name;
  final String phonenumber;
  final String url;

  Issuer({
    this.issuerId,
    this.addressId,
    this.email,
    this.institution,
    this.name,
    this.phonenumber,
    this.url,
  });

  static Issuer fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data;

    return new Issuer(
        issuerId: snapshot.documentID,
        addressId: data['addressId'],
        email: data['email'],
        institution: data['institution'],
        name: data['name'],
        phonenumber: data['phonenumber'],
        url: data['url']);
  }
}
