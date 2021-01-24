import 'dart:io';

import 'package:emotiovent/services/cloud_storage/CloudStorage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> onAlbumPick({@required ImagePicker imagePicker, 
                          @required BuildContext context,
                          @required User user,
                          }) async {
  File image;
  await imagePicker.getImage(source: ImageSource.gallery).then((_image){
    image = File(_image.path);
  }).then((_) async {
    await ImageCropper.cropImage(
      sourcePath: image.path,
      aspectRatioPresets: [CropAspectRatioPreset.square],
      androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Crop Profile Picture',
          toolbarColor: Colors.pink,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: true),
      iosUiSettings: IOSUiSettings(
        title: 'Crop Profile Picture',
      )).then((File croppedImage){
        if (croppedImage != null) {
          image = croppedImage;
          return image;
        }
      });
  });
  CloudStorage().uploadProfilePicture(file: image, email: user.email);

  return null;
}

Future<void> onCameraPick({@required ImagePicker imagePicker,
                          @required BuildContext context,
                          @required User user,
                          }) async {
  File image;
  await imagePicker.getImage(source: ImageSource.camera).then((_image){
    image = File(_image.path);
  }).then((_) async {
    await ImageCropper.cropImage(
      sourcePath: image.path,
      aspectRatioPresets: [CropAspectRatioPreset.square],
      androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Crop Profile Picture',
          toolbarColor: Colors.pink,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: true),
      iosUiSettings: IOSUiSettings(
        title: 'Crop Profile Picture',
      )).then((File croppedImage){
        if (croppedImage != null) {
          image = croppedImage;
          return image;
        }
      });
  });
  CloudStorage().uploadProfilePicture(file: image, email: user.email);
  return null;
}