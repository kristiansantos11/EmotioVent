import 'package:emotiovent/models/ScreenArguments.dart';
import 'package:flutter/services.dart';
import 'package:noise_meter/noise_meter.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:emotiovent/services/EV_SizeGetter.dart';

import 'package:emotiovent/screens/EV_SatisfactoryRate.dart';

class NoiseMeterSample extends StatefulWidget {
  static const routeName = "/noise_meter";

  final String emotion;

  const NoiseMeterSample({Key key, this.emotion}) : super(key: key);

  @override
  _NoiseMeterSampleState createState() => new _NoiseMeterSampleState(emotion);
}

class _NoiseMeterSampleState extends State<NoiseMeterSample> {
  final String emotion;
  _NoiseMeterSampleState(this.emotion);

  bool _showContent = false;
  bool _isRecording = false;
  StreamSubscription<NoiseReading> _noiseSubscription;
  NoiseMeter _noiseMeter;
  double db;
  int counter;
  Timer timer;

  BuildContext ctx;

  @override
  void initState() {
    super.initState();
    counter = 5;
    db = 40;
    _noiseMeter = new NoiseMeter(onError);
    Timer(
      const Duration(seconds: 1),
      () {
        setState((){
          _showContent = true;
        });
      }
    );
  }

  @override
  void dispose(){
    stop();
    super.dispose();
  }

  void onData(NoiseReading noiseReading) {
    this.setState(() {
      if (!this._isRecording) {
        this._isRecording = true;
      }
    });
    print(noiseReading.toString());
    db = noiseReading.meanDecibel;
  }

  void onError(PlatformException e) {
    print(e.toString());
    _isRecording = false;
  }

  void start() async {
    try {
      _noiseSubscription = _noiseMeter.noiseStream.listen(onData);
      counter = 5;
      Timer.periodic(
        Duration(seconds: 1),
        (Timer timer) {
          if(db >= 75){
            setState(()=>{counter--});
            if((counter == 0) && timer.isActive){
              setState((){
                timer.cancel();
                Navigator.of(ctx).pushNamed(EVSatisfactoryRate.routeName, arguments: ScreenArguments(emotion: emotion));
              });
            }
          }
        }
      );
    } catch (err) {
      print(err);
    }
  }

  void stop() async {
    try {
      if (_noiseSubscription != null) {
        _noiseSubscription.cancel();
        _noiseSubscription = null;
      }
      this.setState(() {
        this._isRecording = false;
      });
    } catch (err) {
      print('stopRecorder error: $err');
    }
  }

  @override
  Widget build(BuildContext context) {
    ctx = context;
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [

            Hero(
              tag: emotion,
              child: Container(
                width: getWidth(context),
                height: getHeight(context),
                color: Colors.white,
              ),
            ),

            Center(
              child: Container(
                width: ((75-30)/70) * getWidth(context),
                height: ((75-30)/70) * getWidth(context),
                decoration: BoxDecoration(
                  color: Colors.green[300].withAlpha(100),
                  shape: BoxShape.circle
                ),
              ),
            ),

            Center(
              child: AnimatedOpacity(
                opacity: this._isRecording ? 1.0 : 0.0,
                duration: Duration(milliseconds: 300),
                child: AnimatedContainer(
                  curve: Curves.easeOutQuad,
                  duration: Duration(milliseconds: 300),
                  width: ((db-30)/70) * getWidth(context),
                  height: ((db-30)/70) * getWidth(context),
                  decoration: BoxDecoration(
                    color: Colors.green[600],
                    shape: BoxShape.circle,
                  ),
                )
              ),
            ),

            AnimatedOpacity(
              opacity: _showContent ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 700),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    Container(
                      margin: EdgeInsets.all(25),
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Text(_isRecording ? "Scream at your microphone!" : "Press the microphone button!",
                              style: TextStyle(
                                fontSize: 25, 
                                color: Colors.green,
                                fontFamily: "Nexa",
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            margin: EdgeInsets.only(top: 20),
                          )
                        ]
                      )
                    ),

                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width / 1.2,
                    ),

                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[

                          Text(
                            counter.toString(),
                            style: TextStyle(
                              fontFamily: "SegoeUIBlack",
                              fontSize: getWidth(context) / 8,
                              color: Colors.grey[700],
                            ),
                          ),

                          Text(
                            "seconds left",
                            style: TextStyle(
                              fontFamily: "Aileron",
                              fontSize: getWidth(context) / 20,
                              color: Colors.grey[600],
                            ),
                          )

                        ],
                      ),
                    ),

                  ]
                )
              ),
            ),
          ]
        ),
        floatingActionButton: Center(
          child: FloatingActionButton(
                  backgroundColor: _isRecording ? Colors.red : Colors.green,
                  onPressed: _isRecording ? stop : start,
                  child: _isRecording ? Icon(Icons.stop) : Icon(Icons.mic)
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}