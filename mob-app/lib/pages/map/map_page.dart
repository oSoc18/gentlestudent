import 'dart:async';

import 'package:Gentle_Student/data/api.dart';
import 'package:Gentle_Student/models/address.dart';
import 'package:Gentle_Student/models/badge.dart';
import 'package:Gentle_Student/models/category.dart';
import 'package:Gentle_Student/models/difficulty.dart';
import 'package:Gentle_Student/models/opportunity.dart';
import 'package:Gentle_Student/models/user.dart';
import 'package:Gentle_Student/pages/opportunity_details/opportunity_details_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

//This page represents the map with learning opportunities
class MapPage extends StatefulWidget {
  //This tag allows us to navigate to the MapPage
  static String tag = 'map-page';

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  //Declaration of the variables
  List<Marker> _markers = [];
  List<Opportunity> _opportunities = [];
  List<Badge> _badges = [];
  List<Issuer> _issuers = [];
  List<Address> _addresses = [];

  //Function for placing the markers of the opportunities on the map
  setMarkers() {
    Address address;
    for (int i = 0; i < _opportunities.length; i++) {
      address = _addresses
          .firstWhere((a) => _opportunities[i].addressId == a.addressId);
      _markers.add(
        new Marker(
          width: 100.0,
          height: 100.0,
          point: new LatLng(address.latitude, address.longitude),
          builder: (context) => new GestureDetector(
                child: new Container(
                  child: new CachedNetworkImage(
                    imageUrl: _opportunities[i].pinImageUrl,
                    placeholder: new CircularProgressIndicator(),
                    errorWidget: new Icon(Icons.error),
                  ),
                ),
                onTap: () => _displayOpportunity(_opportunities[i]),
              ),
        ),
      );
    }
    return _markers;
  }

  //This method gets called when the page is initializing
  //We overwrite it to:
  // - Load data from the Firebase
  _loadFromFirebase() async {
    final opportunityApi = new OpportunityApi();
    final badgeApi = new BadgeApi();
    final issuerApi = new IssuerApi();
    final addresApi = new AddressApi();
    final opportunities = await opportunityApi.getAllOpportunities();
    final badges = await badgeApi.getAllBadges();
    final issuers = await issuerApi.getAllIssuers();
    final addresses = await addresApi.getAllAddresses();
    if (this.mounted) {
      setState(() {
        _opportunities = opportunities;
        _badges = badges;
        _issuers = issuers;
        _addresses = addresses;
      });
    }
  }

  //Displays a message with details of an opportunity
  //And a button to navigate to the details page of the opportunity
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
                  contentPadding: EdgeInsets.only(
                    left: 6.0,
                    right: 6.0,
                  ),
                  leading: new Hero(
                    tag: "badge image",
                    child: new CircleAvatar(
                      child: new Image(
                        image: new CachedNetworkImageProvider(badge.image),
                      ),
                      radius: 28.0,
                    ),
                  ),
                  title: new Text(
                    opportunity.title,
                    style: new TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black54,
                        fontSize: 16.0),
                  ),
                  subtitle: new Text(
                    _getCategory(opportunity) +
                        "\n" +
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

  //Used to navigate to the details page of an opportunity
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

  //This method gets called when the page is initializing
  //We overwrite it to:
  // - Load data from the Firebase
  @override
  initState() {
    super.initState();
    _loadFromFirebase();
  }

  @override
  Widget build(BuildContext context) {
    return new Stack(children: <Widget>[
      Scaffold(
        body: new FlutterMap(
          options: new MapOptions(
            center: new LatLng(51.052233, 3.723653),
            zoom: 14.0,
            maxZoom: 16.0,
            minZoom: 12.0,
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
                //Our MapBox token
                'accessToken':
                    'pk.eyJ1IjoiZ2VudGxlc3R1ZGVudCIsImEiOiJjampxdGI5cGExMjh2M3FudTVkYnl3aDlzIn0.Z3OSj_o97M8_7L8P5s3xIA',
                //If the dark mode is on, display a dark map
                'id': Theme.of(context).brightness == Brightness.dark
                    ? 'mapbox.dark'
                    : 'mapbox.streets',
              },
            ),
            //Placing our markers on the map
            new MarkerLayerOptions(
              markers: setMarkers(),
            ),
          ],
        ),
      ),
    ]);
  }

  //Function to get the name of a difficulty in String form
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

  //Function to get the name of a category in String form
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
