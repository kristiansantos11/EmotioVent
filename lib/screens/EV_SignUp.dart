// EV_SignUp

/* TODO: Update UI. @bart
 * -> At the top: Add "Register"
 * -> Make the entire screen Scrollable.
 * -> The background Container is temporary.
 * -> The emotion is optional, because I will add a button in the chooseEmotionScreen to skip
*/

import 'dart:io';

import 'package:emotiovent/models/EmotionRecord.dart';
import 'package:emotiovent/models/UserInfo.dart';
import 'package:date_field/date_field.dart';
import 'package:emotiovent/screens/AskProfilePicture.dart';
import 'package:emotiovent/screens/EV_InitialScreen.dart';
import 'package:emotiovent/services/EV_SizeGetter.dart';
import 'package:emotiovent/services/database/SubmitActivityResult.dart';
import 'package:flutter/material.dart';
import '../services/database/RegisterAccount.dart';

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

  void register({@required BuildContext context}) async
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
              color: Colors.purple[100],
            ),
          ),
          
          SafeArea(
            child: Form(
              key: formKey,
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextFormField(
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
                            decoration: InputDecoration(
                            filled : true,
                            fillColor: Colors.white70,
                            hintText: "Email",
                            ),
                          style: TextStyle(
                          fontSize: 20
                        ),
                          ),
                          Row( children: <Widget>[
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
                              obscureText: toggle1,
                              decoration: InputDecoration(
                              filled : true,
                              fillColor: Colors.white70,
                              hintText: "Password",
                              ),
                              style: TextStyle(
                              fontSize: 20
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
                          Row( children: <Widget>[
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
                              decoration: InputDecoration(
                              filled : true,
                              fillColor: Colors.white70,
                              hintText: "Confirm Password",
                              ),
                              style: TextStyle(
                              fontSize: 20
                            ),
                          ),
                            ),
                          ],),
                          TextFormField(
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
                            decoration: InputDecoration(
                            filled : true,
                            fillColor: Colors.white70,
                            hintText: "Username",
                            ),
                          style: TextStyle(
                          fontSize: 20
                        ),
                          ),
                          TextFormField(
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
                            decoration: InputDecoration(
                            filled : true,
                            fillColor: Colors.white70,
                            hintText: "Name",
                            ),
                          style: TextStyle(
                          fontSize: 20
                        ),
                          ),
                          SizedBox(height: 20),
                          Text("Birthday",
                          style: TextStyle(
                            fontSize: 20
                          ),),
                          DateField(
                            onDateSelected: (DateTime value) {
                              setState(() {
                                birthday = value;
                              });
                            }, 
                            selectedDate: birthday,),
                          SizedBox(height: 10),
                          TextFormField(
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
                            decoration: InputDecoration(
                            filled : true,
                            fillColor: Colors.white70,
                            hintText: "Contact No.",
                            ),
                          style: TextStyle(
                          fontSize: 20
                        ),
                          ),
                          TextFormField(
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
                            decoration: InputDecoration(
                            filled : true,
                            fillColor: Colors.white70,
                            hintText: "Gender",
                            ),
                          style: TextStyle(
                          fontSize: 20
                        ),
                          ),

                          // Note: Just to add a little distance between Register button and TextFormField
                          // You can remove this SizedBox if you want.
                          SizedBox(
                            height: getHeight(context) / 50,
                          ),

                          Center(
                            child: TextButton(
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all(EdgeInsets.all(10.0)),
                                backgroundColor: MaterialStateProperty.all(Colors.green[600]),
                              ),
                              onPressed: () async {register(context: context);},
                              child: Text(
                                "Register",
                                style: TextStyle(
                                  fontSize: getWidth(context)/25,
                                  color: Colors.white
                                ),
                              ),
                            )
                          ),
                          Center(
                            child: TextButton(
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all(EdgeInsets.all(10.0)),
                                backgroundColor: MaterialStateProperty.all(Colors.purple),
                              ),
                              onPressed: () {
                                Navigator.of(context).popUntil(ModalRoute.withName(EVInitialScreen.routeName));
                              },
                              child: Text(
                                "Back",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),

                          // #debug purposes dont remove pls
                          Center(
                            child: TextButton(
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all(EdgeInsets.all(10.0)),
                                backgroundColor: MaterialStateProperty.all(Colors.purple),
                              ),
                              onPressed: () {
                                print("test 123");
                              },
                              child: Text(
                                "DEBUG",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
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