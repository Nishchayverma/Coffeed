import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseflutter/database/database.dart';
import 'package:firebaseflutter/users.dart';


class authservice {

   final FirebaseAuth _auth = FirebaseAuth.instance;// _auth is an object of firebaseauth.instance;

    //we only need user id so we create user obj based on FirebaseUser
   User _userfromFirebaseUser(FirebaseUser user){
     return user != null ? User(uid: user.uid) : null ;
     
   }
   //Stream that tells what event occured (sign in or sign out)
   Stream<User> get user{
     return _auth.onAuthStateChanged
         .map(_userfromFirebaseUser);
        // .map((FirebaseUser user) => _userfromFirebaseUser(user));  // map the stream of users based on our user class
   }

     //signin anon

   Future signinAnon() async {
     try{
        AuthResult result= await _auth.signInAnonymously() ;     //  await _auth.signInAnonymously() returns an auth result
        FirebaseUser user = result.user;   // to access user of  result
       return _userfromFirebaseUser(user);
     }
     catch(e){
                print(e.toString());
                return null;
     }
   }
   //register  with password and email
   Future regwithemail(String email, String password) async {
     try {
       AuthResult result = await _auth.createUserWithEmailAndPassword(
           email: email, password: password);
       FirebaseUser user = result.user;

         await DatabaseService(uid: user.uid).updateUserData('0', 'new team member', 100);

       return _userfromFirebaseUser(user);
     } catch (e) {
       print(e.toString());
       return null;
     }
   }

     //sign in with email and password

   Future signwithemail(String email, String password) async {
     try {
       AuthResult result = await _auth.signInWithEmailAndPassword(
           email: email, password: password);
       FirebaseUser user = result.user;
       return _userfromFirebaseUser(user);
     } catch (e) {
       print(e.toString());
       return null;
     }
   }





   //sign out
    Future signout() async{
     try{
       return await _auth.signOut();
     }
     catch(e){
       print(e.toString());
           return null;
     }
    }


}

