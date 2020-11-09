import 'package:coffe_app/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:coffe_app/models/user.dart';
class AuthService{

  final FirebaseAuth _auth= FirebaseAuth.instance;

  User _returnUser(FirebaseUser user){
    return user!=null?User(uid:user.uid):null;
  }

  Stream<User>get user{
    return _auth.onAuthStateChanged.map((FirebaseUser user) => (_returnUser(user)));
  }

  //sign in anon
  Future signInAnon() async{
    try{
      AuthResult result=await _auth.signInAnonymously();
      FirebaseUser user=result.user;
      return _returnUser(user);
    }
    catch(e){
      print(e.toString());
      return null;
    }

  }
  Future registerWithEmailPassword(String email,String password)async{
    try{
      AuthResult result= await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user=result.user;
      await DatabaseService(uid: user.uid).updateUserData('0', 'My new nickname', 100);
      return _returnUser(user);
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign in email&passw
  Future signInWithEmailPassword(String email,String password)async{
    try{
      AuthResult result= await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user=result.user;
      print(user.uid);
      return _returnUser(user);
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }
  Future signOut() async{
    try{
      return _auth.signOut();
    }
    catch(e){
      print(e.toString());
      return null;
    }

  }



}