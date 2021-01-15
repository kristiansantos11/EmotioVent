// UNUSED: You can use Center then CircularProgressIndicator instead.

import 'package:flutter/material.dart';

class EVLoading extends StatefulWidget {
  static const routeName = '/loading';

  @override
  _EVLoadingState createState() => _EVLoadingState();
}

class _EVLoadingState extends State<EVLoading> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: Text(
            "Loading...",
            style: TextStyle(
              fontSize: 15,
              fontFamily: 'Nexa',
              fontWeight: FontWeight.w700,
            )
          )
        )
      ),
    );
  }
}