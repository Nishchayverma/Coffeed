import 'package:firebaseflutter/authen.dart';
import 'package:firebaseflutter/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'database/database.dart';
import 'package:provider/provider.dart';

import 'brewlist.dart';
import 'brewmodel.dart';

class home extends StatelessWidget {
  final authservice _auth = authservice();
  @override
  Widget build(BuildContext context) {
    void _showSetting() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: Setting(),
            );
          });
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: Scaffold(
        
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Brew Crew'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton(
              padding: EdgeInsets.only(top: 6.0),
              child: Column(
                children: <Widget>[
                  Icon(Icons.person, semanticLabel: 'logout'),
                  Text('logout')
                ],
              ),
              onPressed: () async {
                Text('loading');
                await _auth.signout();
              },
            ),
            FlatButton.icon(
              icon: Icon(Icons.settings),
              label: Text('setting'),
              onPressed: () => _showSetting(),
            )
          ],
        ),
        body: Brewlist(),
      ),
    );
  }
}
