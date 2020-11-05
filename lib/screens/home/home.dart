import 'package:coffe_app/screens/authenticate/authenticate.dart';
import 'package:coffe_app/services/auth.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {

  final AuthService _authService=new AuthService();
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[200],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        actions: <Widget>[
          FlatButton.icon(
          icon: Icon(Icons.person),
            label: Text('Logout'),
            onPressed: ()async{
             await _authService.signOut();
            },
          ),
        ],
      ),
      body: Center(
        child:Text('Welcome',style: TextStyle(fontSize: 40,letterSpacing: 2),),
      ),
    );
  }
}

