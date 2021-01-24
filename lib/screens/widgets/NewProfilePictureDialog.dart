import 'package:emotiovent/services/EV_SizeGetter.dart';
import 'package:emotiovent/services/ProfilePictureUpload.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


Future newProfilePictureDialog({@required BuildContext context, @required User user}){
  ImagePicker _imagePicker = ImagePicker();
  return showGeneralDialog(
    barrierLabel: "Profile Picture",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: Duration(milliseconds: 300),
    context: context,
    pageBuilder: (context, anim1, anim2) {
      return Material(
        type: MaterialType.transparency,
        child: SafeArea(
          child: Align(
            alignment: Alignment.center,
            child: Container(
              height: getHeight(context)/3,
              margin: EdgeInsets.only(bottom: 50, left: 25, right: 25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
              ),
              child: SizedBox.expand(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Where would you like me to get the new profile picture from?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontFamily: 'Proxima Nova',
                          fontStyle: FontStyle.normal,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "Album or camera?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontFamily: 'Proxima Nova',
                          fontStyle: FontStyle.normal,
                          fontSize: 16,
                        ),
                      ),
                      ButtonBar(
                        alignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ElevatedButton(
                            onPressed: () async {
                              await onAlbumPick(
                                imagePicker: _imagePicker,
                                context: context,
                                user: user,
                              );
                            },
                            style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all(Size(getWidth(context) * 0.15, getWidth(context) * 0.15)),
                              shape: MaterialStateProperty.all(CircleBorder()),
                            ),
                            child: Icon(Icons.photo_album_rounded),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              await onCameraPick(
                                imagePicker: _imagePicker,
                                context: context,
                                user: user,
                              );
                            },
                            style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all(Size(getWidth(context) * 0.15, getWidth(context) * 0.15)),
                              shape: MaterialStateProperty.all(CircleBorder()),
                            ),
                            child: Icon(Icons.camera_alt_rounded),
                          ),
                        ]
                      ),
                    ],
                  ),
                )
              ),
            ),
          ),
        ),
      );
    },
    transitionBuilder: (context, animation, secondAnimation, child) {
      animation = CurvedAnimation(curve: Curves.easeInOutCubic, parent: animation);
      return ScaleTransition(
        scale: animation,
        child: child,
      );
    },
  );
}

