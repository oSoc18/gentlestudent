import 'dart:async';
import 'package:Gentle_Student/pages/information/experiences/experiences_detail/experiences_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:Gentle_Student/models/experience.dart';
import 'package:Gentle_Student/data/api.dart';

class ExperiencesPage extends StatefulWidget{
  static String tag = 'experiences-page';
  @override
    State<StatefulWidget> createState() => _ExperiencesPageState();
}

class _ExperiencesPageState extends State<ExperiencesPage> {
  List<Experience> _experiences = [
  ];
  ExperiencesApi _api;

  @override
    void initState() {
      super.initState();
      _loadFromFirebase();
    }

    _loadFromFirebase() async{
      final api = new ExperiencesApi();
      final experiences = await api.getAllExperiences();// api.getAllExperiences();
      setState((){
          _api = api;
          _experiences = experiences;
          _experiences.add(
            new Experience(
              participantId: "500",
              content: "Mijn content",
              date: DateTime(2018,12,6),
              experienceId: "550",
              recap: "MIJN RECAP" 
            )
          );
      });
    }

    _reloadExperiences() async {
      if (_api != null){
        final experiences = await _api.getAllExperiences();//_api.getAllExperiences();
        setState((){
          _experiences = experiences;
        });
      }
    }

    _navigateToExperienceDetails(Experience experience) {
      Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (BuildContext context) =>
            new ExperienceDetailsPage(experience)
        )
      );
    }

    Widget _buildExperienceItem(BuildContext context, int index){
      Experience experience = _experiences[index];

      return new Container(
        margin: const EdgeInsets.only(top: 3.0),
          child: 
          new Card(
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    new Expanded(
                        child:
                        new Container(
                          padding: const EdgeInsets.all(5.0),
                          child:
                        new Text(
                          experience.recap,
                          textAlign: TextAlign.center
                          ),),
                    ),
                  ],
                ),
                new Row(
                  children: <Widget>[
                    new Flexible(child: 
                    new ListTile(
                      onTap: () {
                        _navigateToExperienceDetails(experience);
                      },
                      leading: new Hero(
                        tag: index,
                        child: new CircleAvatar(
                          backgroundColor: Colors.brown.shade100,
                          child: new Text(
                            "_getUser(experience.participantId).name.substring(0, 1)"
                          ),
                        ),),
                        title: new Text(
                          "_getUser(experience.participantId).name",
                          style: new TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                            fontSize: 21.0),
                          ),
                        subtitle: new Text(
                          "_getUser(experience.participantId).name"),
                        isThreeLine: false,
                        dense: false,
                      
                    ),
                    ),
                  ],
              ),
            ],
          ),
      
      ),
      );
    }

    Future<Null> refresh(){
      _reloadExperiences();
      return new Future<Null>.value();
    }

    Widget _getListViewWidget(){
      return new Flexible(
        child: new RefreshIndicator(
          onRefresh: refresh,
          child: new ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: _experiences.length,
            itemBuilder: _buildExperienceItem
          ),
        )
      );
    }

  Widget _buildBody(){
    return new Container(
      margin: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
      child: new Column(children: <Widget>[_getListViewWidget()],
      )
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(appBar: AppBar(
        title: Text("Ervaringen", style: TextStyle(color: Colors.white)),
        iconTheme: new IconThemeData(color:Colors.white)
      ),
      body: _buildBody(),
    );
  }
}