import 'package:flutter/material.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

import 'EV_AuthService.dart';
import 'package:provider/provider.dart';

class EVLogin extends StatefulWidget {
  static const routeName = '/login';

  @override
  _EVLoginState createState() => _EVLoginState();
}

class _EVLoginState extends State<EVLogin> {

  final _emailTextController = TextEditingController();
  final _pwTextController = TextEditingController();

  final _formKey = GlobalKey<FormState>();



  String debugMessage = "[DEBUG] You have entered:\n";

  // Set default `_initialized` and `_error` state to false


  // Define an async function to initialize FlutterFire

  void backButtonPressed(BuildContext ctx){
    Navigator.popUntil(ctx, ModalRoute.withName('/main'));
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
    ).then((_) => Navigator.pop(ctx)).catchError((e) => {
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
          action: SnackBarAction(
              label: 'OKAY', onPressed: scaffold.hideCurrentSnackBar),
        ),
      );
    }
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
                            "Login",
                            style: TextStyle(
                              fontFamily: 'SegoeUIBlack',
                              fontSize: ResponsiveFlutter.of(context).scale(40.0),
                              color: Colors.grey[700],
                              letterSpacing: -1,
                            ),
                          ),

                          Text(
                            "Welcome back to emotiovent!",
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
                                    minWidth: ResponsiveFlutter.of(context).scale(20.0),
                                    height: ResponsiveFlutter.of(context).hp(4.8),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(ResponsiveFlutter.of(context).scale(14)),
                                      side: BorderSide(color: Color(0xff53B6AF))
                                    ),
                                    onPressed: () {backButtonPressed(context);},
                                    child: Text(
                                      "BACK",
                                      style: TextStyle(
                                        letterSpacing: 0,
                                        fontFamily: 'Roboto',
                                        fontSize: ResponsiveFlutter.of(context).scale(14),
                                        fontWeight: FontWeight.w700,
                                        fontStyle: FontStyle.normal,
                                        color: Color(0xff53B6AF),
                                      ),
                                    ),
                                  ),

                                  ButtonTheme(
                                    minWidth: ResponsiveFlutter.of(context).wp(20.0),
                                    height: ResponsiveFlutter.of(context).hp(4.8),
                                    child: RaisedButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(ResponsiveFlutter.of(context).scale(14)),
                                      ),
                                      color: Color(0xff53B6AF),
                                      onPressed: () {_signInWithEmailAndPassword(context);},
                                      child: Text(
                                        "LOGIN",
                                        style: TextStyle(
                                          letterSpacing: 0,
                                          fontFamily: 'Roboto',
                                          fontSize: ResponsiveFlutter.of(context).scale(14),
                                          fontWeight: FontWeight.w500,
                                          fontStyle: FontStyle.normal,
                                          color: Colors.white,
                                        )
                                      ),
                                    ),
                                  )
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