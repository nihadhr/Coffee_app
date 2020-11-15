import 'package:coffe_app/models/brew.dart';
import 'package:coffe_app/models/user.dart';
import 'package:coffe_app/services/database.dart';
import 'package:coffe_app/shared/const.dart';
import 'package:coffe_app/shared/loading.dart';
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
  int _strength;

  @override
  Widget build(BuildContext context) {
    final user=Provider.of<User>(context);
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context,snapshot) {
        if(snapshot.hasData) {
          UserData user=snapshot.data;
          return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text('Update preferences',
                  style: TextStyle(fontSize: 16, letterSpacing: 2.2),),
                SizedBox(height: 20),
                TextFormField(
                    initialValue:user.name,
                    decoration: textInputDecoration.copyWith(hintText: 'Name'),
                    validator: (val) => val.isEmpty ? 'Enter a name' : null,
                    onChanged: (val) => setState(() => _name = val)
                ),
                SizedBox(height: 20),
                DropdownButtonFormField(
                  value:_sugars ?? user.sugars,
                  items: sugars.map((sug) {
                    return DropdownMenuItem(value: sug, child: Text(sug
                        .toString() + ' sugars'),);
                  }).toList(),
                  onChanged: (val) {
                    setState(() {
                      _sugars = val;
                    });
                  },
                ),
                SizedBox(height: 20),
                //slider
                Slider(
                  label: 'Strength',

                  activeColor: Colors.brown[_strength ?? user.strength],
                  inactiveColor: Colors.brown[_strength ?? user.strength],
                  min: 100.0,
                  max: 900.0,
                  divisions: 8,
                  value: (_strength ?? user.strength).toDouble(),
                  onChanged: (val) {
                    setState(() {
                      _strength = val.toInt();
                    });
                  },
                ),
                RaisedButton(
                    child: Text('Update'),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        new DatabaseService(uid: user.uid).update(
                            _sugars??user.sugars,_name??user.name,_strength?? user.strength ?? 100);
                        setState(() {
                          error = '';
                        });
                      }
                      else {
                        setState(() {
                          error = 'Some fields are required.';
                        });
                      }

                      //update current user function to implement
                    }),
                SizedBox(height: 20,),
                Text(error, style: TextStyle(color: Colors.red),),


              ],
            ),

          );}
          else{
            return Loading();
          }
        }
    );
  }
}
