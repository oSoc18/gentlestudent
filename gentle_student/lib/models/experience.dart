import 'package:meta/meta.dart';

class Experience{
  final String recap;
  //ID of the user that wrote the experience
  final String authorId;
  final String content;
  final String experienceId;
  final DateTime date;

  Experience({
    @required this.authorId,
    @required this.content,
    @required this.recap,
    @required this.experienceId,
    @required this.date
  }
  );
}