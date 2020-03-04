import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const textdecorationemail = InputDecoration(
  focusColor: Colors.red,
  labelText: 'Enter email',
  labelStyle: TextStyle(color: Colors.grey),
);

const textdecorationpass = InputDecoration(
  focusColor: Colors.red,
  labelText: 'Enter password',
  labelStyle: TextStyle(color: Colors.grey),
);

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.brown[100],
      child: Center(
        child: SpinKitThreeBounce(
          color: Colors.brown,
           size: 50.0,)
      )
    );
  }
}