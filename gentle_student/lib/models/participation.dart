import 'package:Gentle_Student/models/status.dart';
import 'package:meta/meta.dart';

//This model represents an participation
class Participation {
  //Declaration of the variables
  final String participationId;
  final String participantId;
  final String opportunityId;
  final String reason;
  final Status status;

  Participation({
    @required this.participationId,
    @required this.participantId,
    @required this.opportunityId,
    @required this.reason,
    @required this.status,
  });
}
