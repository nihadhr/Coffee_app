import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffe_app/models/brew.dart';

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


  Stream<List<Brew>>get brews{
    return collection.snapshots().map(_getBrewList);
  }

}