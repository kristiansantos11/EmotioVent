import 'dart:async';

import 'package:emotiovent/models/ScreenArguments.dart';
import 'package:emotiovent/models/UserData.dart';
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
        body: SafeArea(
          child: Stack(
            children: <Widget>[

            Container(
              decoration: BoxDecoration(
              image: DecorationImage(
              image: AssetImage("assets/img/ss-deco.png"),
              ), 
              )  
              ),
            
            Container(
              decoration: BoxDecoration(
              image: DecorationImage(
              image: AssetImage("assets/img/ss-deco2.png"),
              ), 
              )  
              ),

            Container(
            decoration: BoxDecoration(
            image: DecorationImage(
            image: AssetImage("assets/img/ss-bg-green.png"),
            fit: BoxFit.cover
            )
            )
            ),

            Container(
              decoration: BoxDecoration(
              image: DecorationImage(
              image: AssetImage("assets/img/ss-bg-yellow.png"),
              fit: BoxFit.cover,
              alignment: Alignment.bottomRight,
            )
            )
            ),

            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                image: AssetImage("assets/img/ss-bg-red.png"),
                fit: BoxFit.cover,
                alignment: Alignment.bottomLeft,
                ),
                ),
                ),
            
            Stack(
              children: <Widget>[
                AnimatedOpacity(
                  opacity: showContent ? 1.0 : 0.0,
                  duration: const Duration(seconds: 1),
                  child: SafeArea(

                        child: Stack(
                          
                        children: <Widget>[


                              Padding(
                                padding: EdgeInsets.fromLTRB(0,
                                ResponsiveFlutter.of(context).scale(225),
                                ResponsiveFlutter.of(context).scale(150),
                                0),
                                child: Container(
                                  height: ResponsiveFlutter.of(context).scale(130),
                                  decoration: BoxDecoration(
                                    image:DecorationImage(
                                    image: AssetImage("assets/img/fading-dots.png"),
                                  
                                    )
                                  )
                                ),
                              ),
                            
                            

                            Padding(
                              padding: const EdgeInsets.fromLTRB(13,0,0,0),
                              child: Column(
                                children: <Widget> [
                                 SizedBox(
                                     height: ResponsiveFlutter.of(context).scale(280),
                                 ),

                                 Container(
                                    width: ResponsiveFlutter.of(context).scale(263),
                                    height: ResponsiveFlutter.of(context).scale(25),
                                    decoration: BoxDecoration(
                                    color: Color.fromARGB(112, 157,68,216),
                                    borderRadius: BorderRadius.circular(10),
                                    
                                    )
                                  ),
                                ]
                              ),
                            ),

                            Column(
                              children: <Widget>[
                                Flexible(
                                flex: 5,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(
                                    ResponsiveFlutter.of(context).scale(18),
                                    ResponsiveFlutter.of(context).scale(245),
                                    0,
                                    0,
                                  ),
                                  child: Column(
                                  
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[

                                      Text(
                                        "Emotiovent",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          letterSpacing: -1,
                                          fontFamily: 'Proxima Nova',
                                          color: Color.fromARGB(225, 56, 70, 127),
                                          fontSize:
                                              ResponsiveFlutter.of(context).scale(50),
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      
                                      Container(
                                        padding: const EdgeInsets.fromLTRB(
                                    15,
                                    15,
                                    0,
                                    0,
                                        )
                                      ),
                                     
                                          Text(
                                            
                                          "How are you feeling today?",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'Proxima Nova',
                                              fontSize: ResponsiveFlutter.of(context).scale(15),
                                              height: 0.5,
                                              fontStyle: FontStyle.normal,
                                              fontWeight: FontWeight.w900,
                                              color: Colors.black87)
                                        ),
                                      

                                    ],
                                  ),
                                ),
                              ),
                              ]
                            ),
                                
                            Column (
                                children: <Widget> [
                                  Flexible(
                                child:Padding(
                                  padding: EdgeInsets.fromLTRB(
                                          125,
                                          ResponsiveFlutter.of(context).verticalScale(400), 25, 
                                          ResponsiveFlutter.of(context).verticalScale(0)
                                          ),
                                  child: Column(
                          
                                    children: <Widget>[
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Hero(
                                            tag: 'register',
                                            child: Container(
                                              width: 170,
                                              height: 40,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(18.0),
                                                ),
                                                child: TextButton(
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty.all<
                                                                  Color>(
                                                              Color.fromARGB(255,255,131,131)),
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
                                                                      .scale(200),
                                                                  ResponsiveFlutter
                                                                          .of(context)
                                                                      .scale(35))),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.of(context).pushNamed(
                                                          ExplainBeforeRegister
                                                              .routeName);
                                                    },
                                                    child: Padding(
                                                        padding: EdgeInsets.fromLTRB(
                                                            3, 3, 3, 0),
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
                                              ResponsiveFlutter.of(context).hp(1),
                                              0,
                                              ResponsiveFlutter.of(context)
                                                  .verticalScale(10)
                                            ),
                                            child: Hero(
                                                tag: 'login',
                                              child: Container(
                                                width: 170,
                                                height: 40,
                                                child: TextButton(
                                                  style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty.all(
                                                            Color.fromARGB(255,255,131,131)),
                                                    minimumSize:
                                                        MaterialStateProperty.all(
                                                            Size(
                                                                ResponsiveFlutter
                                                                        .of(context)
                                                                    .scale(200),
                                                                ResponsiveFlutter
                                                                        .of(context)
                                                                    .scale(35))),
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
                                                        3, 3, 3, 0),
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
                                                      )
                                                    )
                                                  )
                                                ),
                                              )
                                            ),
                                          )

                                        ]
                                      ),

                                    ],
                                  )
                                ),
                              ),
                           
                          ],
                        )
                        ]),
                  ),
                )  
              ],
            ),
            ]
          ),
        ),
        /*floatingActionButton: FloatingActionButton(
            child: Icon(Icons.navigate_next),
            backgroundColor: Colors.green,
            onPressed: () {Navigator.pushNamed(context, '/cameraPreview');}
          ),*/
      ),
    );
  }
}