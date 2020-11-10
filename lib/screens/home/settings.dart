import 'package:coffe_app/models/brew.dart';
import 'package:coffe_app/models/user.dart';
import 'package:coffe_app/services/database.dart';
import 'package:coffe_app/shared/const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final _formKey=new GlobalKey<FormState>();

  final List<String>sugars=['0','1','2','3','4'];
  String _name;
  String _sugars;
  String error='';
  int _strength;  //uzeti iz baze current vrijednosti

  @override
  Widget build(BuildContext context) {
    final user=Provider.of<User>(context);
    return Form(
      key: _formKey,
      child:Column(
        children:<Widget>[
        Text('Update preferences',style: TextStyle(fontSize: 16,letterSpacing: 2.2),),
        SizedBox(height: 20),
          TextFormField(

            decoration: textInputDecoration.copyWith(hintText: 'Name'),
            validator: (val)=>val.isEmpty? 'Enter a name':null,
            onChanged: (val)=> setState(()=>_name=val)
          ),
          SizedBox(height: 20),
          DropdownButtonFormField(
            value: _sugars?? '0',
              items: sugars.map((sug) {
                return DropdownMenuItem(value: sug,child: Text(sug.toString()+ ' sugars'),);

              }).toList(),
           onChanged: (val){setState(() {
             _sugars=val;
           });},
          ),
          SizedBox(height: 20),
          //slider
          Slider(
            label: 'Strength',

            activeColor: Colors.brown[_strength??100], inactiveColor: Colors.brown[_strength??100],
              min: 100.0,max: 900.0,divisions:8, value: (_strength??100).toDouble(),
            onChanged :(val) {setState(() {
              _strength=val.toInt();

            });},
          ),
          RaisedButton(
              child: Text('Update'),
              onPressed: ()async{
                if(_formKey.currentState.validate()){
                  new DatabaseService(uid:user.uid).update(_sugars, _name, _strength??100);
                  error='';
                }
                else{
                  setState(() {
                    error='Some fields are required.';
                  });
                }

                //update current user function to implement
          }),
          SizedBox(height: 20,),
          Text(error,style: TextStyle(color:Colors.red),),


      ],
      ),
    );
  }
}
