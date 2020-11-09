import 'package:coffe_app/models/brew.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CoffeeList extends StatefulWidget {
  @override
  _CoffeeListState createState() => _CoffeeListState();
}

class _CoffeeListState extends State<CoffeeList> {
  @override


  Widget build(BuildContext context) {
    final list=Provider.of<List<Brew>>(context);  //unutar home.dart definisan je dijeljena lista, kojoj pristupa ima i ovaj widget kao child
    return ListView.builder(  //future builder...
      itemCount: list.length,
      itemBuilder: (context,index){
        return Card(
          margin: EdgeInsets.fromLTRB(20,10,20,10),
          child: ListTile(
            leading: CircleAvatar(backgroundColor: Colors.brown[list[index].strength]),
            title: Text(list[index].name),
            subtitle: Text('Takes '+list[index].sugars+' sugars.'),
          ),
        );
      },
    );
  }
}
