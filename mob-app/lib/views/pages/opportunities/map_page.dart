import 'dart:async';

import 'package:Gentle_Student/models/address.dart';
import 'package:Gentle_Student/models/badge.dart';
import 'package:Gentle_Student/models/issuer.dart';
import 'package:Gentle_Student/models/opportunity.dart';
import 'package:Gentle_Student/utils/string_utils.dart';
import 'package:Gentle_Student/viewmodels/opportunity_viewmodel.dart';
import 'package:Gentle_Student/views/pages/opportunities/opportunity_details_page.dart';
import 'package:Gentle_Student/views/widgets/no_internet_connection.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:scoped_model/scoped_model.dart';

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
                    StringUtils.getCategory(opportunity) +
                        "\n" +
                        StringUtils.getDifficulty(opportunity) +
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
  Widget build(BuildContext context) {
    // return Scaffold(
    //   body: new FlutterMap(
    //     options: new MapOptions(
    //       center: new LatLng(51.052233, 3.723653),
    //       zoom: 14.0,
    //       maxZoom: 16.0,
    //       minZoom: 12.0,
    //     ),
    //     layers: [
    //       //OPENSTREETMAP (FREE, BUT REALLY SLOW)
    //       //new TileLayerOptions(
    //       //urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
    //       //subdomains: ['a', 'b', 'c'],
    //       //),

    //       //MAPBOX (FREE, IN THE BEGINNING)
    //       new TileLayerOptions(
    //         urlTemplate: "https://api.tiles.mapbox.com/v4/"
    //             "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
    //         additionalOptions: {
    //           'accessToken':
    //               'pk.eyJ1IjoiZ2VudGxlc3R1ZGVudCIsImEiOiJjampxdGI5cGExMjh2M3FudTVkYnl3aDlzIn0.Z3OSj_o97M8_7L8P5s3xIA',
    //           'id': Theme.of(context).brightness == Brightness.dark
    //               ? 'mapbox.dark'
    //               : 'mapbox.streets',
    //         },
    //       ),
    //       new MarkerLayerOptions(
    //         markers: setMarkers(),
    //       ),
    //     ],
    //   ),
    // );

    return Scaffold(
      body: Container(
        margin: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 0.0),
        child: Column(
          children: <Widget>[
            Flexible(
              child: ScopedModelDescendant<OpportunityViewModel>(
                builder: (context, child, model) {
                  return FutureBuilder<Leerkansen>(
                    future: Future.wait([
                      model.opportunities,
                      model.addresses,
                      model.badges,
                      model.issuers
                    ]).then(
                      (response) => new Leerkansen(
                          opportunities: response[0],
                          addresses: response[1],
                          badges: response[2],
                          issuers: response[3]),
                    ),
                    builder: (_, AsyncSnapshot<Leerkansen> snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                        case ConnectionState.active:
                        case ConnectionState.waiting:
                          return Center(
                              child: const CircularProgressIndicator());
                        case ConnectionState.done:
                          if (snapshot.hasData) {
                            var leerkansen = snapshot.data;
                            _opportunities = leerkansen.opportunities;
                            _addresses = leerkansen.addresses;
                            _badges = leerkansen.badges;
                            _issuers = leerkansen.issuers;

                            return Container(
                              child: FlutterMap(
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

                                  //MAPBOX (FREE, IN THE BEGINNING)
                                  new TileLayerOptions(
                                    urlTemplate:
                                        "https://api.tiles.mapbox.com/v4/"
                                        "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
                                    additionalOptions: {
                                      'accessToken':
                                          'pk.eyJ1IjoiZ2VudGxlc3R1ZGVudCIsImEiOiJjampxdGI5cGExMjh2M3FudTVkYnl3aDlzIn0.Z3OSj_o97M8_7L8P5s3xIA',
                                      'id': Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? 'mapbox.dark'
                                          : 'mapbox.streets',
                                    },
                                  ),
                                  new MarkerLayerOptions(
                                    markers: setMarkers(),
                                  ),
                                ],
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return NoInternetConnection(
                              action: () async {
                                await model.fetchOpportunities();
                                await model.fetchAddresses();
                                await model.fetchBadges();
                                await model.fetchIssuers();
                              },
                            );
                          }
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
