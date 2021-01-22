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

import 'package:emotiovent/services/EV_SizeGetter.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class EVViewProfilePicture extends StatefulWidget {
  static const routeName = '/view_profile_picture';
  @override
  _EVViewProfilePictureState createState() => _EVViewProfilePictureState();
}

class _EVViewProfilePictureState extends State<EVViewProfilePicture> {

  ImagePicker _imagePicker = ImagePicker();
  PickedFile _image;
  File image;
  File croppedImage;
  bool _showContent = false;

  Future onAlbumPick() async {
    _image = await _imagePicker.getImage(source: ImageSource.gallery);
    setState(() {
      image = File(_image.path);
    });
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: image.path,
        aspectRatioPresets: [CropAspectRatioPreset.square],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Crop Profile Picture',
            toolbarColor: Colors.pink,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: 'Crop Profile Picture',
        ));
    if (croppedFile != null) {
      image = croppedFile;
    }
  }

  Future onCameraPick() async {
    _image = await _imagePicker.getImage(source: ImageSource.camera);
    setState(() {
      image = File(_image.path);
    });
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: image.path,
        aspectRatioPresets: [CropAspectRatioPreset.square],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Crop Profile Picture',
            toolbarColor: Colors.pink,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: 'Crop Profile Picture',
        ));
    if (croppedFile != null) {
      image = croppedFile;
    }
  }

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
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[400],
                                ),
                              )
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
                                  showGeneralDialog(
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
                                                            onPressed: (){onAlbumPick();},
                                                            style: ButtonStyle(
                                                              minimumSize: MaterialStateProperty.all(Size(getWidth(context) * 0.15, getWidth(context) * 0.15)),
                                                              shape: MaterialStateProperty.all(CircleBorder()),
                                                            ),
                                                            child: Icon(Icons.photo_album_rounded),
                                                          ),
                                                          ElevatedButton(
                                                            onPressed: (){onCameraPick();},
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