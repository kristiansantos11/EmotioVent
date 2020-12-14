import 'package:emotiovent/screens/EV_SignUp.dart';
import 'package:flutter/material.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

class EVSatisfactoryRate extends StatefulWidget {

  static const routeName = '/satisfactory';

  @override
  _EVSatisfactoryRateState createState() => _EVSatisfactoryRateState();
}

class _EVSatisfactoryRateState extends State<EVSatisfactoryRate> {

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
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "How satisfied are you with the activity?",
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
                      Navigator.pushNamed(context, EVSignUp.routeName);
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