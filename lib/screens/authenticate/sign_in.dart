import 'package:coffe_app/models/user.dart';
import 'package:coffe_app/services/auth.dart';
import 'package:coffe_app/shared/const.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _authService=new AuthService();
  String email='';
  String password='';
  String error='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[200],
    appBar: AppBar(
      backgroundColor: Colors.brown[400],
      title: Text('Sign in',style: TextStyle(letterSpacing: 2)),
      actions: <Widget>[
        FlatButton.icon(
          icon: Icon(Icons.person_add_alt_1_rounded),
          label: Text('Sign up'),
          onPressed: (){
              widget.toggleView();
          },
        ),
      ],
    ),
    body: Container(
      padding: EdgeInsets.symmetric(vertical:15.0,horizontal: 25.0),
      child: Form(
        child: Column(

          children: <Widget>[
            TextFormField(
              decoration: textInputDecoration.copyWith(hintText: 'Email'),
            onChanged:(value){ setState(() {
              email=value;
            });} ,
            cursorColor: Colors.white,style: TextStyle(color: Colors.white,letterSpacing: 2),keyboardType:TextInputType.emailAddress,
            ),
            SizedBox(height: 20.0),
            TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Password'),
              onChanged:(value){ setState(() {
                password=value;
              }); },
              obscureText: true,cursorColor: Colors.white,style: TextStyle(color: Colors.white,letterSpacing: 2)
            ),
            SizedBox(height: 20.0),
            RaisedButton(
              color: Colors.brown[400],
                child: Text('Sign in',style: TextStyle(color: Colors.white)),
              onPressed: ()async{
                  dynamic result=await _authService.signInWithEmailPassword(email, password);
                  setState(() {
                    error='Username or password wrong';
                  });
              },
            ),
            SizedBox(height: 12.0),
            Text(error, style: TextStyle(color: Colors.red),)
          ],
        ),

      ),



    ),
    );
  }
}
