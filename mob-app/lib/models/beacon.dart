import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';

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

  static IBeacon fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data;

    return new IBeacon(
      beaconId: snapshot.documentID,
      addressId: data['addressId'],
      major: data['major'],
      minor: data['minor'],
      name: data['name'],
      opportunities:
          new LinkedHashMap<String, bool>.from(data['opportunities']),
      range: data['range'],
    );
  }
}
