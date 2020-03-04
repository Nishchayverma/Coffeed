import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'wrapper.dart';

import 'users.dart';
import 'authen.dart';

void main() => runApp(First());

class First extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StreamProvider<User>.value(   //since the stream returns a users type data so we <user>
      // to manage the widgets going to execute ,now all child widgets can listen to the stream of users

      value: authservice().user,
      // accessing the user stream of authservice class

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Brewed',
        home: Wrapper(),
      ),
    );
  }
}
