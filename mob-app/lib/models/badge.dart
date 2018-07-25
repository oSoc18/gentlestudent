import 'package:meta/meta.dart';

//This model represents a badge as defined by the badgr API
class Badge {

  //Declaration of the variables
  final String openBadgeId;
  final String image;
  final String description;

  //Constructor
  Badge({
    @required this.openBadgeId,
    @required this.image,
    @required this.description,
  });
}
