/* Selfie Camera Activity.dart
 *
 * --> Notes: There are functions that are commented out in case we want to implement a similar
 *          function in the future that involves face RECOGNITION and DETECTION
 * --> TODO: Add flash button in this activity.
*/

import 'package:emotiovent/models/ScreenArguments.dart';
import 'package:emotiovent/screens/widgets/SelfieCameraCapturePreview.dart';
import 'package:emotiovent/services/EV_CameraProcessUtil.dart';
import 'package:emotiovent/services/EV_FaceBorderPainter.dart';
import 'package:emotiovent/services/EV_SizeGetter.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/foundation.dart';

import 'dart:async';
import 'package:gallery_saver/gallery_saver.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:quiver/collection.dart';
import 'package:flutter/services.dart';

class FaceDetectionFromLiveCamera extends StatefulWidget {
  final String emotion;

  const FaceDetectionFromLiveCamera({Key key, this.emotion}) : super(key: key);

  @override
  _FaceDetectionFromLiveCameraState createState() => _FaceDetectionFromLiveCameraState(emotion);
}

class _FaceDetectionFromLiveCameraState extends State<FaceDetectionFromLiveCamera> with WidgetsBindingObserver, TickerProviderStateMixin{

  final String emotion;
  _FaceDetectionFromLiveCameraState(this.emotion);

  File jsonFile;
  dynamic _scanResults;
  CameraController _camera;
  var interpreter;
  bool _isDetecting = false;
  CameraLensDirection _direction = CameraLensDirection.front;
  dynamic data = {};
  double threshold = 1.0;
  Directory tempDir;
  List e1;
  bool _faceFound = false;
  bool _isSmiling = false;
  bool _showContent = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  AnimationController switcherController;

  Animation<double> switcherAnimation;

  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    _initializeCamera();
    Timer(
      Duration(seconds: 1),
      (){
        setState(() {
          _showContent = true;
        });
      }
    );
  }

  @override
  void dispose(){
    WidgetsBinding.instance.removeObserver(this);
    setState((){_camera = null;});
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

  void _initializeCamera() async {
    //await loadModel();
    CameraDescription description = await getCamera(_direction);

    ImageRotation rotation = rotationIntToImageRotation(
      description.sensorOrientation,
    );

    _camera =
        CameraController(description, ResolutionPreset.low, enableAudio: false);
    await _camera.initialize();
    await Future.delayed(Duration(milliseconds: 500));
    tempDir = await getApplicationDocumentsDirectory();

    // TODO: Add flash button in this activity.
    _camera.setFlashMode(FlashMode.auto);

    _camera.startImageStream((CameraImage image) {
      if (_camera != null) {
        if (_isDetecting) return;
        _isDetecting = true;

        dynamic finalResult = Multimap<String, Face>();
        detect(image, _getDetectionMethod(), rotation).then(
          (dynamic result) async {
            if (result.length == 0)
              _faceFound = false;
            else
              _faceFound = true;
            Face _face;

            for (_face in result) {
              if (_face.smilingProbability > 0.5){
                _isSmiling = true;
              } else{
                _isSmiling = false;
              }

              finalResult.add("FACE", _face);
            }
            setState(() {
              _scanResults = finalResult;
            });

            _isDetecting = false;
          },
        ).catchError(
          (_) {
            _isDetecting = false;
          },
        );
      }
    });
  }

  HandleDetection _getDetectionMethod() {
    final faceDetector = FirebaseVision.instance.faceDetector(
      FaceDetectorOptions(
        mode: FaceDetectorMode.accurate,
        enableClassification: true,
      ),
    );
    return faceDetector.processImage;
  }
  // Uncomment if you will use bounding boxes to identify faces in the camera surface.
  /*
  Widget _buildResults() {
    const Text noResultsText = const Text('');
    if (_scanResults == null ||
        _camera == null ||
        !_camera.value.isInitialized) {
      return noResultsText;
    }
    CustomPainter painter;

    final Size imageSize = Size(
      _camera.value.previewSize.height,
      _camera.value.previewSize.width,
    );
    painter = FaceDetectorPainter(imageSize, _scanResults);
    return CustomPaint(
      painter: painter,
    );
  }
  */

  Widget _buildImage() {
    if (_camera == null || !_camera.value.isInitialized) {
      return AnimatedOpacity(
        opacity: _showContent ? 1.0 : 0.0,
        duration: Duration(seconds: 1),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return _camera == null
          ? const Center(child: null)
          : Stack(
            children: <Widget>[

              Container(
                width: getWidth(context),
                height: getHeight(context),
              ),

              Column(
                children: [
                  Flexible(
                    flex: 4,
                    child: Container(
                      child: Stack(
                        fit: StackFit.expand,
                          children: <Widget>[
                                CameraPreview(_camera),
                                // Uncomment if you will use bounding boxes to identify faces in the camera surface.
                                //_buildResults(),
                              ],
                        ),
                    ),
                  ),

                  Flexible(
                    flex: 1,
                    child: Container(
                      color: Colors.white,
                    ),
                  ),

                ],
              )
            ],
          );
  }

  void _toggleCameraDirection() async {
    if (_direction == CameraLensDirection.back) {
      _direction = CameraLensDirection.front;
    } else {
      _direction = CameraLensDirection.back;
    }
    await _camera.stopImageStream();
    await _camera.dispose();

    setState(() {
      _camera = null;
    });

    _initializeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: _buildImage(),
        floatingActionButton: AnimatedOpacity(
          opacity: _showContent ? 1.0 : 0.0,
          duration: Duration(seconds: 1),
          child: Column(
            children: [
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
                      FloatingActionButton(
                        backgroundColor: (_isSmiling && _faceFound) ? Colors.blue : Colors.grey,
                        child: Icon(Icons.camera),
                        onPressed: (){
                          if (_isSmiling && _faceFound){onTakePictureButtonPressed();}
                        }
                      ),

                      ConstrainedBox(
                        constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width / 2.5, maxWidth: MediaQuery.of(context).size.width / 1.1),
                        child: AnimatedSwitcher(
                          duration: Duration(milliseconds: 500),
                          child: (_isSmiling && _faceFound) ? Text(
                            "Tap capture!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Nexa',
                              fontWeight: FontWeight.w700,
                              fontSize: getWidth(context) / 15,
                              color: Colors.grey[600],
                            ),
                          ) :
                          Text(
                            "Smile!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Nexa',
                              fontWeight: FontWeight.w700,
                              fontSize: getWidth(context) / 15,
                              color: Colors.grey[600],
                            ),
                          )
                        ),
                      ),

                      FloatingActionButton(
                        onPressed: _toggleCameraDirection,
                        heroTag: null,
                        child: _direction == CameraLensDirection.back
                            ? const Icon(Icons.camera_front)
                            : const Icon(Icons.camera_rear),
                      ),
                    ]
                  ),
                ),
              ),

            ]
      ),
        ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void showInSnackBar(String message) {
    // ignore: deprecated_member_use
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
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
      _camera.stopImageStream();
      XFile file = await _camera.takePicture();
      return file;
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
  }

  void _showCameraException(CameraException e) {
    print('Error: ${e.code}\nError Message: ${e.description}');
    showInSnackBar('Error: ${e.code}\n${e.description}');
  }

  void onTakePictureButtonPressed() {
    takePicture().then((XFile file) {
      if (mounted) {
        if (file != null){
          GallerySaver.saveImage(file.path, albumName: 'Camera').then((bool success){
            showInSnackBar('Picture saved to ${file.path}');
          }).then((bool success){
            _camera.dispose();
            Navigator.of(context).pushReplacementNamed(
              SelfieCameraCapturePreview.routeName, 
              arguments: ScreenArguments(emotion: emotion, imgPath: file.path)
            );
          });
        }
      }
    });
  }
}