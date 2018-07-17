import 'package:meta/meta.dart';

class Issuer {
  final String issuerId;
  final String addressId;
  final String email;
  final String institution;
  final String name;
  final String phonenumber;
  final String url;

  Issuer({
    @required this.issuerId,
    @required this.addressId,
    @required this.email,
    @required this.institution,
    @required this.name,
    @required this.phonenumber,
    @required this.url,
  });
}
