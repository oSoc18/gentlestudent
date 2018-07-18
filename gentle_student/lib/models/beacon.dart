import 'package:meta/meta.dart';

class Beacon{
  String beaconId;
  String opportunityId;
  double latitude;
  double longitude;

  Beacon({
    @required this.beaconId,
    @required this.opportunityId,
    @required this.longitude,
    @required this.latitude,
  });
}