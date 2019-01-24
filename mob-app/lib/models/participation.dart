import 'package:Gentle_Student/models/status.dart';

class Participation {
  final String participationId;
  final String participantId;
  final String opportunityId;
  final String reason;
  final Status status;

  Participation({
    this.participationId,
    this.participantId,
    this.opportunityId,
    this.reason,
    this.status,
  });
}
