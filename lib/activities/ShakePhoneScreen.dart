import 'package:emotiovent/screens/EV_SatisfactoryRate.dart';
import 'package:flutter/material.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:shake/shake.dart';

class ShakePhoneActivity extends StatefulWidget {

  static const routeName = "/shake";

  @override
  _ShakePhoneActivityState createState() => _ShakePhoneActivityState();
}

class _ShakePhoneActivityState extends State<ShakePhoneActivity> {

  ShakeDetector detector;

  int _shakeCounter = 30;

  @override
  void initState(){
    super.initState();

    detector = ShakeDetector.autoStart(
      onPhoneShake: () {
        setState(() {
          _shakeCounter--;
        });
        // Do stuff on phone shake
        if (_shakeCounter <= 0){
          Navigator.pushNamed(context, EVSatisfactoryRate.routeName);
        }
      }
    );
  }

  @override
  void deactivate(){
    super.deactivate();

    detector.stopListening();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Stack(
        children: <Widget>[
          SafeArea(
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
          )
        ]

      ),
      
    );
  }
}