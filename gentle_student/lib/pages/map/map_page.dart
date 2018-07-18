import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class MapPage extends StatefulWidget {
  static String tag = 'map-page';
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new FlutterMap(
        options: new MapOptions(
          center: new LatLng(51.052233, 3.723653),
          zoom: 13.8,
        ),
        layers: [
          //new TileLayerOptions(
          //urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
          //subdomains: ['a', 'b', 'c'],
          //),
          new TileLayerOptions(
            urlTemplate: "https://api.tiles.mapbox.com/v4/"
                "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
            additionalOptions: {
              'accessToken':
                  'pk.eyJ1IjoiZ2VudGxlc3R1ZGVudCIsImEiOiJjampxdGI5cGExMjh2M3FudTVkYnl3aDlzIn0.Z3OSj_o97M8_7L8P5s3xIA',
              'id': 'mapbox.streets',
            },
          ),
        ],
      ),
    );
  }
}
