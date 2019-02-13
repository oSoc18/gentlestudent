import 'package:Gentle_Student/models/news.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';

//This page represents one news article
class NewsDetailPage extends StatefulWidget {
  //We need a News object to render this page
  final News news;

  //We pass the object to the constructor of this page
  NewsDetailPage(this.news);

  //We pass the object to the state page
  @override
  _NewsDetailPageState createState() => _NewsDetailPageState(news);
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  //Delcaration of the variables
  News _news;

  //Constructor
  _NewsDetailPageState(this._news);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nieuwsbericht", style: TextStyle(color: Colors.white)),
        iconTheme: new IconThemeData(color: Colors.white),
      ),
      body: ListView(
        children: <Widget>[
          //Big image
          new CachedNetworkImage(
            imageUrl: _news.imageUrl,
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
              _news.title,
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
                          " " + _news.author,
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
                          " " + _makeDate(_news.published),
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
              _news.shortText,
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
              _news.longText,
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
