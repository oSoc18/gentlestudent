import 'package:Gentle_Student/models/status.dart';
import 'package:meta/meta.dart';

//This model represents a participation
class Participation {

  //Declaration of the variables
  final String participationId;
  final String participantId;
  final String opportunityId;
  final String reason;
  final Status status;

  //Constructor
  Participation({
    @required this.participationId,
    @required this.participantId,
    @required this.opportunityId,
    @required this.reason,
    @required this.status,
  });
}
