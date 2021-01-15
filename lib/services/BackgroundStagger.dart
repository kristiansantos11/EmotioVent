import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

class BackgroundStagger extends StatelessWidget {
  BackgroundStagger({Key key, this.controller}) :

    darkColor = ColorTween(
      begin: Colors.blue[500], 
      end: Colors.green[500]
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0, 1,
          curve: Curves.ease,
        ),
      ),
    ),

    normalColor = ColorTween(
      begin: Colors.blue[400], 
      end: Colors.green[400]
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0, 1,
          curve: Curves.ease,
        ),
      ),
    ),

    lightColor = ColorTween(
      begin: Colors.blue[300], 
      end: Colors.green[300]
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0, 1,
          curve: Curves.ease,
        ),
      ),
    ),

    super(key: key);

  final AnimationController controller;
  final Animation<Color> darkColor;
  final Animation<Color> normalColor;
  final Animation<Color> lightColor;

  Widget _buildAnimation(BuildContext context, Widget child){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            darkColor.value, normalColor.value, lightColor.value
          ]
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _buildAnimation,
      animation: controller,
    );
  }
}