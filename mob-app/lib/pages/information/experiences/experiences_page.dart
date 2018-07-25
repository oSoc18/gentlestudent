import 'dart:async';
import 'package:Gentle_Student/models/experience.dart';
import 'package:Gentle_Student/pages/information/experiences/experiences_detail/experiences_detail_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:Gentle_Student/data/api.dart';

class ExperiencesPage extends StatefulWidget {
  static String tag = 'experiences-page';
  @override
  State<StatefulWidget> createState() => _ExperiencesPageState();
}

class _ExperiencesPageState extends State<ExperiencesPage> {
  List<Experience> _experiences = [];
  ExperiencesApi _experienceApi;

  @override
  void initState() {
    super.initState();
    _loadFromFirebase();
  }

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

  _navigateToExperienceDetails(Experience experience) async {
    Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (BuildContext context) => new ExperiencesDetailPage(experience),
      ),
    );
  }

  Widget _buildNewsItem(BuildContext context, int index) {
    Experience experience = _experiences[index];

    return new Container(
      margin: const EdgeInsets.only(
        top: 3.0,
        bottom: 10.0,
      ),
      child: new GestureDetector(
        onTap: () => _navigateToExperienceDetails(experience),
        child: Card(
          child: new Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new CachedNetworkImage(
                imageUrl: experience.imageUrl,
                placeholder: new CircularProgressIndicator(),
                errorWidget: new Icon(Icons.error),
              ),
              new SizedBox(
                height: 10.0,
              ),
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
            itemCount: _experiences.length,
            itemBuilder: _buildNewsItem),
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
