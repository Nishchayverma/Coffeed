import 'package:firebaseflutter/database/database.dart';
import 'package:firebaseflutter/decoration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'users.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  final _formkey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  String _currentname;
  String _currentsugars;
  int _currentstrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid)
            .userData, //userdata will listen to the stream within form widget
        builder: (context, snapshot) {
          // snapshot is implementation of data coming down a stream

          UserData userData = snapshot.data;
          if (snapshot.hasData) {
            return Form(
              key: _formkey,
              child: Column(
                children: <Widget>[
                  Text(
                    'Update your Settings',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    initialValue: userData.name,
                    decoration: InputDecoration(
                      focusColor: Colors.red,
                    ),
                    validator: (val) =>
                        val.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val) => setState(() => _currentname = val),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  DropdownButtonFormField(
                    value: _currentsugars ?? userData.sugars,
                    items: sugars.map((sugar) {
                      return DropdownMenuItem(
                        value: sugar,
                        child: Text('$sugar sugars'),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => _currentsugars = val),
                  ),
                  CupertinoSlider(
                    value: (_currentstrength ?? userData.strength).toDouble(),
                    min: 100,
                    max: 900,
                    divisions: 8,
                    onChanged: (val) =>
                        setState(() => _currentstrength = val.round()),
                    activeColor: Colors.brown[_currentstrength ??
                        userData
                            .strength], //if the value of something is null use ?? to provide fallback value

                    thumbColor:
                        Colors.brown[_currentstrength ?? userData.strength],
                  ),
                  RaisedButton(
                    color: Colors.pink[400],
                    child: Text(
                      'Update',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () async {
                     if(_formkey.currentState.validate()){
                       await DatabaseService(uid:user.uid).updateUserData(
                         
                         _currentsugars ?? userData.sugars,
                         _currentname ?? userData.name,
                         _currentstrength ?? userData.strength,
                       );
                       Navigator.pop(context);
                     }
                    },
                  ),
                ],
              ),
            );
          } else {
            Loading();
          }
        });
  }
}
