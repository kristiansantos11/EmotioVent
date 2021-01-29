import 'dart:async';

import 'package:emotiovent/screens/EV_InitialScreen.dart';
import 'package:emotiovent/services/EV_SizeGetter.dart';
import 'package:emotiovent/screens/widget_transition/SlideFadeInText.dart';
import 'package:flutter/material.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

import '../services/EV_AuthService.dart';
import 'package:provider/provider.dart';

class EVLogin extends StatefulWidget {
  static const routeName = '/login';

  @override
  _EVLoginState createState() => _EVLoginState();
}

class _EVLoginState extends State<EVLogin> {
  bool showContent = false;

  final _emailTextController = TextEditingController();
  final _pwTextController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void backButtonPressed(BuildContext ctx){
    Navigator.of(ctx).popUntil(ModalRoute.withName(EVInitialScreen.routeName));
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _pwTextController.dispose();
    _emailTextController.dispose();
    super.dispose();
  }

  void _signInWithEmailAndPassword(ctx) async {
    var _success = true;
    var outMsg;
    if ((_emailTextController.text.isEmpty) || (_pwTextController.text.isEmpty)){
      outMsg = "Please fill up the necessary fields.";
      return showDialog(
        context: ctx,
        builder: (ctx) {
          return AlertDialog(
            content: Text(outMsg)
          );
        }
      );
    }

    await context.read<AuthenticationService>().signIn(
      email: _emailTextController.text.trim(), 
      password: _pwTextController.text.trim()
    ).then((_) => {
        backButtonPressed(context)
      }).catchError((e) => {
      _success = false,
      showDialog(
        context: ctx,
        builder: (ctx) {
          return AlertDialog(
            content: Text(e.message)
          );
        }
      )
    });

    if (_success){
      dynamic scaffold = ScaffoldMessenger.of(ctx);
      await scaffold.showSnackBar(
        SnackBar(
          content: const Text('Logged in'),
        ),
      );
    }
  }

  @override
  void initState(){
    super.initState();

    Timer(
      Duration(milliseconds: 600),
      () => {
        setState(() => {
          showContent = true
        })
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[

          Hero(
            tag: 'login',
            child: Container(
              color: Colors.white,
              width: getWidth(context),
              height: getHeight(context),
            ),
          ),
          
          AnimatedOpacity(
            opacity: showContent ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 500),
            child: SafeArea(
              child: Container(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      ShowUp(
                        delay: 600 + 500,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(30, 0, 0, 30),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:<Widget>[
                                Text(
                                  "Hello!",
                                  style: TextStyle(
                                    fontFamily: 'Proxima Nova',
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.normal,
                                    fontSize: ResponsiveFlutter.of(context).scale(40.0),
                                    color: Colors.grey[700],
                                    letterSpacing: -1,
                                  ),
                                ),

                                Text(
                                  "Welcome back to emotiovent!",
                                  style: TextStyle(
                                    fontFamily: 'Proxima Nova',
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.normal,
                                    fontSize: ResponsiveFlutter.of(context).scale(18),
                                    color: Colors.grey[600]
                                  ),
                                ),

                                Text(
                                  "How are you feeling today?",
                                  style: TextStyle(
                                    fontFamily: 'Proxima Nova',
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.normal,
                                    fontSize: ResponsiveFlutter.of(context).scale(12),
                                    color: Colors.black
                                  ),
                                ),

                              ]
                            ),
                          )
                        ),
                      ),


                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:<Widget>[

                          ShowUp(
                            delay: 600 + 700,
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: <Widget>[

                                    Padding(
                                      padding: EdgeInsets.fromLTRB(
                                      ResponsiveFlutter.of(context).scale(20), 
                                      20, 
                                      ResponsiveFlutter.of(context).scale(20),
                                      10
                                      ),
                                      child: TextFormField(
                                        validator: (String value){
                                          if (value.isEmpty){
                                            return 'Please enter your e-mail';
                                          } 
                                          return null;
                                        },
                                        controller: _emailTextController,
                                        cursorColor: Color(0xfff77272),
                                        style: TextStyle(
                                          fontFamily: 'Proxima Nova',
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.bold,
                                          fontSize: ResponsiveFlutter.of(context).scale(18),
                                          color: Colors.white54
                                        ),
                                        decoration: InputDecoration(contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(100.0),
                                              ),
                                              borderSide: BorderSide.none,
                                            ),
                                            filled: true,
                                            hintStyle: TextStyle(
                                                color: Colors.white24),
                                            hintText: "Email",
                                            fillColor: Colors.grey[600],
                                          ),
                                      ),
                                    ),

                                    Padding(
                                      padding:EdgeInsets.fromLTRB(
                                              ResponsiveFlutter.of(context).scale(20), 
                                              0, 
                                              ResponsiveFlutter.of(context).scale(20),
                                              0),
                                      child: TextFormField(
                                        cursorColor: Color(0xfff77272),
                                        validator: (String value){
                                          if (value.isEmpty){
                                            return 'Please enter your password';
                                          } 
                                          return null;
                                        },
                                        controller: _pwTextController,
                                        style: TextStyle(
                                          fontFamily: 'Proxima Nova',
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.bold,
                                          fontSize: ResponsiveFlutter.of(context).scale(18),
                                          color: Colors.white54
                                        ),
                                        obscureText: true,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(100.0),
                                            ),
                                            borderSide: BorderSide.none,
                                          ),
                                          filled: true,
                                          hintStyle: TextStyle(
                                              color: Colors.white24),
                                          hintText: "Password",
                                          fillColor: Colors.grey[600],
                                        ),
                                      ),
                                    ),
                                ]
                              )
                            ),
                          ),


                            ShowUp(
                              delay: 600 + 900,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                                child: ButtonBar(
                                  alignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    
                                      
                                    TextButton(
                                      style: ButtonStyle(
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(ResponsiveFlutter.of(context).scale(14)),
                                            side: BorderSide(color: Color(0xfff77272))
                                          ),
                                        ),
                                      ),
                                      onPressed: () {backButtonPressed(context);},
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(
                                          getWidth(context)/90,
                                          getWidth(context)/500,
                                          getWidth(context)/90,
                                          getWidth(context)/500,
                                        ),
                                        child: Text(
                                          "       BACK       ",
                                          style: TextStyle(
                                            letterSpacing: 0,
                                            fontFamily: 'Proxima Nova',
                                            fontSize: ResponsiveFlutter.of(context).scale(14),
                                            fontWeight: FontWeight.w700,
                                            fontStyle: FontStyle.normal,
                                            color: Color(0xfff77272),
                                          ),
                                        ),
                                      ),
                                    ),

                                    ElevatedButton(
                                      style: ButtonStyle(
                                        elevation: MaterialStateProperty.all(3.0),
                                        shape: MaterialStateProperty.all<OutlinedBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(ResponsiveFlutter.of(context).scale(14)),
                                          ),
                                        ),
                                        backgroundColor: MaterialStateProperty.all<Color>(Color(0xfff77272))
                                      ),
                                      onPressed: () {_signInWithEmailAndPassword(context);},
                                      child: Text(
                                        "      LOGIN      ",
                                        style: TextStyle(
                                          letterSpacing: 0,
                                          fontFamily: 'Proxima Nova',
                                          fontSize: ResponsiveFlutter.of(context).scale(14),
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.normal,
                                          color: Colors.white,
                                        )
                                      ),
                                    ),

                                  ]
                                ),
                              ),
                            )


                        ]
                      ),
                        


                    ]
                  )
                )
              )
        ),
          )
        ],
      ),
    );
  }
}