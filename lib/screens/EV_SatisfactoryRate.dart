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

  @override
  void initState(){
    super.initState();

    _currentSliderValue = _maxSliderValue / 2;
  }


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
              color: Colors.grey[100],
            )
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "How satisfied are you with the activity? ${emotion}",
                  style: TextStyle(
                    fontFamily: 'Aileron',
                    fontSize: ResponsiveFlutter.of(context).scale(14.0),
                  ),
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

                ButtonTheme(
                  buttonColor: Colors.green[500],
                  child: RaisedButton(
                    child: Text(
                      "NEXT",
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ),
                    onPressed: () {
                      if(_currentSliderValue.round() < 50){
                        Navigator.of(context).popAndPushNamed(ActivityRandomizer.routeName, arguments: emotion);
                      } else {
                        Navigator.pushNamed(context, EVSignUp.routeName);
                      }
                    }
                  ),
                )
              ]
            ),
          ),
        ]
      ),
    );
  }
}