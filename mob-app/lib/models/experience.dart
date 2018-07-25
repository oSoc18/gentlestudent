import 'package:meta/meta.dart';

//This model represents an experience
class Experience {

  //Declaration of the variables
  final String experienceId;
  final String title;
  final String shortText;
  final String longText;
  final String author;
  final DateTime published;
  final String imageUrl;

  //Constructor
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
