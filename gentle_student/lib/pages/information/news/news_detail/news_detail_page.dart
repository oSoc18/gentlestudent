import 'package:Gentle_Student/models/news.dart';
import 'package:flutter/material.dart';

class NewsDetailPage extends StatefulWidget {
  static String tag = 'news-detail-page';
  final News news;
  NewsDetailPage(this.news);
  @override
  _NewsDetailPageState createState() => _NewsDetailPageState(news);
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  News _news;
  _NewsDetailPageState(this._news);

  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}