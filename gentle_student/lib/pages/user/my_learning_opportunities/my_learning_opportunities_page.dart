import 'dart:async';

import 'package:Gentle_Student/data/api.dart';
import 'package:Gentle_Student/models/address.dart';
import 'package:Gentle_Student/models/badge.dart';
import 'package:Gentle_Student/models/category.dart';
import 'package:Gentle_Student/models/difficulty.dart';
import 'package:Gentle_Student/models/opportunity.dart';
import 'package:Gentle_Student/models/participation.dart';
import 'package:Gentle_Student/models/status.dart';
import 'package:Gentle_Student/models/user.dart';
import 'package:Gentle_Student/pages/opportunity_details/opportunity_details_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyLearningOpportunitiesPage extends StatefulWidget {
  static String tag = 'my-learning-opportunities-page';
  @override
  _MyLearningOpportunitiesPageState createState() =>
      _MyLearningOpportunitiesPageState();
}

class _MyLearningOpportunitiesPageState
    extends State<MyLearningOpportunitiesPage> {
  FirebaseUser firebaseUser;
  List<Participation> _participations = [];
  List<Opportunity> _opportunitiesApproved = [];
  List<Opportunity> _opportunitiesRequested = [];
  List<Badge> _badges = [];
  List<Issuer> _issuers = [];
  List<Address> _addresses = [];
  ParticipationApi _participationApi;
  OpportunityApi _opportunityApi;
  BadgeApi _badgeApi;
  IssuerApi _issuerApi;
  AddressApi _addressApi;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.onAuthStateChanged.listen((user) {
      firebaseUser = user;
      _loadFromFirebase();
    });
  }

  Future<List<Opportunity>> _getApprovedOpportunities() async {
    List<Opportunity> list = [];
    Opportunity opportunity;
    for (int i = 0; i < _participations.length; i++) {
      opportunity = await _opportunityApi
          .getOpportunityById(_participations[i].opportunityId);
      if (_participations[i].status == Status.APPROVED) list.add(opportunity);
    }
    return list;
  }

  Future<List<Opportunity>> _getRequestedOpportunities() async {
    List<Opportunity> list = [];
    Opportunity opportunity;
    for (int i = 0; i < _participations.length; i++) {
      opportunity = await _opportunityApi
          .getOpportunityById(_participations[i].opportunityId);
      if (_participations[i].status != Status.APPROVED) list.add(opportunity);
    }
    return list;
  }

  _loadFromFirebase() async {
    final participationApi = new ParticipationApi();
    final opportunityApi = new OpportunityApi();
    final badgeApi = new BadgeApi();
    final issuerApi = new IssuerApi();
    final addressApi = new AddressApi();
    final participations =
        await participationApi.getAllParticipationsFromUser(firebaseUser);
    final badges = await badgeApi.getAllBadges();
    final issuers = await issuerApi.getAllIssuers();
    final addresses = await addressApi.getAllAddresses();
    if (this.mounted) {
      setState(() {
        _participationApi = participationApi;
        _opportunityApi = opportunityApi;
        _badgeApi = badgeApi;
        _issuerApi = issuerApi;
        _addressApi = addressApi;
        _participations = participations;
        _badges = badges;
        _issuers = issuers;
        _addresses = addresses;
      });
      await _loadOpportunities();
    }
  }

  _reloadParticipations() async {
    if (_participationApi != null && _opportunityApi != null) {
      final participations =
          await _participationApi.getAllParticipationsFromUser(firebaseUser);
      final badges = await _badgeApi.getAllBadges();
      final issuers = await _issuerApi.getAllIssuers();
      final addresses = await _addressApi.getAllAddresses();
      if (this.mounted) {
        setState(() {
          _participations = participations;
          _badges = badges;
          _issuers = issuers;
          _addresses = addresses;
        });
        await _loadOpportunities();
      }
    }
  }

  _loadOpportunities() async {
    final approvedOpportunities = await _getApprovedOpportunities();
    final requestedOpportunities = await _getRequestedOpportunities();
    if (this.mounted) {
      setState(() {
        _opportunitiesApproved = approvedOpportunities;
        _opportunitiesRequested = requestedOpportunities;
      });
    }
  }

  Future<Null> refresh() {
    _reloadParticipations();
    return new Future<Null>.value();
  }

  _navigateToOpportunityDetails(
      Opportunity opportunity, Badge badge, Issuer issuer, Address address) {
    Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (BuildContext context) =>
            new OpportunityDetailsPage(opportunity, badge, issuer, address),
      ),
    );
  }

  Widget _buildApprovedOpportunityItem(BuildContext context, int index) {
    Opportunity opportunity = _opportunitiesApproved[index];
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
                tag: "approved " + index.toString(),
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
              subtitle: new Text(
                _getCategory(opportunity) +
                    " - " +
                    _getDifficulty(opportunity) +
                    "\n" +
                    issuer.name,
              ),
              isThreeLine: true,
              dense: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRequestedOpportunityItem(BuildContext context, int index) {
    Opportunity opportunity = _opportunitiesRequested[index];
    Participation participation = _participations
        .firstWhere((p) => p.opportunityId == opportunity.opportunityId);
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
                tag: "requested " + index.toString(),
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
              subtitle: new Text(
                "Status: " +
                    _getStatus(participation) +
                    "\n" +
                    _getReason(participation),
              ),
              isThreeLine: true,
              dense: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget _getApprovedListViewWidget() {
    return new Flexible(
      child: new RefreshIndicator(
        onRefresh: refresh,
        child: new ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: _opportunitiesApproved.length,
            itemBuilder: _buildApprovedOpportunityItem),
      ),
    );
  }

  Widget _getRequestedListViewWidget() {
    return new Flexible(
      child: new RefreshIndicator(
        onRefresh: refresh,
        child: new ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: _opportunitiesRequested.length,
            itemBuilder: _buildRequestedOpportunityItem),
      ),
    );
  }

  Widget _buildBodyApproved() {
    return new Container(
      margin: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 0.0),
      child: new Column(
        children: <Widget>[_getApprovedListViewWidget()],
      ),
    );
  }

  Widget _buildBodyRequested() {
    return new Container(
      margin: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 0.0),
      child: new Column(
        children: <Widget>[_getRequestedListViewWidget()],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: 2,
      child: new Scaffold(
        body: new NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              new SliverAppBar(
                title: const Text(
                  'Mijn leerkansen',
                  style: TextStyle(color: Colors.white),
                ),
                iconTheme: new IconThemeData(
                  color: Colors.white,
                ),
                forceElevated: innerBoxIsScrolled,
                pinned: true,
                floating: true,
                bottom: new TabBar(
                  labelColor: Colors.white,
                  tabs: <Tab>[
                    new Tab(text: 'Goedgekeurde'),
                    new Tab(text: 'Geregistreerde'),
                  ],
                ),
              ),
            ];
          },
          body: new TabBarView(
            children: <Widget>[
              _buildBodyApproved(),
              _buildBodyRequested(),
            ],
          ),
        ),
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

  String _getStatus(Participation participation) {
    switch (participation.status) {
      case Status.PENDING:
        return "In afwachting";
      case Status.APPROVED:
        return "Goedgekeurd";
      case Status.REFUSED:
        return "Geweigerd";
      case Status.ACCOMPLISHED:
        return "Voltooid";
    }
    return "In afwachting";
  }

  String _getReason(Participation participation) {
    if (participation.reason != "" && participation.reason != null)
      return "Reden: " + participation.reason;
    else
      return participation.reason;
  }
}
