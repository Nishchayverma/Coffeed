import 'package:firebaseflutter/decoration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'authen.dart';
import 'signin.dart';
class register extends StatefulWidget {
  @override
  registerState createState() => registerState();
}

class registerState extends State<register> {
  authservice _auth = authservice();
  final _formkey =GlobalKey<FormState>(); // helps to validate the state of our form


  String email = '';
  String pass = '';
  String error ='';
   bool loading= false;


  @override
  Widget build(BuildContext context) {
      
    return loading ? Loading() :Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign up to Brewed'),
        actions: <Widget>[
          FlatButton.icon(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => sign()));
              },
              icon: Icon(Icons.person),
              label: Text('Sign in'))
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
                  validator: (val)=> val.isEmpty? 'Enter email' : null,
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
                  validator: (val)=> val.length<6? 'Enter a password 6+ character long' : null,
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
                    'Register',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () async {
                    
                    if(_formkey.currentState.validate()) {
                      setState(() {
                        
                        loading=true;
                      });
                      dynamic result = await _auth.regwithemail(email, pass);
                      if (result == null) {
                        setState(() {
                        
                          error = 'please enter valid email or password';
                            loading=false;
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
                  style: TextStyle(color: Colors.red,fontSize: 14.0),
                )
              ],
            ),
          )),
    );
     
  }
}
