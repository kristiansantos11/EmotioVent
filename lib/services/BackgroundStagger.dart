import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

class BackgroundStagger extends StatelessWidget {
  BackgroundStagger({Key key, this.controller, this.begin, this.end}) :

    darkColor = ColorTween(
      begin: begin[500], 
      end: end[500]
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
      begin: begin[400], 
      end: end[400]
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
      begin: begin[300], 
      end: end[300]
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
  final MaterialColor begin;
  final MaterialColor end;
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