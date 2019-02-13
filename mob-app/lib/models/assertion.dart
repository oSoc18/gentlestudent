import 'package:cloud_firestore/cloud_firestore.dart';

class Assertion {
  final String assertionId;
  final String openBadgeId;
  final String participantId;
  final DateTime issuedOn;

  Assertion({
    this.assertionId,
    this.openBadgeId,
    this.participantId,
    this.issuedOn,
  });

  static Assertion fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data;

    return new Assertion(
      assertionId: snapshot.documentID,
      openBadgeId: data['badgeId'],
      participantId: data['recipientId'],
      issuedOn: DateTime.parse(data['issuedOn']),
    );
  }
}
