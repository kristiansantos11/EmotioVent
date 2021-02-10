import 'dart:async';

import 'package:emotiovent/models/ScreenArguments.dart';
import 'package:emotiovent/services/EV_SizeGetter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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

  @override
  void initState(){
    super.initState();

    transitionController = AnimationController(
      vsync: this,
      duration: animationDuration,
    );

    colorTween = ColorTween(begin: Color(0xff53B6AF), end: Colors.white).animate(transitionController);

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
      body: SafeArea(
              child: Stack(children: <Widget>[

          Container(
                      decoration: BoxDecoration(
                      image: DecorationImage(
                      image: AssetImage("assets/img/ss-bg-redyellow.png"),
                      fit: BoxFit.cover
                      )
                      )
                      ),

                      Container(
                      decoration: BoxDecoration(
                      image: DecorationImage(
                      image: AssetImage("assets/img/ebr-bg-green.png"),
                      fit: BoxFit.cover
                      )
                      )
                      ),

                      Container(
                        decoration: BoxDecoration(
                        image: DecorationImage(
                        image: AssetImage("assets/img/ss-deco.png"),
                        ), 
                        )  
                        ),
                      
                      Opacity(
                        opacity: 0.5,
                                    child: Container(
                          decoration: BoxDecoration(
                          image: DecorationImage(
                          image: AssetImage("assets/img/ss-deco2.png"),
                          ), 
                          )  
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
                                        fontFamily: 'Aileron',
                                        color: Color.fromARGB(225,56,70,127),
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
                                    "Choose an emotion box",
                                    style: TextStyle(
                                      fontFamily: 'Segoe UI',
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FontStyle.normal,
                                      color: Colors.grey,
                                      letterSpacing: 1,
                                      fontSize: ResponsiveFlutter.of(context).scale(18.0),
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
                                      color: 0xc5D9D900, 
                                      emotion: "Happy",
                                      controller: controller,
                                    ),

                                    EmotionButton(
                                      ctx: context, 
                                      intervalStart: 0.4,
                                      intervalEnd: 0.6,
                                      color: 0xc5FF8B8B, 
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
                                      color: 0xc5E593FB, 
                                      emotion: "Fear",
                                      controller: controller,
                                    ),

                                    EmotionButton(
                                      ctx: context, 
                                      intervalStart: 0.6,
                                      intervalEnd: 0.8,
                                      color: 0xc587A7FF, 
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
                                      color: 0xc570DB77, 
                                      emotion: "Disgust",
                                      controller: controller
                                    ),
                                  ),
                                ),
                              ),
                              //height: ResponsiveFlutter.of(context).scale(35.0),

                                    intervalStart: 0.8,
                                    intervalEnd: 1.0,
                                    color: Color(0xc5EFA254),
                                    emotion: "Alone",
                                    controller: controller,
                                  ),

                              child:
                                "Back",
                                style: TextStyle(
                                  fontSize: ResponsiveFlutter.of(context).scale(14),
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 0,
                                  )
                                )

                            )
                      ),
                    ),
                  ]
                ),
              ),
            )
          )
        ],
        ),
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
            end: 1.0,
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