import 'package:cloud_firestore/cloud_firestore.dart';

class News {
  final String newsId;
  final String title;
  final String shortText;
  final String longText;
  final String author;
  final DateTime published;
  final String imageUrl;

  News({
    this.newsId,
    this.title,
    this.shortText,
    this.longText,
    this.author,
    this.published,
    this.imageUrl,
  });

  static News fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data;

    return new News(
        newsId: snapshot.documentID,
        title: data['title'],
        shortText: data['shortText'],
        longText: data['longText'],
        author: data['author'],
        published: DateTime.parse(data['published']),
        imageUrl: data['imageUrl']);
  }
}
