import 'package:meta/meta.dart';

class Experience {
  final String experienceId;
  final String title;
  final String shortText;
  final String longText;
  final String author;
  final DateTime published;
  final String imageUrl;

  Experience({
    @required this.experienceId,
    @required this.title,
    @required this.shortText,
    @required this.longText,
    @required this.author,
    @required this.published,
    @required this.imageUrl,
  });
}
