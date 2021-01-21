/* Suggestion:
 * ->  Place a plus button for profile picture replacement instead
 *     of Yes and No options immediately
 * -> If the plus button is pressed, the popup for where to get the profile picture from
 * is displayed
 * -> after the photo is chosen and cropped into a square, thats when the user will be asked
 *    if they want to use that photo or retake another one or cancel 
 */

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[

          Container(
            color: Colors.white,
          ),

          SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[


                    Container(
                      width: getWidth(context) * 0.75,
                      height: getWidth(context) * 0.75,
                      alignment: Alignment.center,
                      child: Hero(
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
                    ),

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

                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}