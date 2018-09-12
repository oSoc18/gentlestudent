import 'dart:async';
import 'package:Gentle_Student/models/experience.dart';
import 'package:Gentle_Student/pages/information/experiences/experiences_detail/experiences_detail_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:Gentle_Student/data/api.dart';

//This page is a list of all the experiences
class ExperiencesPage extends StatefulWidget {
  //This tag allows us to navigate to the ExperiencesPage
  static String tag = 'experiences-page';

  @override
  State<StatefulWidget> createState() => _ExperiencesPageState();
}

class _ExperiencesPageState extends State<ExperiencesPage> {
  //Declaration of the variables
  List<Experience> _experiences = [];
  ExperiencesApi _experienceApi;

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
    final experienceApi = new ExperiencesApi();
    final experiences = await experienceApi.getAllExperiences();
    if (this.mounted) {
      setState(() {
        _experienceApi = experienceApi;
        _experiences = experiences;
        _experiences.sort((a, b) => a.published.compareTo(b.published));
        reverse(_experiences);
      });
    }
  }

  //API call to load data from the Firebase
  //Used when a user refreshed the current page
  _reloadOpportunities() async {
    if (_experienceApi != null) {
      final experiences = await _experienceApi.getAllExperiences();
      if (this.mounted) {
        setState(() {
          _experiences = experiences;
          _experiences.sort((a, b) => a.published.compareTo(b.published));
          reverse(_experiences);
        });
      }
    }
  }

  //Used to navigate to the details page of an experience
  _navigateToExperienceDetails(Experience experience) async {
    Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (BuildContext context) =>
            new ExperiencesDetailPage(experience),
      ),
    );
  }

  //Building one experience
  Widget _buildExperienceItem(BuildContext context, int index) {
    Experience experience = _experiences[index];

    return new Container(
      margin: const EdgeInsets.only(
        top: 3.0,
        bottom: 10.0,
      ),
      child: new GestureDetector(
        onTap: () => _navigateToExperienceDetails(experience),
        child: Card(
          child: new ListBody(
            children: <Widget>[
              new Column(
                children: <Widget>[
                  new CachedNetworkImage(
                    imageUrl: experience.imageUrl,
                    placeholder: new CircularProgressIndicator(),
                    errorWidget: new Icon(Icons.error),
                  ),
                ],
              ),
              new SizedBox(
                height: 10.0,
              ),
              new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Padding(
                    padding: EdgeInsets.only(
                      left: 20.0,
                      right: 20.0,
                      top: 5.0,
                    ),
                    child: new Text(
                      experience.title,
                      style: new TextStyle(
                        fontSize: 21.0,
                      ),
                    ),
                  ),
                  new Padding(
                    padding: EdgeInsets.only(
                      left: 20.0,
                      right: 20.0,
                      top: 10.0,
                      bottom: 8.0,
                    ),
                    child: new Text(
                      experience.shortText,
                      style: new TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  //Function that gets called when the page is being refreshed
  Future<Null> refresh() {
    _reloadOpportunities();
    return new Future<Null>.value();
  }

  //Building all the experiences
  Widget _getListViewWidget() {
    return new Flexible(
      child: new RefreshIndicator(
        onRefresh: refresh,
        child: new ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: _experiences.length,
            itemBuilder: _buildExperienceItem),
      ),
    );
  }

  //Build the body of the page
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
        title: Text("Ervaringen", style: TextStyle(color: Colors.white)),
        iconTheme: new IconThemeData(color: Colors.white),
      ),
      body: _buildBody(),
    );
  }
}
