import 'package:flutter/material.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

class EVLoading extends StatefulWidget {
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