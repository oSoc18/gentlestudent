import 'package:Gentle_Student/models/status.dart';
import 'package:Gentle_Student/utils/firebase_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  static Participation fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data;

    return new Participation(
      participationId: snapshot.documentID,
      participantId: data['participantId'],
      opportunityId: data['opportunityId'],
      reason: data['reason'],
      status: FirebaseUtils.dataToStatus(data['status']),
    );
  }
}
