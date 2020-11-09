import 'package:coffe_app/services/database.dart';
import 'package:coffe_app/shared/const.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final _formKey=new GlobalKey<FormState>();
  final List<String>sugars=['0','1','2','3','4'];
  DatabaseService _contextdb=new DatabaseService();
  String _name;
  String _sugars;
  int _strength;


  @override
  Widget build(BuildContext context) {
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
          //dropdown
          RaisedButton(
              child: Text('Update'),
              onPressed: ()async{
                // _contextdb.updateUserData(_sugars, _name, _strength??100);
                //update current user function to implement
          }),

      ],
      ),
    );
  }
}
