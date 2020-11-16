import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffe_app/models/brew.dart';
import 'package:coffe_app/screens/authenticate/authenticate.dart';
import 'package:coffe_app/screens/home/coffe_list.dart';
import 'package:coffe_app/screens/home/settings.dart';
import 'package:coffe_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:coffe_app/services/database.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {

  final AuthService _authService=new AuthService();


  @override

  Widget build(BuildContext context) {

    void _openBottomSheet(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(padding: EdgeInsets.fromLTRB(20, 40, 20, 40),
          color: Colors.brown[100],
          child: Settings(),
        );
      });
    }
    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: Scaffold(
        backgroundColor: Colors.brown[200],
        appBar: AppBar(
          title: Text('Home',style: TextStyle(letterSpacing: 2),),
          backgroundColor: Colors.brown[400],
          actions: <Widget>[
            FlatButton.icon(
            icon: Icon(Icons.person),
              label: Text('Logout'),
              onPressed: ()async{
               await _authService.signOut();
              },
            ),
            FlatButton.icon(
              icon: Icon(Icons.settings),
              label: Text('Settings'),
              onPressed: (){
                _openBottomSheet();
              },
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/coffee_bg.png'),fit:BoxFit.cover)),
          child: CoffeeList(

          ),
        ),
      ),
    );
  }
}

