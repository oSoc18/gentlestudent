import 'dart:async';
import 'package:Gentle_Student/models/address.dart';
import 'package:Gentle_Student/models/badge.dart';
import 'package:Gentle_Student/models/opportunity.dart';
import 'package:Gentle_Student/models/issuer.dart';
import 'package:Gentle_Student/network/network_api.dart';
import 'package:Gentle_Student/utils/string_utils.dart';
import 'package:Gentle_Student/views/pages/opportunities/filter_dialog.dart';
import 'package:Gentle_Student/views/pages/opportunities/opportunity_details_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class OpportunityListPage extends StatefulWidget {
  static String tag = 'opportunity-list-page';

  @override
  _OpportunityListPageState createState() => _OpportunityListPageState();
}

class _OpportunityListPageState extends State<OpportunityListPage> {
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

  @override
  void initState() {
    super.initState();
    _loadFromFirebase();
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
                        o.category ==
                            StringUtils.getCategoryEnum(categoryFilter)) &&
                    (difficultyFilter == "Alles" ||
                        o.difficulty ==
                            StringUtils.getDifficultyEnum(difficultyFilter)) &&
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

  _navigateToOpportunityDetails(Opportunity o, Badge b,
      Issuer i, Address a) async {
    Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (BuildContext context) =>
            new OpportunityDetailsPage(o, b, i, a),
      ),
    );
  }

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
              subtitle: new Text(StringUtils.getCategory(opportunity) +
                  " - " +
                  StringUtils.getDifficulty(opportunity) +
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

  Future<Null> refresh() {
    _reloadOpportunities();
    return new Future<Null>.value();
  }

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

  Widget _buildBody() {
    return new Container(
      margin: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 0.0),
      child: new Column(
        children: <Widget>[_getListViewWidget()],
      ),
    );
  }

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
