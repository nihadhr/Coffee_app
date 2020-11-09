import 'package:coffe_app/services/auth.dart';
import 'package:coffe_app/shared/const.dart';
import 'package:coffe_app/shared/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  AuthService _authService =new AuthService();
  String email='';
  String password='';
  String error='';
  bool loading=false;
  final _formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return loading? Loading(): Scaffold(
      backgroundColor: Colors.brown[200],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        title: Text('Sign up',style: TextStyle(letterSpacing: 2)),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.login_sharp),
            label: Text('Sign in'),
            onPressed: (){
              widget.toggleView();
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical:15.0,horizontal: 25.0),
        child: Form(
          key: _formKey,
          child: Column(

            children: <Widget>[
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Email'),

                validator: (val)=>val.isEmpty?'Enter an email':null ,
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
                  obscureText: true,cursorColor: Colors.white,style: TextStyle(color: Colors.white,letterSpacing: 2),
                  validator: (val)=>val.length<6?'Password must be at least 6 characters long':null ,
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                color: Colors.brown[400],
                child: Text('Register',style: TextStyle(color: Colors.white)),
                onPressed: ()async{
                    if(_formKey.currentState.validate()){
                      setState(() {
                        loading=true;
                      });
                      dynamic res=await _authService.registerWithEmailPassword(email, password);
                      if(res == null){
                          setState(() {
                            loading=false;
                            error='User can not be created';
                          });

                      }
                    }
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
