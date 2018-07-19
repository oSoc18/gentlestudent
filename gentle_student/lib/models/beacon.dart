import 'package:meta/meta.dart';

class iBeacon{
  String beaconId;
  String opportunityId;
  double latitude;
  double longitude;

  iBeacon({
    @required this.beaconId,
    @required this.opportunityId,
    /*@required this.longitude,
    @required this.latitude,*/
  });
}