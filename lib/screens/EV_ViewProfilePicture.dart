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
import 'package:emotiovent/models/UserData.dart';
import 'package:emotiovent/screens/widgets/NewProfilePictureDialog.dart';
import 'package:emotiovent/services/EV_SizeGetter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EVViewProfilePicture extends StatefulWidget {
  static const routeName = '/view_profile_picture';
  
  @override
  _EVViewProfilePictureState createState() => _EVViewProfilePictureState();
}

class _EVViewProfilePictureState extends State<EVViewProfilePicture> {

  Timer initStateTimer; 
  File image;
  bool _showContent = false;
  String email;
  User firebaseUser;
  String profilePicture;

  @override
  void initState(){
    super.initState();

    initStateTimer = Timer(
      Duration(seconds: 1),
      (){setState(() {
        _showContent = true;
      });}
    );

  }

  @override
  void dispose(){

    if(initStateTimer.isActive){
      initStateTimer.cancel();
    }

    super.dispose();
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

                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}