import 'package:flutter/material.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

class EVError extends StatefulWidget {
  static const routeName = '/error';

  @override
  _EVErrorState createState() => _EVErrorState();
}

class _EVErrorState extends State<EVError> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          color: Colors.red[400],
          child: Text(
            "An error has occured",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w900,
              fontSize: ResponsiveFlutter.of(context).scale(50)
            ),
          ),
        )
      )
    );
  }
}