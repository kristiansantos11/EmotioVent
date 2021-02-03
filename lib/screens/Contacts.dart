import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Contacts extends StatefulWidget {
  @override
  _ContactsState createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Center(
          child: Text("Contacts go here!")
        ),
      ],
    );
  }
}