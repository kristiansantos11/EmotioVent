import 'dart:async';

import 'package:emotiovent/models/ScreenArguments.dart';
import 'package:emotiovent/screens/EV_InitialScreen.dart';
// import 'package:emotiovent/screens/EV_SignUp.dart';
import 'package:emotiovent/services/EV_SizeGetter.dart';
import 'package:flutter/material.dart';
import 'package:emotiovent/services/EV_ActivityRandomizer.dart';

import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EVSatisfactoryRate extends StatefulWidget {

  static const routeName = '/satisfactory';
  final String emotion;

  const EVSatisfactoryRate({Key key, this.emotion}) : super(key: key);

  @override
  _EVSatisfactoryRateState createState() => _EVSatisfactoryRateState(emotion);
}

class _EVSatisfactoryRateState extends State<EVSatisfactoryRate> {

  final String emotion;

  _EVSatisfactoryRateState(this.emotion);

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
                fit: BoxFit.fill,
                image: AssetImage('assets/img/satisfaction-rate-bg.jpg'),
              ),
            ),
          ),

          SafeArea(
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
                          color: Colors.green[600],
                          fontFamily: 'Aileron',
                          fontStyle: FontStyle.normal,
                          fontSize: getWidth(context) / 15,
                        ),
                      ),
                    ),

                    SizedBox(
                      height: getHeight(context) / 25,
                    ),

                     Slider(
                      inactiveColor: Colors.green[100],
                      activeColor: Colors.green[400],
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
                        fontFamily: 'Roboto',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w100,
                        fontSize: 12,
                      ),
                    ),

                    SizedBox(
                      height: getHeight(context) / 12,
                    ),

                    ElevatedButton(
                      child: Icon(Icons.navigate_next),
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(Size(45, 45)),
                        backgroundColor: MaterialStateProperty.all(Colors.green[500]),
                        shape: MaterialStateProperty.all(CircleBorder())
                      ),
                      onPressed: () {
                        if(_currentSliderValue.round() < 50){
                          Navigator.of(context).pushReplacementNamed(ActivityRandomizer.routeName, arguments: ScreenArguments(emotion: emotion));
                        } else {
                          if(firebaseUser == null){
                            //Navigator.of(context).pushNamed(EVSignUp.routeName, arguments: ScreenArguments(emotion: emotion));
                          } else {
                            Navigator.of(context).popUntil(ModalRoute.withName(EVInitialScreen.routeName));
                          }
                        }
                      }
                    ),
                  ]
                ),
              ),
            ),
          ),
        ]
      ),
    );
  }
}