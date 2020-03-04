import 'package:firebaseflutter/brewmodel.dart';
import 'package:firebaseflutter/brewtile.dart';
import 'package:firebaseflutter/settings.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class Brewlist extends StatefulWidget {
  @override
  BrewlistState createState() => BrewlistState();
}

class BrewlistState extends State<Brewlist> {


  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<Brew>>(context) ?? [];

    return ListView.builder(
      itemCount: brews.length,
      itemBuilder: (context, index) {
        return BrewTile(brew: brews[index]);
      },
    );
  }
}
