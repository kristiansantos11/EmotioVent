/* Suggestion:
 * ->  Place a plus button for profile picture replacement instead
 *     of Yes and No options immediately
 * -> If the plus button is pressed, the popup for where to get the profile picture from
 * is displayed
 * -> after the photo is chosen and cropped into a square, thats when the user will be asked
 *    if they want to use that photo or retake another one or cancel 
 */

import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emotiovent/models/UserInfo.dart';
import 'package:emotiovent/screens/widgets/NewProfilePictureDialog.dart';
import 'package:emotiovent/services/EV_SizeGetter.dart';
import 'package:emotiovent/services/ProfilePictureUpload.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EVViewProfilePicture extends StatefulWidget {
  static const routeName = '/view_profile_picture';
  final User user;

  const EVViewProfilePicture({Key key, @required this.user}) : super(key: key);
  
  @override
  _EVViewProfilePictureState createState() => _EVViewProfilePictureState(user: user);
}

class _EVViewProfilePictureState extends State<EVViewProfilePicture> {
  final User user;

  _EVViewProfilePictureState({@required this.user});

  ImagePicker _imagePicker = ImagePicker();
  File image;
  bool _showContent = false;
  String email;
  User firebaseUser;
  String profilePicture;

  @override
  void initState(){
    super.initState();

    Timer(
      Duration(seconds: 1),
      (){setState(() {
        _showContent = true;
      });}
    );

  }

  @override
  Widget build(BuildContext context) {
    UserData userData = context.watch<UserData>();

    return Scaffold(
      body: Stack(
        children: <Widget>[

          GestureDetector(
            onTap: (){Navigator.of(context).pop();},
            child: Container(
              color: Colors.white,
            ),
          ),

          SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                    Text(
                      "Press anywhere in the blank space to go back",
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontFamily: 'Proxima Nova',
                        fontStyle: FontStyle.normal,
                      ),
                    ),

                    SizedBox(
                      height: getHeight(context) / 25,
                    ),

                    Container(
                      width: getWidth(context) * 0.75,
                      height: getWidth(context) * 0.75,
                      alignment: Alignment.center,
                      child: Stack(
                        children: <Widget>[

                          Hero(
                            tag: 'profile_picture',
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Image(image: NetworkImage(userData.profilePictureLink)),
                            ),
                          ),

                          Positioned(
                            bottom: 10,
                            right: 10,
                            child: AnimatedOpacity(
                              duration: Duration(seconds: 1),
                              opacity: _showContent ? 1.0 : 0.0,
                              child: ElevatedButton(
                                onPressed: () {
                                  newProfilePictureDialog(
                                    context: context,
                                    user: firebaseUser,
                                  );
                                },
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all(CircleBorder())
                                ),
                                child: Icon(Icons.add)
                              ),
                            ),
                          ),

                        ]
                      ),
                    ),

                    /*
                    Column(
                      children: [

                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            "Do you want to replace your profile picture?",
                            style: TextStyle(
                              fontFamily: 'Proxima Nova',
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal,
                              color: Colors.grey[600]
                            ),
                          ),
                        ),

                        ButtonBar(
                          alignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            ElevatedButton(
                              onPressed: (){
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context){
                                    return AlertDialog(
                                      title: Text("Where would you like me to get the new profile picture from?"),
                                      content: Text("Album or camera?"),
                                      actions: <Widget>[
                                        IconButton(
                                          icon: Icon(Icons.album),
                                          onPressed: (){
                                            
                                          },
                                        ),
                                      ],
                                    );
                                  }
                                );
                              },
                              child: Text(
                                "Yes",
                                style: TextStyle(
                                  fontFamily: 'Nexa',
                                  fontWeight: FontWeight.w700,
                                  fontSize: getWidth(context) * 0.05,
                                ),
                              ),
                            ),

                            ElevatedButton(
                              onPressed: (){Navigator.of(context).pop();},
                              child: Text(
                                "No",
                                style: TextStyle(
                                  fontFamily: 'Nexa',
                                  fontWeight: FontWeight.w700,
                                  fontSize: getWidth(context) * 0.05,
                                ),
                              ),
                            ),

                          ],
                        ),

                      ],
                    ),
                    */

                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}