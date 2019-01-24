import 'dart:collection';

class IBeacon {
  final String beaconId;
  final String addressId;
  final String major;
  final String minor;
  final String name;
  final LinkedHashMap<String, bool> opportunities;
  final int range;

  IBeacon({
    this.beaconId,
    this.addressId,
    this.major,
    this.minor,
    this.name,
    this.opportunities,
    this.range,
  });
  
}
