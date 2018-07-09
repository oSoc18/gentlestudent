import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

class OudeLijst extends StatefulWidget {
  static String tag = 'oude-lijst';
  @override
  _OudeLijstState createState() => _OudeLijstState();
}

class _OudeLijstState extends State<OudeLijst> {
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
