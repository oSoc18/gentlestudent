import 'dart:async';

import 'package:Gentle_Student/data/api.dart';
import 'package:Gentle_Student/models/news.dart';
import 'package:Gentle_Student/pages/information/news/news_detail/news_detail_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class NewsPage extends StatefulWidget {
  static String tag = 'news-page';
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<News> _news = [];
  NewsApi _newsApi;

  @override
  void initState() {
    super.initState();
    _loadFromFirebase();
  }

  _loadFromFirebase() async {
    final newsApi = new NewsApi();
    final news = await newsApi.getAllNews();
    if (this.mounted) {
      setState(() {
        _newsApi = newsApi;
        _news = news;
        _news.sort((a, b) => a.published.compareTo(b.published));
        reverse(_news);
      });
    }
  }

  _reloadOpportunities() async {
    if (_newsApi != null) {
      final news = await _newsApi.getAllNews();
      if (this.mounted) {
        setState(() {
          _news = news;
          _news.sort((a, b) => a.published.compareTo(b.published));
          reverse(_news);
        });
      }
    }
  }

  _navigateToNewsDetails(News news) async {
    Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (BuildContext context) => new NewsDetailPage(news),
      ),
    );
  }

  Widget _buildNewsItem(BuildContext context, int index) {
    News news = _news[index];

    return new Container(
      margin: const EdgeInsets.only(
        top: 3.0,
        bottom: 10.0,
      ),
      child: new GestureDetector(
        onTap: () => _navigateToNewsDetails(news),
        child: Card(
          child: new Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new CachedNetworkImage(
                imageUrl: news.imageUrl,
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
                  news.title,
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
                  news.shortText,
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
            itemCount: _news.length,
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
        title: Text("Nieuws", style: TextStyle(color: Colors.white)),
        iconTheme: new IconThemeData(color: Colors.white),
      ),
      body: _buildBody(),
    );
  }
}
