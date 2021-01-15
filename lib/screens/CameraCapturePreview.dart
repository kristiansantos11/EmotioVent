import 'dart:io';
import 'dart:async';

import 'package:emotiovent/models/ScreenArguments.dart';
import 'package:emotiovent/screens/EV_SatisfactoryRate.dart';
import 'package:emotiovent/services/EV_SizeGetter.dart';
import 'package:emotiovent/services/BackgroundStagger.dart';
import 'package:flutter/material.dart';

class CameraCapturePreview extends StatefulWidget {
  static const routeName = '/cameraPreview';
  final String emotion;
  final String imgPath;

  const CameraCapturePreview({Key key, this.emotion, this.imgPath}) : super(key: key);
  
  @override
  _CameraCapturePreviewState createState() => _CameraCapturePreviewState(emotion, imgPath);
}

class _CameraCapturePreviewState extends State<CameraCapturePreview> with TickerProviderStateMixin{
  final String emotion;
  final String imgPath;

  _CameraCapturePreviewState(this.emotion, this.imgPath);

  AnimationController backgroundController;
  Animation<Color> backgroundAnimation;

  bool _showFAB = false;

  @override
  void initState(){
    super.initState();
    backgroundController = AnimationController(vsync: this, duration: Duration(seconds: 1))..repeat(reverse: true);

    Timer(
      Duration(seconds: 2),
      (){
        setState(() {
        _showFAB = true;
        });
      }
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[

          BackgroundStagger(
            controller: backgroundController.view
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:<Widget>[

              Flexible(
                flex: 3,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        "OMG!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "SegoeUIBlack",
                          fontSize: getWidth(context) / 5
                        ),
                      ),
                    ),
              ),


              Flexible(
                flex: 7,
                child: Container(
                  alignment: Alignment.center,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(18.0),
                        child: Image.file(File(imgPath)),
                  )
                ),
              ),


              Flexible(
                flex: 3,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "You look good!",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Aileron",
                      fontSize: getWidth(context) / 15
                    ),
                  ),
                ),
              ),

              Flexible(
                flex: 3,
                child: SizedBox(
                ),
              )

            ]
          )
        ],
      ),
      floatingActionButton: AnimatedOpacity(
        duration: Duration(seconds: 1),
        opacity: _showFAB ? 1.0 : 0.0,
        child: FloatingActionButton.extended(
          label: Text("Continue", style: TextStyle(fontFamily: 'Nexa', fontWeight: FontWeight.w700)),
          icon: Icon(Icons.navigate_next),
          tooltip: "Continue",
          foregroundColor: Colors.green,
          backgroundColor: Colors.white,
          onPressed: () {Navigator.of(context).pushNamed(EVSatisfactoryRate.routeName, arguments: ScreenArguments(emotion: emotion));}
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}