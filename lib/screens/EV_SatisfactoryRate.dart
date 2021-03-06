import 'dart:async';

import 'package:emotiovent/models/EmotionRecord.dart';
import 'package:emotiovent/models/ScreenArguments.dart';
import 'package:emotiovent/screens/EV_InitialScreen.dart';
import 'package:emotiovent/screens/EV_SignUp.dart';
import 'package:emotiovent/services/EV_SizeGetter.dart';
import 'package:emotiovent/services/database/SubmitActivityResult.dart';
import 'package:flutter/material.dart';
import 'package:emotiovent/services/EV_ActivityRandomizer.dart';

import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

class EVSatisfactoryRate extends StatefulWidget {

  static const routeName = '/satisfactory';
  final String emotion;
  final String activity;

  const EVSatisfactoryRate({Key key, @required this.emotion, @required this.activity}) : super(key: key);

  @override
  _EVSatisfactoryRateState createState() => _EVSatisfactoryRateState(emotion: emotion, activity: activity);
}

class _EVSatisfactoryRateState extends State<EVSatisfactoryRate> {

  final String emotion;
  final String activity;

  _EVSatisfactoryRateState({@required this.emotion, @required this.activity});

  final double _minSliderValue = 0;
  final double _maxSliderValue = 100;
  double _currentSliderValue;

  bool _showContent = false;

  @override
  void initState(){
    super.initState();

    Timer(
      Duration(seconds: 1),
      (){
        setState((){
          _showContent = true;
        });
      }
    );

    _currentSliderValue = _maxSliderValue / 2;
  }


  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    return Scaffold(
      body: Stack(
        children: <Widget>[

          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/img/StartScreenBG.png'),
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: AnimatedOpacity(
                opacity: _showContent ? 1.0 : 0.0,
                duration: Duration(seconds: 1),
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(getWidth(context) / 10,0,getWidth(context) / 10,0),
                        child: Text(
                          "How satisfied are you with the activity?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xffff8383),
                            fontFamily: 'Proxima Nova',
                            fontWeight: FontWeight.w700,
                            height: 1,
                            fontSize: getWidth(context) / 15,
                          ),
                        ),
                      ),

                      SizedBox(
                        height: getHeight(context) / 25,
                      ),

                       Slider(
                        inactiveColor: Color(0xffffc2c2),
                        activeColor: Color(0xffff8383),
                        value: _currentSliderValue,
                        min: _minSliderValue,
                        max: _maxSliderValue,
                        divisions: 10,
                        label: _currentSliderValue.round().toString(),
                        onChanged: (double value) {
                          setState(() {
                            _currentSliderValue = value;
                          });
                        },
                      ),

                      Text(
                        "Drag the slider from left (0) to right (100)",
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontFamily: 'Proxima Nova',
                          fontStyle: FontStyle.normal,
                          fontSize: ResponsiveFlutter.of(context).scale(12.0)
                        ),
                      ),

                      SizedBox(
                        height: getHeight(context) / 12,
                      ),

                      ElevatedButton(
                        child: Icon(Icons.navigate_next),
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(Size(45, 45)),
                          backgroundColor: MaterialStateProperty.all(Color(0xffff8383)),
                          shape: MaterialStateProperty.all(CircleBorder())
                        ),
                        onPressed: () async {
                          if(_currentSliderValue.round() < 50){
                            Navigator.of(context).pushReplacementNamed(ActivityRandomizer.routeName, arguments: ScreenArguments(emotion: emotion));
                          } else {
                            if(firebaseUser == null){
                              Navigator.of(context).pushNamed(
                                EVSignUp.routeName,
                                arguments: ScreenArguments(
                                  emotion: emotion,
                                  emotionRecord: EmotionRecord(
                                    emotion: emotion,
                                    activity: activity,
                                    activityRate: _currentSliderValue.toInt(),
                                    timestamp: DateTime.now()
                                  ),
                                )
                              );
                            } else {
                              // TODO: Add code here to upload the record
                              await SubmitActivityResult()
                                .submit(
                                  user: firebaseUser,
                                  record: EmotionRecord(
                                    emotion: emotion,
                                    activity: activity,
                                    activityRate: _currentSliderValue.toInt(),
                                    timestamp: DateTime.now()
                                  ),
                                ).then((_){
                                  Navigator.of(context).popUntil(ModalRoute.withName(EVInitialScreen.routeName));
                                });
                            }
                          }
                        }
                      ),
                    ]
                  ),
                ),
              ),
            ),
          ),
        ]
      ),
    );
  }
}