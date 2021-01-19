import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:image_picker/image_picker.dart';

class CaptureSurroundingsPreview extends StatefulWidget {
  static const routeName = '/captureSurroundingsPreview';
  final String emotion;
  final String imgPath;
  final List<ImageLabel> labels;

  const CaptureSurroundingsPreview({Key key, this.emotion, this.imgPath, this.labels}) : super(key: key);

  @override
  _CaptureSurroundingsPreviewState createState() => _CaptureSurroundingsPreviewState(
                                                      emotion: emotion,
                                                      imgPath: imgPath,
                                                      labels: labels
                                                    );
}

class _CaptureSurroundingsPreviewState extends State<CaptureSurroundingsPreview> {
  final String emotion;
  final String imgPath;
  final List<ImageLabel> labels;

  _CaptureSurroundingsPreviewState({this.labels, this.emotion, this.imgPath});

  dynamic _pickImageError;
  String _retrieveDataError;
  PickedFile _imageFile;

  Text _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }

  Widget _previewImage() {
    final Text retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_imageFile != null) {  
      return Semantics(
        child: Image.file(File(_imageFile.path)),
        label: 'image_picker_example_picked_image');
    } else if (_pickImageError != null) {
      return Text(
        'Pick image error: $_pickImageError',
        textAlign: TextAlign.center,
      );
    } else {
      return const Text(
        'You have not yet picked an image.',
        textAlign: TextAlign.center,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[

        ],
      ),
    );
  }
}