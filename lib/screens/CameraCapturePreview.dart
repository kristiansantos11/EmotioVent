import 'package:flutter/material.dart';

class CameraCapturePreview extends StatefulWidget {
  static const routeName = '/cameraPreview';
  final String emotion;
  final String imgPath;

  const CameraCapturePreview({Key key, this.emotion, this.imgPath}) : super(key: key);
  
  @override
  _CameraCapturePreviewState createState() => _CameraCapturePreviewState();
}

class _CameraCapturePreviewState extends State<CameraCapturePreview> {
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