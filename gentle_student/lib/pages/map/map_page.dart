import 'dart:async';

import 'package:Gentle_Student/data/api.dart';
import 'package:Gentle_Student/models/address.dart';
import 'package:Gentle_Student/models/badge.dart';
import 'package:Gentle_Student/models/category.dart';
import 'package:Gentle_Student/models/difficulty.dart';
import 'package:Gentle_Student/models/opportunity.dart';
import 'package:Gentle_Student/models/user.dart';
import 'package:Gentle_Student/pages/opportunity_details/opportunity_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class MapPage extends StatefulWidget {
  static String tag = 'map-page';
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  List<Marker> _markers = [];
  List<Opportunity> _opportunities = [];
  List<Badge> _badges = [];
  List<Issuer> _issuers = [];
  List<Address> _addresses = [];

  setMarkers() {
    for (int i = 0; i < _opportunities.length; i++) {
      _markers.add(
        new Marker(
          width: 100.0,
          height: 100.0,
          point: new LatLng(
              _opportunities[i].latitude, _opportunities[i].longitude),
          builder: (context) => new GestureDetector(
                child: new Container(
                  child: Image.network(
                    _opportunities[i].pinImageUrl,
                  ),
                ),
                onTap: () => _displayOpportunity(_opportunities[i]),
              ),
        ),
      );
    }
    return _markers;
  }

  _loadFromFirebase() async {
    final opportunityApi = new OpportunityApi();
    final badgeApi = new BadgeApi();
    final issuerApi = new IssuerApi();
    final addresApi = new AddressApi();
    final opportunities = await opportunityApi.getAllOpportunities();
    final badges = await badgeApi.getAllBadges();
    final issuers = await issuerApi.getAllIssuers();
    final addresses = await addresApi.getAllAddresses();
    setState(() {
      _opportunities = opportunities;
      _badges = badges;
      _issuers = issuers;
      _addresses = addresses;
    });
  }

  Future<Null> _displayOpportunity(Opportunity opportunity) async {
    Badge badge =
        _badges.firstWhere((b) => b.openBadgeId == opportunity.badgeId);
    Issuer issuer =
        _issuers.firstWhere((i) => i.issuerId == opportunity.issuerId);
    Address address =
        _addresses.firstWhere((a) => a.addressId == opportunity.addressId);

    return showDialog<Null>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return new AlertDialog(
          contentPadding: EdgeInsets.all(0.0),
          content: new Padding(
            padding: EdgeInsets.only(top: 5.0),
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new ListTile(
                  contentPadding: EdgeInsets.only(left: 6.0),
                  leading: new Hero(
                    tag: "badge image",
                    child: new CircleAvatar(
                      backgroundImage: new NetworkImage(badge.image),
                      radius: 28.0,
                    ),
                  ),
                  title: new Text(
                    opportunity.title,
                    style: new TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                        fontSize: 16.0),
                  ),
                  subtitle: new Text(
                    _getCategory(opportunity) +
                        " - " +
                        _getDifficulty(opportunity) +
                        "\n" +
                        issuer.name,
                    style: new TextStyle(fontSize: 12.0),
                  ),
                  isThreeLine: true,
                  dense: false,
                ),
                new Padding(
                  padding: EdgeInsets.only(
                    left: 10.0,
                    right: 10.0,
                    top: 5.0,
                    bottom: 5.0,
                  ),
                  child: new Text(
                    opportunity.shortDescription,
                    textAlign: TextAlign.center,
                    style: new TextStyle(fontSize: 14.0),
                  ),
                ),
                new Padding(
                  padding: EdgeInsets.only(
                    left: 5.0,
                    right: 5.0,
                    top: 15.0,
                    bottom: 20.0,
                  ),
                  child: Material(
                    borderRadius: BorderRadius.circular(10.0),
                    shadowColor: Colors.lightBlueAccent.shade100,
                    elevation: 5.0,
                    child: MaterialButton(
                      minWidth: 200.0,
                      height: 36.0,
                      onPressed: () => _navigateToOpportunityDetails(
                          opportunity, badge, issuer, address),
                      color: Colors.lightBlueAccent,
                      child: Text('Lees meer',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _navigateToOpportunityDetails(Opportunity opportunity, Badge badge,
      Issuer issuer, Address address) async {
    Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (BuildContext context) =>
            new OpportunityDetailsPage(opportunity, badge, issuer, address),
      ),
    );
  }

  @override
  initState() {
    super.initState();
    _loadFromFirebase();
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
          //OPENSTREETMAP (FREE, BUT REALLY SLOW)
          //new TileLayerOptions(
          //urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
          //subdomains: ['a', 'b', 'c'],
          //),

          //MAPBOX (FREE IN THE BEGINNING)
          new TileLayerOptions(
            urlTemplate: "https://api.tiles.mapbox.com/v4/"
                "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
            additionalOptions: {
              'accessToken':
                  'pk.eyJ1IjoiZ2VudGxlc3R1ZGVudCIsImEiOiJjampxdGI5cGExMjh2M3FudTVkYnl3aDlzIn0.Z3OSj_o97M8_7L8P5s3xIA',
              'id': 'mapbox.streets',
            },
          ),
          new MarkerLayerOptions(
            markers: setMarkers(),
          ),
        ],
      ),
    );
  }

  String _getDifficulty(Opportunity opportunity) {
    switch (opportunity.difficulty) {
      case Difficulty.BEGINNER:
        return "Niveau 1";
      case Difficulty.INTERMEDIATE:
        return "Niveau 2";
      case Difficulty.EXPERT:
        return "Niveau 3";
    }
    return "Niveau 0";
  }

  String _getCategory(Opportunity opportunity) {
    switch (opportunity.category) {
      case Category.DIGITALEGELETTERDHEID:
        return "Digitale geletterdheid";
      case Category.DUURZAAMHEID:
        return "Duurzaamheid";
      case Category.ONDERNEMINGSZIN:
        return "Ondernemingszin";
      case Category.ONDERZOEK:
        return "Onderzoek";
      case Category.WERELDBURGERSCHAP:
        return "Wereldburgerschap";
    }
    return "Algemeen";
  }
}
