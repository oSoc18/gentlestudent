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
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//This page contains all favorites of a user
class FavoritesPage extends StatefulWidget {
  //This tag allows us to navigate to the FavoritesPage
  static String tag = 'favorites-page';

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {

  //Declartation of the variables
  FirebaseUser firebaseUser;
  List<Opportunity> _opportunities = [];
  List<Badge> _badges = [];
  List<Issuer> _issuers = [];
  List<Address> _addresses = [];
  OpportunityApi _opportunityApi;
  BadgeApi _badgeApi;
  IssuerApi _issuerApi;
  AddressApi _addressApi;
  ParticipantApi _participantApi;
  Participant _participant = new Participant(
      name: "",
      institute: "",
      participantId: "0",
      email: "",
      profilePicture: "",
      favorites: new List<String>());

  //This method gets called when the page is initializing
  //We overwrite it to:
  // - Load the Firebase user
  // - Load data from the Firebase
  @override
  void initState() {
    super.initState();
    _loadFromFirebase();
  }

  //API call to get data from the Firebase
  _loadFromFirebase() async {
    FirebaseAuth.instance.onAuthStateChanged.listen((user) async {
      firebaseUser = user;
      final participantApi = new ParticipantApi();
      final opportunityApi = new OpportunityApi();
      final badgeApi = new BadgeApi();
      final issuerApi = new IssuerApi();
      final addresApi = new AddressApi();
      final participant =
          await participantApi.getParticipantById(firebaseUser.uid);
      final opportunities = await opportunityApi.getAllOpportunities();
      final badges = await badgeApi.getAllBadges();
      final issuers = await issuerApi.getAllIssuers();
      final addresses = await addresApi.getAllAddresses();
      if (this.mounted) {
        setState(() {
          _opportunityApi = opportunityApi;
          _badgeApi = badgeApi;
          _issuerApi = issuerApi;
          _addressApi = addresApi;
          _participantApi = participantApi;
          _participant = participant;
          _opportunities = opportunities;
          _badges = badges;
          _issuers = issuers;
          _addresses = addresses;
        });
      }
    });
  }

  //API call to load data from the Firebase
  //Used when a user refreshed the current page
  _reloadOpportunities() async {
    if (_opportunityApi != null &&
        _badgeApi != null &&
        _issuerApi != null &&
        _addressApi != null &&
        _participantApi != null) {
      final participant =
          await _participantApi.getParticipantById(firebaseUser.uid);
      final opportunities = await _opportunityApi.getAllOpportunities();
      final badges = await _badgeApi.getAllBadges();
      final issuers = await _issuerApi.getAllIssuers();
      final addresses = await _addressApi.getAllAddresses();
      if (this.mounted) {
        setState(() {
          _participant = participant;
          _opportunities = opportunities;
          _badges = badges;
          _issuers = issuers;
          _addresses = addresses;
        });
      }
    }
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

  //Building a favorite opportunity
  Widget _buildOpportunityItem(BuildContext context, int index) {
    String opportunityId = _participant.favorites[index];
    Opportunity opportunity =
        _opportunities.firstWhere((o) => o.opportunityId == opportunityId);
    Badge badge =
        _badges.firstWhere((b) => b.openBadgeId == opportunity.badgeId);
    Issuer issuer =
        _issuers.firstWhere((i) => i.issuerId == opportunity.issuerId);
    Address address =
        _addresses.firstWhere((a) => a.addressId == opportunity.addressId);

    return new Container(
      margin: const EdgeInsets.only(top: 3.0),
      child: new Card(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new ListTile(
              onTap: () {
                _navigateToOpportunityDetails(
                    opportunity, badge, issuer, address);
              },
              leading: new Hero(
                tag: "listitem " + index.toString(),
                child: new CircleAvatar(
                  child: new Image(
                    image: new CachedNetworkImageProvider(badge.image),
                  ),
                  radius: 40.0,
                ),
              ),
              title: new Text(
                opportunity.title,
                style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black54,
                    fontSize: 21.0),
              ),
              subtitle: new Text(_getCategory(opportunity) +
                  " - " +
                  _getDifficulty(opportunity) +
                  "\n" +
                  issuer.name),
              isThreeLine: true,
              dense: false,
            ),
          ],
        ),
      ),
    );
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
  //Function that gets called when the page is being refreshed
  Future<Null> refresh() {
    _reloadOpportunities();
    return new Future<Null>.value();
  }

  //Building all favorite opportunities
  Widget _getListViewWidget() {
    return new Flexible(
      child: new RefreshIndicator(
        onRefresh: refresh,
        child: new ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: _participant.favorites.length,
            itemBuilder: _buildOpportunityItem),
      ),
    );
  }

  //Building the body of the page
  Widget _buildBody() {
    return new Container(
      margin: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 0.0),
      child: new Column(
        children: <Widget>[_getListViewWidget()],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorieten", style: TextStyle(color: Colors.white)),
        iconTheme: new IconThemeData(color: Colors.white),
      ),
      body: _buildBody(),
    );
  }
}