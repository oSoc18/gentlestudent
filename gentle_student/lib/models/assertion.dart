import 'package:meta/meta.dart';

//This model represents a badge as defined by the badgr API
class Assertion {
  
  //Declaration of the variables
  final String entityType;
  final String entityId;
  final String openBadgeId;
  final String createdAt;
  final String createdBy;
  final String badgeclass;
  final String badgeclassOpenBadgeId;
  final String issuer;
  final String issuerOpenBadgeId;
  final String image;
  final dynamic recipient;
  final String issuedOn;
  final String narrative;
  final dynamic evidence;
  final bool revoked;
  final String revocationReason;
  final String expires;
  //Extra variables for Gentlestudent
  final String extensions;

  Assertion({
    @required this.entityType,
    @required this.entityId,
    @required this.openBadgeId,
    @required this.createdAt,
    @required this.createdBy,
    @required this.badgeclass,
    @required this.badgeclassOpenBadgeId,
    @required this.issuer,
    @required this.issuerOpenBadgeId,
    @required this.image,
    @required this.recipient,
    @required this.issuedOn,
    @required this.narrative,
    @required this.evidence,
    @required this.revoked,
    @required this.revocationReason,
    @required this.expires,
    @required this.extensions
  });
  
}