import 'dart:async';

import 'package:emotiovent/models/ScreenArguments.dart';
import 'package:emotiovent/services/EV_SizeGetter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:responsive_flutter/responsive_flutter.dart';

import 'package:emotiovent/services/EV_ActivityRandomizer.dart';

class EVChooseEmotionScreen extends StatefulWidget {
  
  static const routeName = '/chooseemotion';

  @override
  _EVChooseEmotionScreenState createState() => _EVChooseEmotionScreenState();
}

class _EVChooseEmotionScreenState extends State<EVChooseEmotionScreen> with TickerProviderStateMixin{
  bool showContent = false;

  AnimationController controller;
  AnimationController transitionController;

  Duration animationDuration = const Duration(milliseconds: 1200);
  Duration animatedOpacityDuration = const Duration(milliseconds: 500);

  Animation<Color> colorTween;

  void backToStartScreen(ctx){
    setState(() {showContent = false;});
    controller.reverse().whenComplete(() {
      Navigator.pop(ctx);
    });
  }

  void requestPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.storage,
      Permission.notification,
      Permission.microphone,
      Permission.photos,
      Permission.mediaLibrary
    ].request();
  }

  @override
  void initState(){
    super.initState();
    requestPermission();

    transitionController = AnimationController(
      vsync: this,
      duration: animationDuration,
    );

    colorTween = ColorTween(begin: Color(0xffff8383), end: Colors.white).animate(transitionController);

    controller = AnimationController(
      vsync: this,
      duration: animationDuration,
    );

    Timer(
      Duration(seconds: 1),
      () {
        setState((){
          showContent = true;
        });
        controller.forward();
      }
    );

    Timer(
      Duration(milliseconds: 500),
      (){setState(() {
        transitionController.forward();
      });}
    );
  }

  @override
  void dispose(){
    transitionController.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[

        Hero(
          tag: 'register',
          child: AnimatedBuilder(
            animation: colorTween,
            builder: (context, child) => Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: colorTween.value,
            ),
          ), 
        ),

        AnimatedOpacity(
          opacity: showContent ? 1.0 : 0.0,
          duration: animatedOpacityDuration,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/img/startup-bg.png"), fit: BoxFit.cover
              )
            ),
          ),
        ),

        AnimatedOpacity(
          opacity: showContent ? 1.0 : 0.0,
          duration: animatedOpacityDuration,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                tileMode: TileMode.repeated,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Colors.white.withAlpha(50),
                  Colors.white.withAlpha(150),
                ]
              )
            ),
          ),
        ),

        SafeArea(
          child: Container(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                ResponsiveFlutter.of(context).scale(15), 
                ResponsiveFlutter.of(context).hp(3), 
                ResponsiveFlutter.of(context).scale(15), 
                ResponsiveFlutter.of(context).hp(5)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[

                  AnimatedOpacity(
                    opacity: showContent ? 1.0 : 0.0,
                    duration: animatedOpacityDuration,
                    child: Align(
                      alignment: Alignment.center,
                      child: TextButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Color(0xffc1c1c1)),
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                              ),
                            ),
                            //height: ResponsiveFlutter.of(context).scale(35.0),

                            onPressed: () {backToStartScreen(context);},

                            child:
                              Text(
                              "Back",
                              style: TextStyle(
                                fontSize: ResponsiveFlutter.of(context).scale(14),
                                color: Colors.black,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 0,
                                )
                              )

                          )
                    ),
                  ),


                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, getHeight(context) / 90),
                        child: AnimatedOpacity(
                          opacity: showContent ? 1.0 : 0.0,
                          duration: animatedOpacityDuration,
                          child: Column(
                            children: <Widget>[
                              
                              Align(
                                alignment: Alignment.centerLeft,
                                  child: Text(
                                    "What do you feel?",
                                    style: TextStyle(
                                      fontFamily: 'Proxima Nova',
                                      color: Color(0xff38467f),
                                      fontStyle: FontStyle.normal,
                                      letterSpacing: -0.5,
                                      fontSize: ResponsiveFlutter.of(context).scale(35.0),
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                              ),
                              
                              Align(
                                alignment: Alignment.centerLeft,
                                child:
                                Text(
                                  "Choose an emotion box...",
                                  style: TextStyle(
                                    fontFamily: 'Proxima Nova',
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal,
                                    color: Color(0xff666666),
                                    letterSpacing: 1,
                                    fontSize: ResponsiveFlutter.of(context).scale(15.0),
                                  ),
                                )
                              )
                            ],
                          ),
                        ),
                      ),

                      SizedBox(
                        height: ResponsiveFlutter.of(context).hp(1),
                      ),

                      Container(
                        child:
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  
                                  EmotionButton(
                                    ctx: context, 
                                    intervalStart: 0.4,
                                    intervalEnd: 0.6,
                                    color: Color(0xffff9aa2), 
                                    emotion: "Happy",
                                    controller: controller,
                                  ),

                                  EmotionButton(
                                    ctx: context, 
                                    intervalStart: 0.4,
                                    intervalEnd: 0.6,
                                    color: Color(0xffffb7b2), 
                                    emotion: "Anger",
                                    controller: controller,
                                  ),

                                ],
                              ),

                          ]
                        ),
                      ),

                      Container(
                      child:
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[

                                  EmotionButton(
                                    ctx: context, 
                                    intervalStart: 0.6,
                                    intervalEnd: 0.8,
                                    color: Color(0xfff7c8a8), 
                                    emotion: "Fear",
                                    controller: controller,
                                  ),

                                  EmotionButton(
                                    ctx: context, 
                                    intervalStart: 0.6,
                                    intervalEnd: 0.8,
                                    color: Color(0xffd0e3b1), 
                                    emotion: "Sad",
                                    controller: controller,
                                  ),

                                ],
                              ),

                          ]
                        ),
                      ),

                      Container(
                      child:
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[

                                  EmotionButton(
                                    ctx: context,
                                    intervalStart: 0.8,
                                    intervalEnd: 1.0,
                                    color: Color(0xffb5ead7), 
                                    emotion: "Disgust",
                                    controller: controller
                                  ),

                                  EmotionButton(
                                    ctx: context,
                                    intervalStart: 0.8,
                                    intervalEnd: 1.0,
                                    color: Color(0xffc7ceea),
                                    emotion: "Alone",
                                    controller: controller,
                                  ),

                                ],
                              ),

                          ]
                        ),
                      ),
                    ]
                  ),

                ]
              ),
            ),
          )
        )
      ],
      )
    );
  }
}

class EmotionButton extends StatelessWidget{
  final double intervalStart;
  final double intervalEnd;
  final Color color;
  final String emotion;
  final BuildContext ctx;
  final AnimationController controller;

  const EmotionButton({
    Key key,
    this.ctx,
    this.intervalStart,
    this.intervalEnd,
    this.color,
    this.emotion,
    this.controller,
  }) : super(key : key);


  @override
  Widget build(BuildContext context) {
        return ScaleTransition(
          scale: Tween<double>(
            begin: 0.0,
            end: 1.0,
          ).animate(
            CurvedAnimation(
              curve: Interval(
                intervalStart, intervalEnd,
                curve: Curves.easeInOut
              ),
              parent: controller,
            ),
          ),

          child: Hero(
            tag: emotion,
            child: Padding(
              padding: EdgeInsets.all(ResponsiveFlutter.of(context).scale(8)),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: TextButton(
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all<Size>(
                      Size(getWidth(context) / 2.5, getHeight(context) / 5),
                    ),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(color),
                  ),
                  //minWidth: MediaQuery.of(context).size.width / 2.5,
                  //height: ResponsiveFlutter.of(context).hp(20),
                  onPressed: () {Navigator.of(ctx).pushNamed(ActivityRandomizer.routeName, arguments: ScreenArguments(emotion: emotion));},
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                    child: Text(
                      emotion,
                      style: TextStyle(
                        fontSize: ResponsiveFlutter.of(context).scale(20.0),
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0,
                      )
                    )
                  )
                )
              )
            ),
          ),

        );

  }
  
}