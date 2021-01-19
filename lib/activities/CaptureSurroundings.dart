/* IDEA:
   * - Capture the image
   * - Label the image
   * - Display Label and Picture Preview next scaffold
   * - Satisfaction Rate
   */

import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:emotiovent/models/ScreenArguments.dart';
import 'package:emotiovent/screens/widgets/CaptureSurroundingsPreview.dart';
import 'package:emotiovent/services/EV_CameraProcessUtil.dart';
import 'package:emotiovent/services/EV_SizeGetter.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';

typedef void OnPickImageCallback(double maxWidth, double maxHeight, int quality);

class CaptureSurroundings extends StatefulWidget {
  final String emotion;

  const CaptureSurroundings({Key key, this.emotion}) : super(key: key);

  @override
  _CaptureSurroundingsState createState() => _CaptureSurroundingsState(emotion);
}

class _CaptureSurroundingsState extends State<CaptureSurroundings> with WidgetsBindingObserver, TickerProviderStateMixin{
  final String emotion;

  _CaptureSurroundingsState(this.emotion);

  CameraController _camera;
  CameraLensDirection _direction;
  Directory tempDir;
  List<ImageLabel> labels;

  bool _showContent = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  ImageLabeler imageLabeler;
  PickedFile _imageFile;
  dynamic _pickImageError;
  String _retrieveDataError;

  final ImagePicker _picker = ImagePicker();

  void _initializeCamera() async {
    CameraDescription description = await getCamera(_direction);

    ImageRotation rotation = rotationIntToImageRotation(
      description.sensorOrientation,
    );

    _camera = CameraController(
      description,
      ResolutionPreset.high,
      enableAudio: false,
    );

    await _camera.initialize();
    await Future.delayed(Duration(milliseconds: 500));
    tempDir = await getApplicationDocumentsDirectory();
  }

  void showInSnackBar(String message) {
    // ignore: deprecated_member_use
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
  }

  void _showCameraException(CameraException e) {
    print('Error: ${e.code}\nError Message: ${e.description}');
    showInSnackBar('Error: ${e.code}\n${e.description}');
  }

  Future<XFile> takePicture() async {
    if (!_camera.value.isInitialized) {
      showInSnackBar('Error: select a camera first.');
      return null;
    }

    if (_camera.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      XFile file = await _camera.takePicture();
      return file;
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
  }

  void onTakePictureButtonPressed() {
    takePicture().then((XFile file) async {
      if (mounted) {
        if (file != null){
          labels = await imageLabeler.processImage(FirebaseVisionImage.fromFile(File(file.path)));
          GallerySaver.saveImage(file.path, albumName: 'Camera').then((bool success){
            showInSnackBar('Picture saved to ${file.path}');
          }).then((bool success){
            _camera.dispose();
            Navigator.of(context).pushReplacementNamed(
              CaptureSurroundingsPreview.routeName, 
              arguments: ScreenArguments(emotion: emotion, imgPath: file.path)
            );
          });
        }
      }
    });
  }

  void _onImageButtonPressed(ImageSource source, {BuildContext context}) async {
      await _displayPickImageDialog(context,
          (double maxWidth, double maxHeight, int quality) async {
        try {
          final pickedFile = await _picker.getImage(
            source: source,
            maxWidth: maxWidth,
            maxHeight: maxHeight,
            imageQuality: quality,
          );
          setState(() {
            _imageFile = pickedFile;
          });
        } catch (e) {
          setState(() {
            _pickImageError = e;
          });
        }
      });
  }

  Future<void> _displayPickImageDialog(
      BuildContext context, OnPickImageCallback onPick) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Pick an image from your library that reminds you of your happy moments!'),
            actions: <Widget>[
              TextButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                  child: const Text('PICK'),
                  onPressed: () {
                    onPick(null, null, null);
                    if(_imageFile != null){
                      Navigator.of(context).pushReplacementNamed(
                        CaptureSurroundingsPreview.routeName,
                        arguments: ScreenArguments(emotion: emotion, labels: labels, imgPath: _imageFile.path)
                      );
                    } else{
                      Navigator.of(context).pop();
                    }       
                  }),
            ],
          );
        });
      }

  Text _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }
  
  /* For next page?
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
  }*/

  Widget _cameraPreview() {
    if (_camera == null || !_camera.value.isInitialized){
      return AnimatedOpacity(
        opacity: _showContent ? 1.0 : 0.0,
        duration: Duration(seconds: 1),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Stack(
        children: <Widget>[

          Container(
            width: getWidth(context),
            height: getHeight(context),
          ),

          Column(
            children: <Widget>[
              Flexible(
                flex: 4,
                child: Container(
                  child: CameraPreview(_camera)
                ),
              ),

              Flexible(
                flex: 1,
                child: Container(
                  color: Colors.white
                ),
              ),
            ],
          ),

        ],
      );
    }
  }

  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    Timer(
      Duration(seconds: 1),
      (){
        setState(() {
          _showContent = true;
        });
      }
    );
    _initializeCamera();
    imageLabeler = FirebaseVision.instance.imageLabeler(
      ImageLabelerOptions(confidenceThreshold: 0.75),
    );
  }

  @override
  void dispose(){
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // App state changed before we got the chance to initialize.
    if (_camera == null || !_camera.value.isInitialized) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      _camera?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      if (_camera != null) {
        _initializeCamera();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: <Widget>[
          _cameraPreview()
        ],
      ),
      floatingActionButton: AnimatedOpacity(
        opacity: _showContent ? 1.0 : 0.0,
        duration: Duration(seconds: 1),
        child: Column(
          children: <Widget>[
            Flexible(
              flex: 5,
              child: Container()
            ),

            Flexible(
              flex: 1,
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround, 
                  children: [
                    // Uncomment if you want face recognition
                    /*FloatingActionButton(
                      backgroundColor: (_faceFound) ? Colors.blue : Colors.blueGrey,
                      child: Icon(Icons.add),
                      onPressed: () {
                        if (_faceFound) _addLabel();
                      },
                      heroTag: null,
                    ),
                    SizedBox(
                      width: 10,
                    ),*/
                    FloatingActionButton(
                      backgroundColor: Colors.blue,
                      child: Icon(Icons.camera),
                      onPressed: (){
                        onTakePictureButtonPressed();
                      }
                    ),

                    ConstrainedBox(
                      constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width / 2.5, maxWidth: MediaQuery.of(context).size.width / 1.1),
                      child: Text(
                        "Capture your\nenvironment",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Nexa',
                          fontWeight: FontWeight.w700,
                          fontSize: getWidth(context) / 35,
                          color: Colors.grey[600],
                        ),
                      )
                    ),

                    FloatingActionButton(
                      onPressed: (){_onImageButtonPressed(ImageSource.gallery);},
                      heroTag: null,
                      child: Icon(Icons.album)
                    ),
                  ]
                ),
              ),
            ),

          ]
        ),
      ),
    );
  }
}