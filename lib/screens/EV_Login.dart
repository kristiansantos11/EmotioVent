import 'dart:async';

import 'package:emotiovent/services/EV_SizeGetter.dart';
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
    Navigator.of(ctx).popUntil(ModalRoute.withName('/main'));
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
        Navigator.of(ctx).popUntil(ModalRoute.withName('/main'))
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
      body: Stack(
        children: <Widget>[

          Hero(
            tag: 'login',
            child: Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
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
                    children: <Widget>[

                      Flexible(
                        flex: 3,
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
                      Flexible(
                        flex: 6,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children:<Widget>[

                              Form(
                                key: _formKey,
                                child: Column(
                                  children: <Widget>[

                                      Padding(
                                        padding: EdgeInsets.fromLTRB(
                                        ResponsiveFlutter.of(context).scale(20), 
                                        20, 
                                        ResponsiveFlutter.of(context).scale(20),
                                        10),
                                        child: TextFormField(
                                          validator: (String value){
                                            if (value.isEmpty){
                                              return 'Please enter your e-mail';
                                            } 
                                            return null;
                                          },
                                          controller: _emailTextController,
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
                                              hintText: "Username",
                                              fillColor: Colors.grey[600],
                                            ),
                                        ),
                                      ),

                                      Padding(
                                        padding: EdgeInsets.fromLTRB(
                                        ResponsiveFlutter.of(context).scale(20), 
                                        0, 
                                        ResponsiveFlutter.of(context).scale(20),
                                        0),
                                        child: TextFormField(
                                          validator: (String value){
                                            if (value.isEmpty){
                                              return 'Please enter your e-mail';
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
                                              hintText: "Password",
                                              fillColor: Colors.grey[600],
                                            ),
                                          ),
                                        ),
                                  ]
                                )
                              ),

                              Flexible(
                                flex: 1,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(0, 20, 15, 0),
                                  child: ButtonBar(
                                    alignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      
                                       
                                      // TextButton(
                                      //   style: ButtonStyle(
                                      //     shape: MaterialStateProperty.all(
                                      //       RoundedRectangleBorder(
                                      //         borderRadius: BorderRadius.circular(ResponsiveFlutter.of(context).scale(14)),
                                      //         side: BorderSide(color: Color(0xff53B6AF))
                                      //       ),
                                      //     ),
                                      //   ),
                                      //   //minWidth: ResponsiveFlutter.of(context).scale(20.0),
                                      //   //height: ResponsiveFlutter.of(context).hp(4.8),
                                      //   onPressed: () {backButtonPressed(context);},
                                      //   child: Padding(
                                      //     padding: EdgeInsets.fromLTRB(
                                      //       getWidth(context)/90,
                                      //       getWidth(context)/500,
                                      //       getWidth(context)/90,
                                      //       getWidth(context)/500,
                                      //     ),
                                      //     child: Text(
                                      //       "BACK",
                                      //       style: TextStyle(
                                      //         letterSpacing: 0,
                                      //         fontFamily: 'Proxima Nova',
                                      //         fontSize: ResponsiveFlutter.of(context).scale(14),
                                      //         fontWeight: FontWeight.w700,
                                      //         fontStyle: FontStyle.normal,
                                      //         color: Color(0xff53B6AF),
                                      //       ),
                                      //     ),
                                      //   ),
                                      // ),



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
                                )
                              ),

                            ]
                          ),
                        
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