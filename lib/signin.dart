
import 'package:flutter/material.dart';
import 'authen.dart';
import 'decoration.dart';
import 'register.dart'; 

class sign extends StatefulWidget {
  @override
  signState createState() => signState();
}

class signState extends State<sign> {
  authservice _auth = authservice();
  final _formkey = GlobalKey<FormState>();
   bool loading= false;

  String email = '';
  String pass = '';
  String error = '';

  // to access authservice class we make objects to access its functions
  @override
  Widget build(BuildContext context) {
    
     
     return loading ? Loading() :Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign in to Brewed'),
        actions: <Widget>[
          FlatButton.icon(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => register()));
              },
              icon: Icon(Icons.person),
              label: Text('Register'))
        ],
        automaticallyImplyLeading: false,
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: _formkey,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  decoration: textdecorationemail,
                  keyboardType: TextInputType.emailAddress,
                  validator: (val) => val.isEmpty ? 'Enter email' : null,
                  onChanged: (val) {
                    setState(() {
                      email = val;
                    });
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(

                  decoration: textdecorationpass,
                  validator: (val) => val.length < 6
                      ? 'Enter a password 6+ character long'
                      : null,
                  obscureText: true,
                  onChanged: (val) {
                    setState(() {
                      pass = val;
                    });
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                RaisedButton(
                  color: Colors.pink,
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () async {
                    if (_formkey.currentState.validate()) {

                      setState(() {
                        loading=true;
                      });
                      dynamic result = await _auth.signwithemail(email, pass);

                      if (result == null) {
                        setState(() {
                        
                          error = 'please enter valid email ';
                            loading= false;
                        });
                      }
                    }
                  },
                ),
                SizedBox(
                  height: 12.0,
                ),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                )
              ],
            ),
          )),
    );
     
  }
}
