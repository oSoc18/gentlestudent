import 'package:flutter/material.dart';
import 'package:map_view/map_view.dart';

class HomePage extends StatefulWidget {
  static String tag = 'home-page';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        title: new Text("Home", style: TextStyle(color: Colors.white)),
        iconTheme: new IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.white,
    );
  }
}
