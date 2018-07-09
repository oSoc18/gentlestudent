import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

class OpportunityListPage extends StatefulWidget {
  static String tag = 'opportunity-list-page';
  @override
  _OpportunityListPageState createState() => _OpportunityListPageState();
}

class _OpportunityListPageState extends State<OpportunityListPage> {
  var list;
  var random;
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    random = Random();
    refreshList();
  }

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    setState(() {
      list = List.generate(random.nextInt(10) + 1, (i) => "Item $i");
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Leerkansen", style: TextStyle(color: Colors.white)),
        iconTheme: new IconThemeData(color: Colors.white),
      ),
      key: refreshKey,
      body: RefreshIndicator(
        child: ListView.builder(
          itemCount: list?.length,
          itemBuilder: (context, i) => ListTile(
                title: Text(list[i]),
              ),
        ),
        onRefresh: refreshList,
      ),
    );
  }
}
