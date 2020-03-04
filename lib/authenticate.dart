import 'package:firebaseflutter/register.dart';
import 'package:flutter/material.dart';
import 'signin.dart';
import 'register.dart';

class authenticate extends StatefulWidget{
  @override
  authenState createState()=> authenState();

}

class authenState extends State<authenticate>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: register(),
      );

  }
}