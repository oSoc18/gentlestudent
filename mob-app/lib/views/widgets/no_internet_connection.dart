import 'package:flutter/material.dart';

class NoInternetConnection extends StatelessWidget {
  final VoidCallback action;

  NoInternetConnection({@required this.action});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[        
        Text(
          'Maak verbinding met het internet en druk op de knop hieronder.',
          style: TextStyle(
            fontSize: 16.0,
          ),
          textAlign: TextAlign.center,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 18.0),
          child: FloatingActionButton(
            backgroundColor: Theme.of(context).primaryColorLight,
            child: Icon(Icons.refresh, size: 30.0,),
            onPressed: action,
          ),
        ),
      ],
    );
  }
}