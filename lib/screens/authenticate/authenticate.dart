import 'package:coffe_app/screens/authenticate/register.dart';
import 'package:flutter/material.dart';
import 'package:coffe_app/screens/authenticate/sign_in.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool toggle=true;

  void toggleView(){
    setState(() {
      toggle=!toggle;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(toggle)return SignIn(toggleView:toggleView); else return Register(toggleView:toggleView);
  }
}

