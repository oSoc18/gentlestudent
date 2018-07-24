import 'package:meta/meta.dart';

class News{
  final String newsId;
  final String title;
  final String shortText;
  final String longText;
  final String author;
  final DateTime published;
  final String imageUrl;

  News({
    @required this.newsId,
    @required this.title,
    @required this.shortText,
    @required this.longText,
    @required this.author,
    @required this.published,
    @required this.imageUrl,
  });
}