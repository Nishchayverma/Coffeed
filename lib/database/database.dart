
import 'package:firebaseflutter/brewmodel.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseflutter/users.dart';

class DatabaseService {
  //collection ref.

  final String uid;
  DatabaseService({this.uid});


  final CollectionReference brewCollection =
      Firestore.instance.collection('brews');
  Future updateUserData(String sugar, String name, int strength) async {
            return await brewCollection.document(uid).setData({
                  'sugars' : sugar,
                  'name' : name,
                  'strength' : strength,
            });

  }

  //brew list from snapshot

  List<Brew> _brewlistsnap(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Brew(
        name: doc.data['name'] ?? '', //empty string is name is not there
        strength: doc.data['strength'] ?? 0 ,
        sugar: doc.data['sugars'] ?? '0' ,
      );
    }).toList();
  }
           
            // stream to get data
      Stream<List<Brew>> get brews{
        return brewCollection.snapshots().map(_brewlistsnap);

      }  
 //userdata from snapshot
      UserData _userDataSnapshot (DocumentSnapshot snapshot){
          return UserData(
            uid: uid,
            name: snapshot.data['name'],
            strength: snapshot.data['strength'],
            sugars: snapshot.data['sugars'],


          );
      } 



           //get user doc stream
      Stream<UserData> get userData {
        return brewCollection.document(uid).snapshots().
        map(_userDataSnapshot);
      }   

     
     
     }

