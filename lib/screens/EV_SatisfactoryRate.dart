import 'dart:async';

import 'package:emotiovent/models/ScreenArguments.dart';
import 'package:emotiovent/screens/EV_SignUp.dart';
import 'package:emotiovent/services/EV_SizeGetter.dart';
import 'package:flutter/material.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:emotiovent/services/EV_ActivityRandomizer.dart';

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
    return Scaffold(
      body: Stack(
        children: <Widget>[

          AnimatedOpacity(
            opacity: _showContent ? 1.0 : 0.0,
            duration: Duration(seconds: 1),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "How satisfied are you with the activity? $emotion",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.green[600],
                      fontFamily: 'Aileron',
                      fontStyle: FontStyle.normal,
                      fontSize: getWidth(context) / 15,
                    ),
                  ),

                  SizedBox(
                    height: getHeight(context) / 12,
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

                  ButtonTheme(
                    buttonColor: Colors.green[500],
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0)
                          )
                        ),
                      ),
                      child: Text(
                        "NEXT",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Roboto',
                          fontStyle: FontStyle.normal,
                          fontSize: getWidth(context) / 27,
                        ),
                      ),
                      onPressed: () {
                        if(_currentSliderValue.round() < 50){
                          Navigator.of(context).popAndPushNamed(ActivityRandomizer.routeName, arguments: ScreenArguments(emotion: emotion));
                        } else {
                          Navigator.of(context).pushNamed(EVSignUp.routeName, arguments: ScreenArguments(emotion: emotion));
                        }
                      }
                    ),
                  )
                ]
              ),
            ),
          ),
        ]
      ),
    );
  }
}