import 'package:flutter/material.dart';

class FilterDialog extends StatefulWidget {
  @override
  FilterDialogState createState() => new FilterDialogState();
}

class FilterDialogState extends State<FilterDialog> {
  //Declaration of the variables
  String groupvalueCategory = "Alles";
  String groupvalueDifficulty = "Alles";
  TextEditingController issuerName;

  //Functions
  FilterDialogState() {
    issuerName = new TextEditingController();
  }

  @override
  void dispose() {
    issuerName.dispose();
    super.dispose();
  }

  void _changeCategory(String e) {
    setState(() {
      groupvalueCategory = e;
    });
  }

  void _changeDifficulty(String e) {
    setState(() {
      groupvalueDifficulty = e;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text(
          'Filter leerkansen',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: new IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            //The issuer name textfield
            TextField(
              controller: issuerName,
              keyboardType: TextInputType.text,
              autofocus: false,
              decoration: InputDecoration(
                labelText: 'Naam van de issuer',
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 24.0),

            //List of difficulties
            ListView(
              shrinkWrap: true,
              children: <Widget>[
                new ExpansionTile(
                  initiallyExpanded: true,
                  title: Text(
                    'Niveaus',
                    style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black),
                  ),
                  children: <Widget>[
                    ListTile(
                      title: Text('Alles'),
                      leading: new Radio(
                        onChanged: (String e) => _changeDifficulty(e),
                        activeColor: Colors.lightBlue,
                        value: "Alles",
                        groupValue: groupvalueDifficulty,
                      ),
                    ),
                    ListTile(
                      title: Text('Beginner'),
                      leading: new Radio(
                        onChanged: (String e) => _changeDifficulty(e),
                        activeColor: Colors.lightBlue,
                        value: "Beginner",
                        groupValue: groupvalueDifficulty,
                      ),
                    ),
                    ListTile(
                      title: Text('Intermediate'),
                      leading: new Radio(
                        onChanged: (String e) => _changeDifficulty(e),
                        activeColor: Colors.lightBlue,
                        value: "Intermediate",
                        groupValue: groupvalueDifficulty,
                      ),
                    ),
                    ListTile(
                      title: Text('Expert'),
                      leading: new Radio(
                        onChanged: (String e) => _changeDifficulty(e),
                        activeColor: Colors.lightBlue,
                        value: "Expert",
                        groupValue: groupvalueDifficulty,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 8.0),

            //List of categories
            ListView(
              shrinkWrap: true,
              children: <Widget>[
                new ExpansionTile(
                  title: Text(
                    'Categorieën',
                    style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black),
                  ),
                  children: <Widget>[
                    ListTile(
                      title: Text('Alles'),
                      leading: new Radio(
                        onChanged: (String e) => _changeCategory(e),
                        activeColor: Colors.lightBlue,
                        value: "Alles",
                        groupValue: groupvalueCategory,
                      ),
                    ),
                    ListTile(
                      title: Text('Digitale geletterdheid'),
                      leading: new Radio(
                        onChanged: (String e) => _changeCategory(e),
                        activeColor: Colors.lightBlue,
                        value: "Digitale geletterdheid",
                        groupValue: groupvalueCategory,
                      ),
                    ),
                    ListTile(
                      title: Text('Duurzaamheid'),
                      leading: new Radio(
                        onChanged: (String e) => _changeCategory(e),
                        activeColor: Colors.lightBlue,
                        value: "Duurzaamheid",
                        groupValue: groupvalueCategory,
                      ),
                    ),
                    ListTile(
                      title: Text('Ondernemingszin'),
                      leading: new Radio(
                        onChanged: (String e) => _changeCategory(e),
                        activeColor: Colors.lightBlue,
                        value: "Ondernemingszin",
                        groupValue: groupvalueCategory,
                      ),
                    ),
                    ListTile(
                      title: Text('Onderzoek'),
                      leading: new Radio(
                        onChanged: (String e) => _changeCategory(e),
                        activeColor: Colors.lightBlue,
                        value: "Onderzoek",
                        groupValue: groupvalueCategory,
                      ),
                    ),
                    ListTile(
                      title: Text('Wereldburgerschap'),
                      leading: new Radio(
                        onChanged: (String e) => _changeCategory(e),
                        activeColor: Colors.lightBlue,
                        value: "Wereldburgerschap",
                        groupValue: groupvalueCategory,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 8.0),

            //The apply filter button
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                borderRadius: BorderRadius.circular(10.0),
                shadowColor: Colors.lightBlueAccent.shade100,
                elevation: 5.0,
                child: MaterialButton(
                  minWidth: 200.0,
                  height: 42.0,
                  onPressed: () {
                    Navigator.of(context).pop(
                      List.of([issuerName.text, groupvalueCategory, groupvalueDifficulty]),
                    );
                  },
                  color: Colors.lightBlueAccent,
                  child: Text('Pas filter toe',
                      style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}