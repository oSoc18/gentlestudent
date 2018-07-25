import 'package:meta/meta.dart';

//This model represents a news article
class News{

  //Declaration of the variables
  final String newsId;
  final String title;
  final String shortText;
  final String longText;
  final String author;
  final DateTime published;
  final String imageUrl;

  //Constructor
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