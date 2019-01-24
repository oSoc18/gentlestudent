import 'dart:async';
import 'package:Gentle_Student/data/api.dart';
import 'package:Gentle_Student/models/address.dart';
import 'package:Gentle_Student/models/badge.dart';
import 'package:Gentle_Student/models/category.dart';
import 'package:Gentle_Student/models/difficulty.dart';
import 'package:Gentle_Student/models/opportunity.dart';
import 'package:Gentle_Student/models/issuer.dart';
import 'package:Gentle_Student/pages/filter/filter_dialog.dart';
import 'package:Gentle_Student/pages/opportunity_details/opportunity_details_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

//This page is a list of all the opportunities
class OpportunityListPage extends StatefulWidget {
  //This tag allows us to navigate to the OpportunityListPage
  static String tag = 'opportunity-list-page';

  @override
  _OpportunityListPageState createState() => _OpportunityListPageState();
}

class _OpportunityListPageState extends State<OpportunityListPage> {
  //Declaration of the variables
  List<Opportunity> _opportunities = [];
  List<Badge> _badges = [];
  List<Issuer> _issuers = [];
  List<Address> _addresses = [];
  OpportunityApi _opportunityApi;
  BadgeApi _badgeApi;
  IssuerApi _issuerApi;
  AddressApi _addressApi;
  String issuerNameFilter = "";
  String categoryFilter = "Alles";
  String difficultyFilter = "Alles";

  //This method gets called when the page is initializing
  //We overwrite it to:
  // - Load data from the Firebase
  @override
  void initState() {
    super.initState();
    _loadFromFirebase();
  }

  //API call to load data from the Firebase
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
        _opportunityApi = opportunityApi;
        _badgeApi = badgeApi;
        _issuerApi = issuerApi;
        _addressApi = addresApi;
        _opportunities = opportunities;
        _badges = badges;
        _issuers = issuers;
        _addresses = addresses;
      });
    }
  }

  //API call to load data from the Firebase
  //Used when a user refreshed the current page
  _reloadOpportunities() async {
    if (_opportunityApi != null &&
        _badgeApi != null &&
        _issuerApi != null &&
        _addressApi != null) {
      final opportunities = await _opportunityApi.getAllOpportunities();
      final badges = await _badgeApi.getAllBadges();
      final issuers = await _issuerApi.getAllIssuers();
      final addresses = await _addressApi.getAllAddresses();
      if (this.mounted) {
        setState(() {
          _opportunities = opportunities
              .where(
                (o) =>
                    (categoryFilter == "Alles" ||
                        o.category == _getCategoryEnum(categoryFilter)) &&
                    (difficultyFilter == "Alles" ||
                        o.difficulty == _getDifficultyEnum(difficultyFilter)) &&
                    _issuers.any(
                      (i) =>
                          i.issuerId == o.issuerId &&
                          i.name.toLowerCase().contains(
                                issuerNameFilter.toLowerCase(),
                              ),
                    ),
              )
              .toList();
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

  //Build an opportunity
  Widget _buildOpportunityItem(BuildContext context, int index) {
    Opportunity opportunity = _opportunities[index];
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

  //Building all the opportunities
  Widget _getListViewWidget() {
    return new Flexible(
      child: new RefreshIndicator(
        onRefresh: refresh,
        child: new ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: _opportunities.length,
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

  //Opening the filter menu
  Future _openFilterDialog() async {
    List<String> filter = await Navigator.of(context).push(
      new MaterialPageRoute<List<String>>(
        builder: (BuildContext context) {
          return new FilterDialog();
        },
        fullscreenDialog: true,
      ),
    );
    if (filter != null) {
      setState(() {
        issuerNameFilter = filter[0];
        categoryFilter = filter[1];
        difficultyFilter = filter[2];
      });
      _reloadOpportunities();
    }
  }

  //Function to get the name of a category in enum form
  Category _getCategoryEnum(String category) {
    Category value;
    switch (category) {
      case "Digitale geletterdheid":
        value = Category.DIGITALEGELETTERDHEID;
        break;
      case "Duurzaamheid":
        value = Category.DUURZAAMHEID;
        break;
      case "Ondernemingszin":
        value = Category.ONDERNEMINGSZIN;
        break;
      case "Onderzoek":
        value = Category.ONDERZOEK;
        break;
      case "Wereldburgerschap":
        value = Category.WERELDBURGERSCHAP;
        break;
    }
    return value;
  }

  //Function to get the name of a difficulty in enum form
  Difficulty _getDifficultyEnum(String difficulty) {
    Difficulty value;
    switch (difficulty) {
      case "Beginner":
        value = Difficulty.BEGINNER;
        break;
      case "Intermediate":
        value = Difficulty.INTERMEDIATE;
        break;
      case "Expert":
        value = Difficulty.EXPERT;
        break;
    }
    return value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlue,
        child: Icon(
          Icons.filter_list,
          color: Colors.white,
        ),
        onPressed: () => _openFilterDialog(),
      ),
    );
  }
}
