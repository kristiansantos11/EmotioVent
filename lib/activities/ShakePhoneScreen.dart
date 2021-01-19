import 'package:emotiovent/models/ScreenArguments.dart';
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
      shakeCountResetTime: 500,
      onPhoneShake: () {
        setState(() {
          if(_shakeCounter > 0){
            _shakeCounter--;
          }
        });
        // Do stuff on phone shake
        if (_shakeCounter == 0){
          detector.stopListening();
          Navigator.of(context).pushReplacementNamed(EVSatisfactoryRate.routeName, arguments: ScreenArguments(emotion: emotion));
        }
      }
    );
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
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  alignment: Alignment(-0.4, 1),
                  image: AssetImage('assets/img/shake-phone-bg.jpg')
                ),
              ),
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

                      Container(
                        width: getWidth(context) / 6,
                        height: getWidth(context) / 6,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage('assets/img/shake-phone.png'),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: getWidth(context) / 15,
                      ),

                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          "You need to shake\nthis phone:",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Aileron',
                            fontSize: getWidth(context) / 20,
                          ),
                        ),
                      ),

                      SizedBox(
                        height: getWidth(context) / 15,
                      ),

                      Stack(
                        children: <Widget>[

                          Container(
                            alignment: Alignment.center,
                            child: 
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  text: "$_shakeCounter\n",
                                  style: TextStyle(
                                    color: Colors.grey[700],
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w900, 
                                    fontSize: ResponsiveFlutter.of(context).scale(125),
                                    height: 1,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: "times",
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: ResponsiveFlutter.of(context).scale(24),
                                        fontWeight: FontWeight.normal,
                                        height: 0.5,
                                      ),
                                    ),
                                  ]
                                ),
                              )
                          ),
                        ],
                      ),

                      SizedBox(
                        height: getHeight(context) / 5,
                      ),

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