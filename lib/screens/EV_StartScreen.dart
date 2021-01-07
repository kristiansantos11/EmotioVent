import 'dart:async';

import 'package:flutter/material.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

class EVStartScreen extends StatefulWidget {

  @override
  _EVStartScreenState createState() => _EVStartScreenState();
}

class _EVStartScreenState extends State<EVStartScreen> {
  bool showContent = false;

  @override
  void initState(){
    super.initState();

    Timer(
      Duration(seconds: 2), 
      () => {
        setState((){
          showContent = true;
        })
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          children: <Widget>[

            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/img/StartScreenBG.jpg"), fit: BoxFit.cover
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
                    Colors.grey.withAlpha(25),
                    Colors.black87,
                  ]
                )
              ),
            ),

            AnimatedOpacity(
              opacity: showContent ? 1.0 : 0.0,
              duration: const Duration(seconds: 1),
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(25, ResponsiveFlutter.of(context).verticalScale(30) ,25,12),
                  child: Column(
                    children: <Widget>[
                      
                      Flexible(
                        flex: 2,
                        child:
                          Container(
                            alignment: Alignment.bottomCenter,
                            padding: EdgeInsets.fromLTRB(
                              ResponsiveFlutter.of(context).wp(5),
                              ResponsiveFlutter.of(context).wp(1),
                              ResponsiveFlutter.of(context).wp(5),
                              ResponsiveFlutter.of(context).wp(1),
                            ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[


                                  Text(
                                    "emotiovent",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'Nexa',
                                      color: Colors.white,
                                      fontSize: ResponsiveFlutter.of(context).scale(45),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),


                                  Text(
                                    "How are you feeling today?",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: ResponsiveFlutter.of(context).scale(12),
                                      height: 1,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white
                                    )
                                  ),

                                ],
                              ),
                          )
                      ),
                      
                      
                      

                      Flexible(
                        flex: 5,
                        child:
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              
                
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[
                        
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, ResponsiveFlutter.of(context).moderateScale(40), 0, 0),
                                    child:
                                    
                                    Hero(
                                      tag: 'register',
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(18.0),
                                        ),
                                        child:
                                        FlatButton(
                                          minWidth: ResponsiveFlutter.of(context).scale(225),
                                          height: ResponsiveFlutter.of(context).scale(50),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(ResponsiveFlutter.of(context).scale(25.0)),
                                          ),
                                          color: Color(0xff53B6AF),
                                          onPressed: () {Navigator.pushNamed(context, '/signup');},
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                                            child:
                                              Text(
                                              "REGISTER",
                                              style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontStyle: FontStyle.normal,
                                                fontSize: ResponsiveFlutter.of(context).scale(14),
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 1.5,
                                                )
                                              )
                                          )
                                        )
                                      ),
                                    )
                                  ),
                                  

                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, ResponsiveFlutter.of(context).hp(2), 0, ResponsiveFlutter.of(context).verticalScale(10)),
                                    child: Hero(
                                      tag: 'login',
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(18.0),
                                        ),
                                        child:
                                        FlatButton(
                                          minWidth: ResponsiveFlutter.of(context).scale(225),
                                          height: ResponsiveFlutter.of(context).scale(50),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(ResponsiveFlutter.of(context).scale(25.0)),
                                            side: BorderSide(
                                              color: Colors.white,
                                              width: 3,
                                            )
                                          ),
                                          onPressed: () {Navigator.pushNamed(context, '/login');},
                                          child: 
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
                                              child:
                                                Text(
                                                  "LOGIN",
                                                  style: TextStyle(
                                                    fontFamily: 'Roboto',
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: ResponsiveFlutter.of(context).scale(14),
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    letterSpacing: 1.5,
                                                    )
                                                )
                                            )
                                        ),
                                      ),
                                    )
                                  ),
                                  
                                ]
                              ),
                            ],
                          )
                      ),

                    ],
                  )
                ),
              ),
            )

            

          ]

        )
    );  
  }
}