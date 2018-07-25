import 'package:meta/meta.dart';

//This model represents a bluetooth beacon
class IBeacon{

  //Declaration of the variables
  final String beaconId;
  final String opportunityId;

  //Constructor
  IBeacon({
    @required this.beaconId,
    @required this.opportunityId,
  });
}