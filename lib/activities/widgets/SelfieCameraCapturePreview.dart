import 'dart:io';
import 'dart:async';

import 'package:emotiovent/models/ScreenArguments.dart';
import 'package:emotiovent/screens/EV_SatisfactoryRate.dart';
import 'package:emotiovent/services/EV_SizeGetter.dart';
import 'package:emotiovent/services/BackgroundStagger.dart';
import 'package:flutter/material.dart';

class SelfieCameraCapturePreview extends StatefulWidget {
  static const routeName = '/selfieCameraPreview';
  final String emotion;
  final String imgPath;

  const SelfieCameraCapturePreview({Key key, this.emotion, this.imgPath}) : super(key: key);
  
  @override
  _SelfieCameraCapturePreviewState createState() => _SelfieCameraCapturePreviewState(emotion, imgPath);
}

class _SelfieCameraCapturePreviewState extends State<SelfieCameraCapturePreview> with TickerProviderStateMixin{
  final String emotion;
  final String imgPath;

  _SelfieCameraCapturePreviewState(this.emotion, this.imgPath);

  AnimationController backgroundController;
  Animation<Color> backgroundAnimation;

  bool _showFAB = false;

  @override
  void initState(){
    super.initState();
    backgroundController = AnimationController(vsync: this, duration: Duration(seconds: 1))..repeat(reverse: true);

    Timer(
      Duration(seconds: 1),
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
            controller: backgroundController.view,
            begin: Colors.pink,
            end: Colors.purple,
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