import 'package:emotiovent/screens/EV_SatisfactoryRate.dart';
import 'package:emotiovent/services/EV_SizeGetter.dart';
import 'package:flutter/material.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:shake/shake.dart';
import 'dart:async';

class ShakePhoneActivity extends StatefulWidget {

  static const routeName = "/shake";

  final String emotion;

  const ShakePhoneActivity({Key key, this.emotion}) : super(key: key);

  @override
  _ShakePhoneActivityState createState() => _ShakePhoneActivityState(emotion);
}

class _ShakePhoneActivityState extends State<ShakePhoneActivity> {

  final String emotion;

  _ShakePhoneActivityState(this.emotion);

  ShakeDetector detector;
  bool _showContent = false;

  int _shakeCounter = 30;

  

  @override
  void initState(){
    super.initState();

    Timer(
      Duration(seconds: 1),
      () {
        setState((){
          _showContent = true;
        });
      }
    );

    detector = ShakeDetector.autoStart(
      onPhoneShake: () {
        setState(() {
          if(_shakeCounter > 0){
            _shakeCounter--;
          }
        });
        // Do stuff on phone shake
        if (_shakeCounter == 0){
          Navigator.of(context).popAndPushNamed(EVSatisfactoryRate.routeName, arguments: emotion);
        }
      }
    );
  }

  @override
  void dispose(){
    detector.stopListening();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Stack(
        children: <Widget>[

          Hero(
            tag: emotion,
            child: Container(
              height: getHeight(context),
              width: getWidth(context),
              color: Colors.white,
            ),
          ),

          AnimatedOpacity(
            opacity: _showContent ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 500),
            child: SafeArea(
              child: Container(
              alignment: Alignment.center,
                child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      flex: 3,
                      child: Container(
                        alignment: Alignment.topCenter,
                        child: Text(
                          "You need to shake this phone:",
                          style: TextStyle(
                            fontFamily: 'Aileron'
                          ),
                        ),
                      )
                    ),

                    Flexible(
                      flex: 6,
                      child: Container(
                        alignment: Alignment.topCenter,
                        child: 
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: "$_shakeCounter\n",
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w900, 
                                fontSize: ResponsiveFlutter.of(context).scale(75)
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: "times",
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: ResponsiveFlutter.of(context).scale(24),
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ]
                            ),
                          )
                      )
                    ),

                    Flexible(
                      flex: 7,
                      child: RaisedButton(
                        color: Colors.red[300],
                        child: Text("Back", style: TextStyle(color: Colors.white)),
                        onPressed: (){
                          Navigator.pop(context);
                        },
                      ),
                    )
                  ],
                )
              ),
            ),
          )
        ]

      ),
      
    );
  }
}