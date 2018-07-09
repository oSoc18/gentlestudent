import 'package:flutter/material.dart';
import 'package:map_view/map_view.dart';

class MapPage extends StatefulWidget {
  static String tag = 'map-page';
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  var _mapView = new MapView();

  void showMap() {
    _mapView.show(new MapOptions(
        mapViewType: MapViewType.normal,
        showUserLocation: true,
        initialCameraPosition:
            new CameraPosition(new Location(51.055747, 3.723206), 13.2)));
  }

  @override
  initState() {
    super.initState();
    showMap();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Map", style: TextStyle(color: Colors.white)),
        iconTheme: new IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.white,
    );
  }
}
