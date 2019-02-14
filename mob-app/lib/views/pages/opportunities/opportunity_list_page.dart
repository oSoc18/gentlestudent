import 'dart:async';
import 'package:Gentle_Student/models/address.dart';
import 'package:Gentle_Student/models/badge.dart';
import 'package:Gentle_Student/models/opportunity.dart';
import 'package:Gentle_Student/models/issuer.dart';
import 'package:Gentle_Student/utils/string_utils.dart';
import 'package:Gentle_Student/viewmodels/opportunity_viewmodel.dart';
import 'package:Gentle_Student/views/pages/opportunities/filter_dialog.dart';
import 'package:Gentle_Student/views/pages/opportunities/opportunity_details_page.dart';
import 'package:Gentle_Student/views/widgets/no_internet_connection.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

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
  List<Opportunity> _filteredOpportunities = [];
  String issuerNameFilter = "";
  String categoryFilter = "Alles";
  String difficultyFilter = "Alles";

  Future _navigateToOpportunityDetails(
      Opportunity o, Badge b, Issuer i, Address a) async {
    Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (BuildContext context) =>
            new OpportunityDetailsPage(o, b, i, a),
      ),
    );
  }

  Widget _buildOpportunityItem(int index) {
    var o = _filteredOpportunities[index];
    var a = _addresses.firstWhere((a) => a.addressId == o.addressId);
    var b = _badges.firstWhere((b) => b.openBadgeId == o.badgeId);
    var i = _issuers.firstWhere((i) => i.issuerId == o.issuerId);

    return new Container(
      margin: const EdgeInsets.only(top: 3.0),
      child: new Card(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new ListTile(
              onTap: () {
                _navigateToOpportunityDetails(o, b, i, a);
              },
              leading: new Hero(
                tag: "listitem " + o.title,
                child: new CircleAvatar(
                  child: new Image(
                    image: new CachedNetworkImageProvider(b.image),
                  ),
                  radius: 40.0,
                ),
              ),
              title: new Text(
                o.title,
                style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black54,
                    fontSize: 21.0),
              ),
              subtitle: new Text(StringUtils.getCategory(o) +
                  " - " +
                  StringUtils.getDifficulty(o) +
                  "\n" +
                  i.name),
              isThreeLine: true,
              dense: false,
            ),
          ],
        ),
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
    }
  }


  _filterOpportunities() {
    _filteredOpportunities = _opportunities
        .where(
          (o) =>
              (categoryFilter == "Alles" ||
                  o.category == StringUtils.getCategoryEnum(categoryFilter)) &&
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
  }

  @override
  Widget build(BuildContext context) {
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
                            _filterOpportunities();

                            return ListView.builder(
                              itemCount: _filteredOpportunities == null
                                  ? 0
                                  : _filteredOpportunities.length,
                              itemBuilder: (_, int index) {
                                return _buildOpportunityItem(index);
                              },
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
