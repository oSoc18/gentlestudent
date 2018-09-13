import 'dart:collection';

import 'package:meta/meta.dart';

//This model represents a bluetooth beacon
class IBeacon{

  //Declaration of the variables
  final String beaconId;
  final String addressId;
  final String major;
  final String minor;
  final String name;
  final LinkedHashMap<String, bool> opportunities;
  final int range;

  //Constructor
  IBeacon({
    @required this.beaconId,
    @required this.addressId,
    @required this.major,
    @required this.minor,
    @required this.name,
    @required this.opportunities,
    @required this.range,
  });
}