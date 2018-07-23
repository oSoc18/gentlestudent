import 'package:meta/meta.dart';

//This model represents a badge a participant has earned
class Assertion {
  
  //Declaration of the variables
  final String assertionId;
  final String openBadgeId;
  final String participantId;
  final DateTime issuedOn;

  Assertion({
    @required this.assertionId,
    @required this.openBadgeId,
    @required this.participantId,
    @required this.issuedOn,
  });
  
}