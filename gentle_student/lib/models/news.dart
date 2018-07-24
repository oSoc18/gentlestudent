import 'package:meta/meta.dart';

class News{
  final String newsId;
  final String title;
  final String shortText;
  final String longText;
  final String authorId;
  final DateTime published;
  final String imageUrl;

  News({
    @required this.newsId,
    @required this.title,
    @required this.shortText,
    @required this.longText,
    @required this.authorId,
    @required this.published,
    @required this.imageUrl,
  });
}