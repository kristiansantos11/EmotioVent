import 'package:emotiovent/EV_AuthService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

import 'package:provider/provider.dart';

import 'EV_AuthService.dart';

class EVSignUp extends StatefulWidget {
  @override
  _EVSignUpState createState() => _EVSignUpState();
}

class _EVSignUpState extends State<EVSignUp> {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final _emailTextController = TextEditingController();
  final _pwTextController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _success;
  String _userEmail;

  String debugMessage = "[DEBUG] You have entered:\n";

  void backButtonPressed(ctx){
    Navigator.pop(ctx);
  }

  /*void continueButtonPressed(ctx){
    Navigator.popUntil(ctx, 
  }*/

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _pwTextController.dispose();
    _emailTextController.dispose();
    super.dispose();
  }

  void _register(ctx) async {
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

    context.read<AuthenticationService>().signUp(
      email: _emailTextController.text.trim(),
      password: _pwTextController.text.trim()
    ).catchError((e) => {
      showDialog(
        context: ctx,
        builder: (ctx) {
          return AlertDialog(
            content: Text(e.message)
          );
        }
      )
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Column(
                children: <Widget>[

                  Flexible(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children:<Widget>[
                          Text(
                            "Sign Up",
                            style: TextStyle(
                              fontFamily: 'SegoeUIBlack',
                              fontSize: ResponsiveFlutter.of(context).scale(40.0),
                              color: Colors.grey[700],
                              letterSpacing: -1,
                            ),
                          ),

                          Text(
                            "Please fill up the necessary fields:",
                            style: TextStyle(
                              fontFamily: 'Helvetica',
                              fontSize: ResponsiveFlutter.of(context).scale(12),
                              color: Colors.grey[600]
                            ),
                          ),

                        ]
                      ),
                    )
                  ),

                  Flexible(
                    flex: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:<Widget>[

                          Form(
                            key: _formKey,
                            child: Column(
                              children: <Widget>[

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
                                      controller: _emailTextController,
                                      style: TextStyle(
                                        fontFamily: 'Aileron',
                                        fontStyle: FontStyle.normal,
                                        fontSize: ResponsiveFlutter.of(context).scale(16),
                                      ),
                                      decoration: InputDecoration(
                                        labelText: 'Email'
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
                                        fontFamily: 'Aileron',
                                        fontStyle: FontStyle.normal,
                                        fontSize: ResponsiveFlutter.of(context).scale(16),
                                      ),
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        labelText: 'Password'
                                      ),
                                    ),
                                  )

                              ]
                            )
                          ),

                          Flexible(
                            flex: 1,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                              child: ButtonBar(
                                alignment: MainAxisAlignment.center,
                                children: <Widget>[

                                  FlatButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(ResponsiveFlutter.of(context).scale(14)),
                                      side: BorderSide(color: Color(0xfff308a2))
                                    ),
                                    onPressed: () {backButtonPressed(context);},
                                    child: Text(
                                      "BACK",
                                      style: TextStyle(
                                        letterSpacing: 0,
                                        color: Color(0xfff308a2),
                                      ),
                                    ),
                                  ),

                                  RaisedButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(ResponsiveFlutter.of(context).scale(14)),
                                    ),
                                    color: Color(0xfff308a2),
                                    onPressed: () {_register(context);},
                                    child: Text(
                                      "CONTINUE",
                                      style: TextStyle(
                                        letterSpacing: 0,
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
    );
  }
}