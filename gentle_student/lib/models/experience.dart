import 'package:meta/meta.dart';

class Experience {
  final String experienceId;
  final String recap;
  final String participantId;
  final String content;
  final DateTime date;

  Experience({
    @required this.participantId,
    @required this.content,
    @required this.recap,
    @required this.experienceId,
    @required this.date,
  });
}
