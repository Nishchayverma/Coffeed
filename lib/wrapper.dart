import 'package:flutter/material.dart';
import 'home.dart';
import 'authenticate.dart';
import 'package:provider/provider.dart';
import 'users.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user); // to specify the stream to listen to we used <User>
    if (user == null) {
      return authenticate();
    }
    else {
      return home();
    }
  }
}