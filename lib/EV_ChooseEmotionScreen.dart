import 'package:flutter/material.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

import 'EV_SignUp.dart';

class EVChooseEmotionScreen extends StatefulWidget {
  @override
  _EVChooseEmotionScreenState createState() => _EVChooseEmotionScreenState();
}

class _EVChooseEmotionScreenState extends State<EVChooseEmotionScreen> {

  Widget emotionButton(BuildContext ctx, int color, String text){
    return Expanded(
            child:
            Padding(
              padding: EdgeInsets.all(ResponsiveFlutter.of(ctx).scale(8)),
              child:
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child:
                FlatButton(
                  minWidth: ResponsiveFlutter.of(ctx).wp(1),
                  height: ResponsiveFlutter.of(ctx).hp(20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  color: Color(color),
                  onPressed: () {moveToRegister(ctx);},
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                    child:
                      Text(
                      text,
                      style: TextStyle(
                        fontSize: ResponsiveFlutter.of(ctx).scale(20.0),
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0,
                        )
                      )
                  )
                )
              )
            ),
          );
  }

  void backToStartScreen(ctx){
    Navigator.pop(ctx);
  }

  void moveToRegister(ctx){
    Navigator.push(ctx,
      MaterialPageRoute(builder: (ctx) => EVSignUp())
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[

        Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/img/ChooseLoginSignupBG.jpg"), fit: BoxFit.cover
                )
              ),
            ),

        Container(
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

        SafeArea(
          child: Container(
            decoration: BoxDecoration(
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                ResponsiveFlutter.of(context).scale(15), 
                ResponsiveFlutter.of(context).hp(3), 
                ResponsiveFlutter.of(context).scale(15), 
                ResponsiveFlutter.of(context).hp(5)),
              child: Column(
                children: <Widget>[
                            Align(
                              alignment: Alignment.topLeft,
                              child:
                              Container(
                                height: ResponsiveFlutter.of(context).scale(35),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18.0),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: -5,
                                      blurRadius: 7,
                                      offset: Offset(0, 0), // change shadow position
                                    )
                                  ]
                                ),
                                child:
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, ResponsiveFlutter.of(context).hp(1)),
                                  child:
                                  FlatButton(
                                    height: ResponsiveFlutter.of(context).scale(35.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                    ),
                                    color: Color(0xff53B6AF),
                                    onPressed: () {backToStartScreen(context);},
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(0,0,0,0),
                                      child:
                                        Text(
                                        "Back",
                                        style: TextStyle(
                                          fontSize: ResponsiveFlutter.of(context).scale(14),
                                          color: Colors.white,
                                          fontWeight: FontWeight.w900,
                                          letterSpacing: 0,
                                          )
                                        )
                                    )
                                  )
                                )
                              )
                            ),
                  Expanded(
                    child: 
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Column(
                            children: <Widget>[
                              
                              Align(
                                alignment: Alignment.centerLeft,
                                  child: Text(
                                    "What do you feel?",
                                    style: TextStyle(
                                      fontFamily: 'Aileron',
                                      color: Color(0xff53B6AF),
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
                                    fontFamily: 'Segoe UI',
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal,
                                    color: Color(0xff53B6AF),
                                    letterSpacing: 1,
                                    fontSize: ResponsiveFlutter.of(context).scale(15.0),
                                  ),
                                )
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: ResponsiveFlutter.of(context).hp(1),
                        ),
                        Expanded(
                        child:
                        Column(
                          children: <Widget>[

                              Row(
                                children: <Widget>[
                                  
                                  emotionButton(context, 0xc5D9D900, "Happy"),
                                  emotionButton(context, 0xc5FF8B8B, "Anger"),

                                ],
                              ),

                          ]
                        ),
                        ),

                        Expanded(
                        child:
                        Column(
                          children: <Widget>[

                              Row(
                                children: <Widget>[

                                  emotionButton(context, 0xc5E593FB, "Fear"),
                                  emotionButton(context, 0xc587A7FF, "Sad"),

                                ],
                              ),

                          ]
                        ),
                        ),

                        Expanded(
                        child:
                        Column(
                          children: <Widget>[

                              Row(
                                children: <Widget>[

                                  emotionButton(context, 0xc570DB77, "Disgust"),
                                  emotionButton(context, 0xc5EFA254, "Alone"),
                                  
                                ],
                              ),

                          ]
                        ),
                        ),
                      ]
                    ),
                  ),

                ]
              ),
            ),
          )
        )

      ],)
    );
  }
}