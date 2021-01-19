import 'dart:async';
import 'dart:io';

import 'package:emotiovent/models/ScreenArguments.dart';
import 'package:emotiovent/services/BackgroundStagger.dart';
import 'package:emotiovent/services/EV_SizeGetter.dart';
import 'package:flutter/material.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:image_picker/image_picker.dart';

import '../EV_SatisfactoryRate.dart';

class CaptureSurroundingsPreview extends StatefulWidget {
  static const routeName = '/captureSurroundingsPreview';
  final String emotion;
  final String imgPath;
  final List<ImageLabel> labels;

  const CaptureSurroundingsPreview({Key key, this.emotion, this.imgPath, this.labels}) : super(key: key);

  @override
  _CaptureSurroundingsPreviewState createState() => _CaptureSurroundingsPreviewState(
                                                      emotion: emotion,
                                                      imgPath: imgPath,
                                                      labels: labels
                                                    );
}

class _CaptureSurroundingsPreviewState extends State<CaptureSurroundingsPreview> with TickerProviderStateMixin{
  final String emotion;
  final String imgPath;
  final List<ImageLabel> labels;

  _CaptureSurroundingsPreviewState({this.labels, this.emotion, this.imgPath});

  AnimationController backgroundController;
  bool _showFAB = false;
  String whatDoISee = "";

  @override
  void initState(){
    super.initState();
    backgroundController = AnimationController(vsync: this, duration: Duration(milliseconds: 1000));
    Timer(
      Duration(milliseconds: 1000),
      (){
        setState(() {
          _showFAB = true;
        });
      }
    );
    if(labels == null){
      whatDoISee = "nothing...";
    } else {
      for(ImageLabel label in labels){
        whatDoISee = whatDoISee + label.text + ", ";
      }
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[

          BackgroundStagger(
            controller: backgroundController.view,
            begin: Colors.orange,
            end: Colors.yellow,
          ),

          SafeArea(
            child: Column(
              children: <Widget>[

                Flexible(
                  flex: 2,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Looks good!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        height: 0.9,
                        color: Colors.white,
                        fontFamily: "SegoeUIBlack",
                        fontSize: getWidth(context) / 8,
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
                  flex: 2,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "I can see:\n " + whatDoISee,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Aileron",
                        fontSize: getWidth(context) / 20
                      ),
                    ),
                  ),
                ),

                Flexible(
                  flex: 1,
                  child: SizedBox(
                  ),
                )

              ],
            ),
          ),
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