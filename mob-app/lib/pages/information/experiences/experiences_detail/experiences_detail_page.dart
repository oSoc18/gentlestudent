import 'package:Gentle_Student/models/experience.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';

//This page represents one experience
class ExperiencesDetailPage extends StatefulWidget {
  //We need an Experience object to render this page
  final Experience experience;

  //We pass the object to the constructor of this page
  ExperiencesDetailPage(this.experience);

  //We pass the object to the state page
  @override
  _ExperiencesDetailPageState createState() => _ExperiencesDetailPageState(experience);
}

class _ExperiencesDetailPageState extends State<ExperiencesDetailPage> {
  //Declaration of the variables
  Experience _experience;

  //Constructor
  _ExperiencesDetailPageState(this._experience);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ervaring", style: TextStyle(color: Colors.white)),
        iconTheme: new IconThemeData(color: Colors.white),
      ),
      body: ListView(
        children: <Widget>[
          //Big image
          new CachedNetworkImage(
            imageUrl: _experience.imageUrl,
            placeholder: new CircularProgressIndicator(),
            errorWidget: new Icon(Icons.error),
          ),

          //Title
          new Padding(
            padding: EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              top: 26.0,
              bottom: 10.0,
            ),
            child: new Text(
              _experience.title,
              textAlign: TextAlign.center,
              style: new TextStyle(
                fontSize: 21.0,
              ),
            ),
          ),

          //Blue box
          new Padding(
            padding: EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              top: 16.0,
              bottom: 10.0,
            ),
            child: new Container(
              padding: EdgeInsets.all(14.0),
              decoration: new BoxDecoration(
                border: new Border.all(color: Colors.lightBlue),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //Author
                  new Row(
                    children: <Widget>[
                      new Text(
                        "Auteur:",
                        style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                          color: Colors.lightBlue,
                        ),
                      ),
                      new Expanded(
                        child: new Text(
                          " " + _experience.author,
                          style: new TextStyle(
                            fontSize: 14.0,
                            color: Colors.lightBlue,
                          ),
                        ),
                      ),
                    ],
                  ),
                  new SizedBox(
                    height: 6.0,
                  ),

                  //Published date
                  new Row(
                    children: <Widget>[
                      new Text(
                        "Gepubliceerd op:",
                        style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                          color: Colors.lightBlue,
                        ),
                      ),
                      new Expanded(
                        child: new Text(
                          " " + _makeDate(_experience.published),
                          style: new TextStyle(
                            fontSize: 14.0,
                            color: Colors.lightBlue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          //Short text
          new Padding(
            padding: EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              top: 16.0,
              bottom: 8.0,
            ),
            child: new Text(
              _experience.shortText,
              style: new TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          //Long text
          new Padding(
            padding: EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              top: 8.0,
              bottom: 10.0,
            ),
            child: new Text(
              _experience.longText,
              style: new TextStyle(
                fontSize: 14.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  //Function for making a date more readable
  static String _makeDate(DateTime date) {
    return formatDate(date, [dd, '/', mm, '/', yyyy]);
  }
}
