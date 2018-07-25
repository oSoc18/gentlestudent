import 'package:meta/meta.dart';

class IBeacon{
  String beaconId;
  String opportunityId;
  double latitude;
  double longitude;

  IBeacon({
    @required this.beaconId,
    @required this.opportunityId,
  });
}