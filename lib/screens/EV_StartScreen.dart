import 'dart:async';

import 'package:emotiovent/models/ScreenArguments.dart';
import 'package:emotiovent/models/UserInfo.dart';
import 'package:emotiovent/screens/EV_ChooseEmotionScreen.dart';
import 'package:emotiovent/screens/EV_SignUp.dart';
import 'package:emotiovent/screens/ExplainBeforeRegister.dart';
import 'package:emotiovent/services/EV_SizeGetter.dart';
import 'package:flutter/material.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:provider/provider.dart';

class EVStartScreen extends StatefulWidget {
  @override
  _EVStartScreenState createState() => _EVStartScreenState();
}

class _EVStartScreenState extends State<EVStartScreen> {
  // This was supposed to be used along with animatedOpacity
  // However, the setState inside the initState method was being called miraculously
  // I had to scrape the animation.
  bool showContent = true;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Stack(children: <Widget>[
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/img/StartScreenBG.png"),
                    fit: BoxFit.cover)),
         
                 
          ),
          Stack(
          children: [
            AnimatedOpacity(
              opacity: showContent ? 1.0 : 0.0,
              duration: const Duration(seconds: 1),
              child: SafeArea(
 
                    child: Column(
                      children: <Widget>[
                       
                           Padding(
                             padding: EdgeInsets.fromLTRB(0,
                        ResponsiveFlutter.of(context).verticalScale(180), 50, 130),
                             child: Flexible(
                                flex: 2,
                        
                                child: Container(
                                  
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
                                        "Emotiovent",
                                        
                                        style: TextStyle(
                                          fontFamily: 'Proxima Nova',
                                          color: Colors.grey[600],
                                          fontSize:
                                              ResponsiveFlutter.of(context).scale(50),
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Text("How are you feeling today?",
                                          
                                          style: TextStyle(
                                              fontFamily: 'Proxima Nova',
                                              fontSize: ResponsiveFlutter.of(context)
                                                  .scale(17),
                                              height: 0.5,
                                              fontStyle: FontStyle.normal,
                                              fontWeight: FontWeight.w900,
                                              color: Colors.black87)),
                                    ],
                                  ),
                                )),
                             ),
                           
                           
                        Center(
                          child: Flexible(
                              flex: 5,
                              child:Padding(
                    padding: EdgeInsets.fromLTRB(25,
                        ResponsiveFlutter.of(context).verticalScale(0), 25, 100),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Hero(
                                          tag: 'register',
                                          child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(18.0),
                                              ),
                                              child: TextButton(
                                                  style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty.all<
                                                                Color>(
                                                            Color(0xff53B6AF)),
                                                    overlayColor:
                                                        MaterialStateProperty
                                                            .resolveWith<Color>(
                                                                (Set<MaterialState>
                                                                    states) {
                                                      if (states.contains(
                                                          MaterialState.hovered))
                                                        return Colors.green[500];
                                                      if (states.contains(
                                                          MaterialState.pressed))
                                                        return Colors.white;
                                                      return null; // Defer to the widget's default.
                                                    }),
                                                    shape:
                                                        MaterialStateProperty.all(
                                                            RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              ResponsiveFlutter.of(
                                                                      context)
                                                                  .scale(25.0)),
                                                    )),
                                                    minimumSize:
                                                        MaterialStateProperty.all(
                                                            Size(
                                                                ResponsiveFlutter
                                                                        .of(context)
                                                                    .scale(225),
                                                                ResponsiveFlutter
                                                                        .of(context)
                                                                    .scale(50))),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.of(context).pushNamed(
                                                        ExplainBeforeRegister
                                                            .routeName);
                                                  },
                                                  child: Padding(
                                                      padding: EdgeInsets.fromLTRB(
                                                          5, 10, 5, 10),
                                                      child: Text("REGISTER",
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Proxima Nova',
                                                            fontStyle:
                                                                FontStyle.normal,
                                                            fontSize:
                                                                ResponsiveFlutter
                                                                        .of(context)
                                                                    .scale(14),
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            letterSpacing: 1.5,
                                                          ))))),
                                        ),
                                        SizedBox(
                                          height: getHeight(context) / 900,
                                        ),
                                        Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0,
                                                ResponsiveFlutter.of(context).hp(2),
                                                0,
                                                ResponsiveFlutter.of(context)
                                                    .verticalScale(10)),
                                            child: Hero(
                                              tag: 'login',
                                              child: TextButton(
                                                  style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty.all(
                                                            Color(0xff53B6AF)),
                                                    minimumSize:
                                                        MaterialStateProperty.all(
                                                            Size(
                                                                ResponsiveFlutter
                                                                        .of(context)
                                                                    .scale(225),
                                                                ResponsiveFlutter
                                                                        .of(context)
                                                                    .scale(50))),
                                                    shape:
                                                        MaterialStateProperty.all(
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                ResponsiveFlutter
                                                                        .of(context)
                                                                    .scale(25.0)),
                                                      ),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.pushNamed(
                                                        context, '/login');
                                                  },
                                                  child: Padding(
                                                      padding: EdgeInsets.fromLTRB(
                                                          50, 10, 50, 10),
                                                      child: Text("LOGIN",
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Proxima Nova',
                                                            fontStyle:
                                                                FontStyle.normal,
                                                            fontSize:
                                                                ResponsiveFlutter
                                                                        .of(context)
                                                                    .scale(14),
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            letterSpacing: 1.5,
                                                          )))),
                                            )),
                                      ]),
                                ],
                              )),
                        ),
                        ),
                      ],
                    )),
              ),
            
          ],
          ),
        ]),
        /*floatingActionButton: FloatingActionButton(
            child: Icon(Icons.navigate_next),
            backgroundColor: Colors.green,
            onPressed: () {Navigator.pushNamed(context, '/cameraPreview');}
          ),*/
      ),
    );
  }
}
