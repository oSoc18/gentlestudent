import 'package:meta/meta.dart';

class Participant {
  final String participantId;
  final String email;
  final String name;
  final String institute;
  final String education;
  final DateTime birthdate;

  Participant({
    @required this.participantId,
    @required this.institute,
    @required this.email,
    @required this.education,
    @required this.name,
    @required this.birthdate,
  });
}

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