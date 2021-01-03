import 'package:flutter/material.dart';
import 'package:emotiovent/services/EV_SizeGetter.dart';

class ShakeShowAnimals extends StatefulWidget {
  static const routeName = "/shake4animal";

  final String emotion;

  const ShakeShowAnimals({Key key, this.emotion}) : super(key: key);

  @override
  _ShakeShowAnimalsState createState() => _ShakeShowAnimalsState(emotion);
}

class _ShakeShowAnimalsState extends State<ShakeShowAnimals> {
  final String emotion;

  _ShakeShowAnimalsState(this.emotion);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[

          Hero(
            tag: emotion,
            child: Container(
              width: getWidth(context),
              height: getHeight(context),
              color: Colors.white,
            ),
          ),

          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[

              ]
            )
          ),

        ],
      )
    );
  }
}