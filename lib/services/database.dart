import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffe_app/models/brew.dart';
import 'package:coffe_app/models/user.dart';

class DatabaseService{

  final CollectionReference collection = Firestore.instance.collection('brews');  //kao tabela u bazi
  final String uid;
  DatabaseService({this.uid});

  Future updateUserData(String sugars,String name, int strength) async{
    return await collection.document(uid).setData({
      'sugars':sugars,
      'name':name,
      'strength':strength
    });
  }
  Future update(String sugars,String name, int strength) async{
    return await collection.document(uid).setData({
      'sugars':sugars,
      'name':name,
      'strength':strength
    });
  }
  List<Brew> _getBrewList(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Brew(
          name:doc.data['name'],
          strength: doc.data['strength'],
          sugars: doc.data['sugars']
      );
    }).toList();
  }
  UserData getUserData(DocumentSnapshot snapshot){
    return new UserData(
     uid: uid,
     sugars: snapshot.data['sugars'],
      name: snapshot.data['name'],
      strength: snapshot.data['strength']
    );
  }

  Stream<List<Brew>>get brews{
    return collection.snapshots().map(_getBrewList);
  }
  Stream<UserData>get userData{
    return collection.document(uid).snapshots()
        .map(getUserData);
  }

}