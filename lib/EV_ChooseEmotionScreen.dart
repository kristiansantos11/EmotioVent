import 'package:flutter/material.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

class EVChooseEmotionScreen extends StatefulWidget {
  @override
  _EVChooseEmotionScreenState createState() => _EVChooseEmotionScreenState();
}

class _EVChooseEmotionScreenState extends State<EVChooseEmotionScreen> {

  void backToStartScreen(ctx){
    Navigator.pop(ctx);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
            color: Color(0xfff7f7f7)
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(10, ResponsiveFlutter.of(context).hp(3), 10, ResponsiveFlutter.of(context).hp(5)),
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
                                    color: Color(0xff6dd9eB),
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
                                      color: Color(0xff00b8d6),
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
                                    color: Color(0xff00b8d6),
                                    letterSpacing: 1,
                                    fontSize: ResponsiveFlutter.of(context).scale(15.0),
                                  ),
                                )
                              )
                            ],
                          ),
                        ),
                        Expanded(
                        child:
                        Column(
                          children: <Widget>[

                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child:
                                    Padding(
                                      padding: EdgeInsets.all(ResponsiveFlutter.of(context).scale(10)),
                                      child:
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(18.0),
                                          boxShadow: <BoxShadow>[
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.5),
                                              spreadRadius: 1,
                                              blurRadius: 7,
                                              offset: Offset(0, 3), // change shadow position
                                            )
                                          ]
                                        ),
                                        child:
                                        FlatButton(
                                          minWidth: ResponsiveFlutter.of(context).wp(1),
                                          height: ResponsiveFlutter.of(context).hp(20),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(18.0),
                                          ),
                                          color: Color(0xff70DB77),
                                          onPressed: () {},
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                                            child:
                                              Text(
                                              "Disgust",
                                              style: TextStyle(
                                                fontSize: ResponsiveFlutter.of(context).scale(20.0),
                                                fontFamily: 'Segoe UI',
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
                                  Expanded(
                                    child:
                                    Padding(
                                      padding: EdgeInsets.all(ResponsiveFlutter.of(context).scale(8)),
                                      child:
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(18.0),
                                          boxShadow: <BoxShadow>[
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.5),
                                              spreadRadius: 1,
                                              blurRadius: 7,
                                              offset: Offset(0, 3), // change shadow position
                                            )
                                          ]
                                        ),
                                        child:
                                        FlatButton(
                                          minWidth: ResponsiveFlutter.of(context).wp(1),
                                          height: ResponsiveFlutter.of(context).hp(20),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(18.0),
                                          ),
                                          color: Color(0xffFF8B8B),
                                          onPressed: () {},
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                                            child:
                                              Text(
                                              "Anger",
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
                                  Expanded(
                                    child:
                                    Padding(
                                      padding: EdgeInsets.all(ResponsiveFlutter.of(context).scale(10)),
                                      child:
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(18.0),
                                          boxShadow: <BoxShadow>[
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.5),
                                              spreadRadius: 1,
                                              blurRadius: 7,
                                              offset: Offset(0, 3), // change shadow position
                                            )
                                          ]
                                        ),
                                        child:
                                        FlatButton(
                                          minWidth: ResponsiveFlutter.of(context).wp(1),
                                          height: ResponsiveFlutter.of(context).hp(20),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(18.0),
                                          ),
                                          color: Color(0xffE593FB),
                                          onPressed: () {},
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                                            child:
                                              Text(
                                              "Fear",
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
                                  Expanded(
                                    child:
                                    Padding(
                                      padding: EdgeInsets.all(ResponsiveFlutter.of(context).scale(8)),
                                      child:
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(18.0),
                                          boxShadow: <BoxShadow>[
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.5),
                                              spreadRadius: 1,
                                              blurRadius: 7,
                                              offset: Offset(0, 3), // change shadow position
                                            )
                                          ]
                                        ),
                                        child:
                                        FlatButton(
                                          minWidth: ResponsiveFlutter.of(context).wp(1),
                                          height: ResponsiveFlutter.of(context).hp(20),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(18.0),
                                          ),
                                          color: Color(0xff87A7FF),
                                          onPressed: () {},
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                                            child:
                                              Text(
                                              "Sad",
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
                                  Expanded(
                                    child:
                                    Padding(
                                      padding: EdgeInsets.all(ResponsiveFlutter.of(context).scale(10)),
                                      child:
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(18.0),
                                          boxShadow: <BoxShadow>[
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.5),
                                              spreadRadius: 1,
                                              blurRadius: 7,
                                              offset: Offset(0, 3), // change shadow position
                                            )
                                          ]
                                        ),
                                        child:
                                        FlatButton(
                                          minWidth: ResponsiveFlutter.of(context).wp(1),
                                          height: ResponsiveFlutter.of(context).hp(20),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(18.0),
                                          ),
                                          color: Color(0xffD9D900),
                                          onPressed: () {},
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                                            child:
                                              Text(
                                              "Happy",
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
                                  Expanded(
                                    child:
                                    Padding(
                                      padding: EdgeInsets.all(ResponsiveFlutter.of(context).scale(8)),
                                      child:
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(18.0),
                                          boxShadow: <BoxShadow>[
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.5),
                                              spreadRadius: 1,
                                              blurRadius: 7,
                                              offset: Offset(0, 3), // change shadow position
                                            )
                                          ]
                                        ),
                                        child:
                                        FlatButton(
                                          minWidth: ResponsiveFlutter.of(context).wp(1),
                                          height: ResponsiveFlutter.of(context).hp(20),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(18.0),
                                          ),
                                          color: Color(0xffEFA254),
                                          onPressed: () {},
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                                            child:
                                              Text(
                                              "Alone",
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
      ),
    );
  }
}