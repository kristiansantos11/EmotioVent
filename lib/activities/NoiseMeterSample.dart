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
                Navigator.of(ctx).popAndPushNamed(EVSatisfactoryRate.routeName, arguments: emotion);
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
              child: AnimatedOpacity(
                opacity: this._isRecording ? 1.0 : 0.0,
                duration: Duration(milliseconds: 300),
                child: AnimatedContainer(
                  curve: Curves.easeOutQuad,
                  duration: Duration(milliseconds: 300),
                  width: ((db-30)/100) * MediaQuery.of(context).size.width,
                  height: ((db-30)/100) * MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.blue[300],
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
                            child: Text(_isRecording ? "Mic: ON" : "Mic: OFF",
                                style: TextStyle(fontSize: 25, color: Colors.blue)),
                            margin: EdgeInsets.only(top: 20),
                          )
                        ]
                      )
                    ),

                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width,
                    ),

                    Container(
                      child: Text(
                        "${counter} seconds left."
                      )
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