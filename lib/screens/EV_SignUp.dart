// EV_SignUp

/* TODO: Update UI. @bart
 * -> At the top: Add "Register"
 * -> Make the entire screen Scrollable.
 * -> The background Container is temporary.
 * -> The emotion is optional, because I will add a button in the chooseEmotionScreen to skip
*/

import 'dart:io';

import 'package:emotiovent/models/EmotionRecord.dart';
import 'package:emotiovent/models/UserData.dart';
import 'package:date_field/date_field.dart';
import 'package:emotiovent/screens/AskProfilePicture.dart';
import 'package:emotiovent/screens/EV_InitialScreen.dart';
import 'package:emotiovent/services/EV_SizeGetter.dart';
import 'package:emotiovent/services/database/SubmitActivityResult.dart';
import 'package:flutter/material.dart';
import '../services/database/RegisterAccount.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

//debug dont remove this:
import '../services/database/FetchUserData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class EVSignUp extends StatefulWidget {
  static const routeName = '/signup';

  final String emotion;
  final EmotionRecord emotionRecord;

  const EVSignUp({Key key, this.emotion, this.emotionRecord}) : super(key: key);

  @override
  _EVSignUpState createState() => _EVSignUpState(emotion: emotion);
}

class _EVSignUpState extends State<EVSignUp> {
  final String emotion;
  final EmotionRecord emotionRecord;

  _EVSignUpState({this.emotion, this.emotionRecord});

  final formKey = GlobalKey<FormState>();
  
  bool toggle1 = true;
  bool toggle2 = true;
  String email;
  String password;
  String username;
  String name;
  DateTime birthday;
  String contactnum;
  String gender;
  dynamic response;
  String error = "";
  UserData _user;

  void backButtonPressed(BuildContext ctx){
    Navigator.of(ctx).popUntil(ModalRoute.withName(EVInitialScreen.routeName));
  }

  Future register({@required BuildContext context}) async
  {
    if(formKey.currentState.validate() && birthday != null)
    {
      _user = UserData(
        email: email,
        password: password,
        username: username,
        name: name,
        birthdate: birthday,
        contactnum: contactnum,
        gender: gender,
        profilePicture: File('assets/img/default_profile_picture.jpg'),
      );

      print("Validated successfully."); //debug
      print("Current Data: $email,$password,$username,$name,$birthday,$contactnum,$gender"); //debug
      print("Attempting to register email & password data to firebase..."); //debug
      response = await Database().register(_user);
      if (emotionRecord != null){
        await SubmitActivityResult().submit(user: FirebaseAuth.instance.currentUser, record: emotionRecord);
      }
      print("$response"); //debug - *must be null to be a success
      if(response==null)
      {
        //Navigator.of(context).popUntil(ModalRoute.withName(EVInitialScreen.routeName));
        Navigator.of(context).pushNamed(AskProfilePicture.routeName);
      }
      else
      {
        setState(() {
          error = response;
        });
        showDialog(
          context: context,
          builder: (context){
            return AlertDialog(
              content: Text(
                error
              ),
            );
          }
        );
      }
    }
    else
    {
      print("Not Validated"); //debug

    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
        children: <Widget>[
          Hero(
            tag: 'register',
            child: Container(
              color: Colors.pink[50],
            ),
          ),
          
          SafeArea(
            child: Form(
              key: formKey,
                child: ListView(
                  children: [
                    Container(
                      alignment: Alignment.bottomLeft,
                      padding: EdgeInsets.fromLTRB(28, 0, 0, 0),
                      height: getHeight(context) * 0.15,
                      width: getWidth(context),
                      child: Text(
                        "Register now:",
                        style: TextStyle(
                          letterSpacing: -1,
                          fontFamily: 'Proxima Nova',
                          fontWeight: FontWeight.w800,
                          fontSize: ResponsiveFlutter.of(context).scale(40),
                          color: Colors.grey[700]
                        ),
                      ),
                    ),

                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.fromLTRB(28, 0, 0, 0),
                      child: Text(
                        "Tell us who you are",
                        style: TextStyle(
                          letterSpacing: -1,
                          fontFamily: 'Proxima Nova',
                          fontWeight: FontWeight.w700,
                          fontSize: ResponsiveFlutter.of(context).scale(20),
                          color: Colors.grey[600]
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              validator: (val) {
                                if(val=="")
                                {
                                  return "Empty Email";
                                }
                                else
                                {
                                  email = val;
                                  return null;
                                }
                              },
                              cursorColor: Color(0xfff77272),
                                style: TextStyle(
                                    fontFamily: 'Proxima Nova',
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        ResponsiveFlutter.of(
                                                context)
                                            .scale(18),
                                    color: Colors.white54
                                ),
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(
                                        20, 10, 20, 10),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(
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
                            padding: const EdgeInsets.all(8.0),
                            child: Row( children: <Widget>[
                              Expanded(
                                child: TextFormField(
                                  validator: (val) {
                                    if(val=="")
                                    {
                                      return "Empty Password";
                                    }
                                    else
                                    {
                                      password = val;
                                      return null;
                                    }
                                  },
                                  cursorColor: Color(0xfff77272),
                                  style: TextStyle(
                                      fontFamily: 'Proxima Nova',
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          ResponsiveFlutter.of(
                                                  context)
                                              .scale(18),
                                      color: Colors.white54
                                  ),
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.fromLTRB(
                                            20, 10, 20, 10),
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(
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
                              IconButton(
                              onPressed: () {
                                if(toggle1==true)
                                {
                                  toggle1=false;
                                }
                                else{
                                  toggle1=true;
                                }
                                setState(() {});
                              },
                              icon: Icon(Icons.remove_red_eye),
                              color: Colors.black,
                            )
                            ],),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row( children: <Widget>[
                              Expanded(
                                child: TextFormField(
                                validator: (val) {
                                  if(val=="")
                                  {
                                    return "Empty Password";
                                  }
                                  if(val!=password)
                                  {
                                    return "Password do not match";
                                  }
                                  else
                                  {
                                    return null;
                                  }
                                },
                                obscureText: toggle2,
                                cursorColor: Color(0xfff77272),
                                  style: TextStyle(
                                      fontFamily: 'Proxima Nova',
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          ResponsiveFlutter.of(
                                                  context)
                                              .scale(18),
                                      color: Colors.white54
                                  ),
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.fromLTRB(
                                            20, 10, 20, 10),
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(
                                        Radius.circular(100.0),
                                      ),
                                      borderSide: BorderSide.none,
                                    ),
                                    filled: true,
                                    hintStyle: TextStyle(
                                        color: Colors.white24),
                                    hintText: "Confirm Password",
                                    fillColor: Colors.grey[600],
                                  ),
                                ),
                              ),
                            ],),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              validator: (val) {
                                if(val=="")
                                {
                                  return "Empty Username";
                                }
                                else
                                {
                                  username = val;
                                  return null;
                                }
                              },
                              cursorColor: Color(0xfff77272),
                                    style: TextStyle(
                                        fontFamily: 'Proxima Nova',
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            ResponsiveFlutter.of(
                                                    context)
                                                .scale(18),
                                        color: Colors.white54
                                    ),
                                    decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.fromLTRB(
                                              20, 10, 20, 10),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.all(
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
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              validator: (val) {
                                if(val=="")
                                {
                                  return "Empty Name";
                                }
                                else
                                {
                                  name = val;
                                  return null;
                                }
                              },
                              cursorColor: Color(0xfff77272),
                                    style: TextStyle(
                                        fontFamily: 'Proxima Nova',
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            ResponsiveFlutter.of(
                                                    context)
                                                .scale(18),
                                        color: Colors.white54
                                    ),
                                    decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.fromLTRB(
                                              20, 10, 20, 10),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.all(
                                          Radius.circular(100.0),
                                        ),
                                        borderSide: BorderSide.none,
                                      ),
                                      filled: true,
                                      hintStyle: TextStyle(
                                          color: Colors.white24),
                                      hintText: "Name",
                                      fillColor: Colors.grey[600],
                                    ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Birthday",
                            style: TextStyle(
                                fontFamily: 'Proxima Nova',
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    ResponsiveFlutter.of(
                                            context)
                                        .scale(18),
                                color: Colors.grey[600]
                            ),),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DateField(
                              decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsets.fromLTRB(
                                                20, 10, 20, 10),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.all(
                                            Radius.circular(100.0),
                                          ),
                                          borderSide: BorderSide.none,
                                        ),
                                        filled: true,
                                        hintStyle: TextStyle(
                                            color: Colors.white24),
                                        hintText: "Name",
                                        fillColor: Colors.grey[600],
                                      ),
                              onDateSelected: (DateTime value) {
                                setState(() {
                                  birthday = value;
                                });
                              }, 
                              selectedDate: birthday,),
                          ),

                          SizedBox(height: 10),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              validator: (val) {
                                if(val == "")
                                {
                                  return "Empty number!";
                                }
                                if(RegExp(r'^[0-9]*$').hasMatch(val)&&RegExp(r'$[0-9]\d{10}$|^[0-9]\d{10}$').hasMatch(val))
                                {
                                  contactnum = val;
                                  return null;
                                }
                                else{
                                  return "Input a valid number!";
                                }
                              },
                              cursorColor: Color(0xfff77272),
                                      style: TextStyle(
                                          fontFamily: 'Proxima Nova',
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              ResponsiveFlutter.of(
                                                      context)
                                                  .scale(18),
                                          color: Colors.white54
                                      ),
                                      decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsets.fromLTRB(
                                                20, 10, 20, 10),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.all(
                                            Radius.circular(100.0),
                                          ),
                                          borderSide: BorderSide.none,
                                        ),
                                        filled: true,
                                        hintStyle: TextStyle(
                                            color: Colors.white24),
                                        hintText: "Contact Number",
                                        fillColor: Colors.grey[600],
                                      ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              validator: (val) {
                                if(val=="")
                                {
                                  return "Empty Gender";
                                }
                                else
                                {
                                  gender = val;
                                  return null;
                                }
                              },
                              cursorColor: Color(0xfff77272),
                                        style: TextStyle(
                                            fontFamily: 'Proxima Nova',
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.bold,
                                            fontSize:
                                                ResponsiveFlutter.of(
                                                        context)
                                                    .scale(18),
                                            color: Colors.white54
                                        ),
                                        decoration: InputDecoration(
                                          contentPadding:
                                              EdgeInsets.fromLTRB(
                                                  20, 10, 20, 10),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.all(
                                              Radius.circular(100.0),
                                            ),
                                            borderSide: BorderSide.none,
                                          ),
                                          filled: true,
                                          hintStyle: TextStyle(
                                              color: Colors.white24),
                                          hintText: "Gender",
                                          fillColor: Colors.grey[600],
                                        ),
                            ),
                          ),

                          // Note: Just to add a little distance between Register button and TextFormField
                          // You can remove this SizedBox if you want.
                          SizedBox(
                            height: getHeight(context) / 50,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              
                              TextButton(
                                style: ButtonStyle(
                                  minimumSize: MaterialStateProperty.all(Size(ResponsiveFlutter.of(context).scale(90.0), 0)),
                                  padding: MaterialStateProperty.all(EdgeInsets.all(15.0)),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0)
                                    ),
                                  ),
                                  backgroundColor: MaterialStateProperty.all(Colors.red[300]),
                                ),
                                onPressed: () {
                                  Navigator.of(context).popUntil(ModalRoute.withName(EVInitialScreen.routeName));
                                },
                                child: Text(
                                  "Back",
                                  style: TextStyle(
                                    fontSize: ResponsiveFlutter.of(context).scale(15),
                                    color: Colors.white,
                                  ),
                                ),
                              ),

                              TextButton(
                                style: ButtonStyle(
                                  minimumSize: MaterialStateProperty.all(Size(ResponsiveFlutter.of(context).scale(90.0), 0)),
                                  padding: MaterialStateProperty.all(EdgeInsets.all(15.0)),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0)
                                    ),
                                  ),
                                  backgroundColor: MaterialStateProperty.all(Colors.green[600]),
                                ),
                                onPressed: () {register(context: context);},
                                child: Text(
                                  "Register",
                                  style: TextStyle(
                                    fontSize: ResponsiveFlutter.of(context).scale(15),
                                    color: Colors.white
                                  ),
                                ),
                              ),
                              
                            ],
                          ),

                          

                          // #debug purposes dont remove pls
                          // Center(
                          //   child: TextButton(
                          //     style: ButtonStyle(
                          //       padding: MaterialStateProperty.all(EdgeInsets.all(10.0)),
                          //       backgroundColor: MaterialStateProperty.all(Colors.purple),
                          //     ),
                          //     onPressed: () {
                          //       print("test 123");
                          //     },
                          //     child: Text(
                          //       "DEBUG",
                          //       style: TextStyle(
                          //         color: Colors.white,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    )
                  ],
                ),

            ),
          ),
        ]
        )
      );
  }
}