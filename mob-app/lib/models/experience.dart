import 'package:cloud_firestore/cloud_firestore.dart';

class Experience {
  final String experienceId;
  final String title;
  final String shortText;
  final String longText;
  final String author;
  final DateTime published;
  final String imageUrl;

  Experience({
    this.experienceId,
    this.title,
    this.shortText,
    this.longText,
    this.author,
    this.published,
    this.imageUrl,
  });

  static Experience fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data;

    return new Experience(
        experienceId: snapshot.documentID,
        title: data['title'],
        shortText: data['shortText'],
        longText: data['longText'],
        author: data['author'],
        published: DateTime.parse(data['published']),
        imageUrl: data['imageUrl']);
  }
}
