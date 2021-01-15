// Sign Up Page.
// In-case of any deprecated code, I will clean it as soon as the backend work is done.

import 'dart:async';

import 'package:emotiovent/services/EV_AuthService.dart';
import 'package:emotiovent/services/EV_SizeGetter.dart';
import 'package:flutter/material.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

import 'package:provider/provider.dart';

import '../services/EV_AuthService.dart';
import 'package:emotiovent/Temp/transferUserData.dart';

class EVSignUp extends StatefulWidget {
  static const routeName = '/signup';

  final String emotion;

  const EVSignUp({Key key, this.emotion}) : super(key: key);

  @override
  _EVSignUpState createState() => _EVSignUpState(emotion);
}

class _EVSignUpState extends State<EVSignUp> {

  final String emotion;

  final _emailTextController = TextEditingController();
  final _pwTextController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String debugMessage = "[DEBUG] You have entered:\n";
  bool _showContent = false;

  _EVSignUpState(this.emotion);

  void backButtonPressed(ctx){
    Navigator.popUntil(ctx, ModalRoute.withName('/main'));
  }

  void continueButtonPressed(ctx){
    Navigator.popUntil(ctx, ModalRoute.withName('/main'));
  }

  @override
  void initState(){
    super.initState();
    Timer(
      Duration(seconds: 1),
      (){
        setState(() {
          _showContent = true;
        });
      }
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _pwTextController.dispose();
    _emailTextController.dispose();
    super.dispose();
  }

  void register(ctx) async {
    var outMsg;
    var _success = true;
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
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!Attempting to put sample data...");
    TransferUserData tug = TransferUserData(username: "SampleU",name: "SampleN", birthdate: "SampleB",
    contactNumber: "SampleC",gender: "SampleG");
    tug.transferData();

    if (_success){
      continueButtonPressed(ctx);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedOpacity(
        opacity: _showContent ? 1.0 : 0.0,
        duration: Duration(seconds: 1),
        child: SafeArea(
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
                                  alignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[

                                    TextButton(
                                      style: ButtonStyle(
                                        shape: MaterialStateProperty.all<OutlinedBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(getWidth(context)/24),
                                            side: BorderSide(
                                              color: Color(0xfff308a2),
                                              ),
                                          )
                                        ),
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

                                    ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all(Color(0xfff308a2)),
                                        shape: MaterialStateProperty.all<OutlinedBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(ResponsiveFlutter.of(context).scale(14)),
                                          ),
                                        ),
                                      ),
                                      onPressed: () {register(context);},
                                      child: Text(
                                        "SIGNUP",
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
      ),
    );
  }
}