import 'package:cloud_firestore/cloud_firestore.dart';

class Badge {
  final String openBadgeId;
  final String image;
  final String description;

  Badge({
    this.openBadgeId,
    this.image,
    this.description,
  });

  static Badge fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data;

    return new Badge(
      openBadgeId: snapshot.documentID,
      image: data['image'],
      description: data['description'],
    );
  }
}
