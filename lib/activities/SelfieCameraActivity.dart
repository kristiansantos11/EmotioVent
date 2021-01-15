/* Selfie Camera Activity.dart
 *
 * --> Notes: There are functions that are commented out in case we want to implement a similar
 *          function in the future that involves face RECOGNITION and DETECTION
*/

import 'package:emotiovent/models/ScreenArguments.dart';
import 'package:emotiovent/screens/CameraCapturePreview.dart';
import 'package:emotiovent/screens/EV_SatisfactoryRate.dart';
import 'package:emotiovent/services/EV_CameraProcessUtil.dart';
import 'package:emotiovent/services/EV_FaceBorderPainter.dart';
import 'package:emotiovent/services/EV_SizeGetter.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/foundation.dart';
//import 'package:emotiovent/services/EV_FaceBorderPainter.dart';

import 'dart:async';
import 'package:gallery_saver/gallery_saver.dart';
//import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
//import 'package:image/image.dart' as imglib;
//import 'package:tflite_flutter/tflite_flutter.dart' as tfl;
import 'package:quiver/collection.dart';
import 'package:flutter/services.dart';

class FaceDetectionFromLiveCamera extends StatefulWidget {
  final String emotion;

  const FaceDetectionFromLiveCamera({Key key, this.emotion}) : super(key: key);

  @override
  _FaceDetectionFromLiveCameraState createState() => _FaceDetectionFromLiveCameraState(emotion);
}

class _FaceDetectionFromLiveCameraState extends State<FaceDetectionFromLiveCamera> with WidgetsBindingObserver, TickerProviderStateMixin{
  // Final for constructor
  final String emotion;
  _FaceDetectionFromLiveCameraState(this.emotion);

  XFile imageFile;
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
  //final TextEditingController _name = new TextEditingController();
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
    //_camera.dispose();
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

  /*Future loadModel() async {
    try {
      final gpuDelegateV2 = tfl.GpuDelegateV2(
          options: tfl.GpuDelegateOptionsV2(
        false,
        tfl.TfLiteGpuInferenceUsage.fastSingleAnswer,
        tfl.TfLiteGpuInferencePriority.minLatency,
        tfl.TfLiteGpuInferencePriority.auto,
        tfl.TfLiteGpuInferencePriority.auto,
      ));

      var interpreterOptions = tfl.InterpreterOptions()
        ..addDelegate(gpuDelegateV2);
      interpreter = await tfl.Interpreter.fromAsset('mobilefacenet.tflite',
          options: interpreterOptions);
    } on Exception {
      print('Failed to load model.');
    }
  }*/

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
    /*String _embPath = tempDir.path + '/emb.json';
    jsonFile = new File(_embPath);
    if (jsonFile.existsSync()) data = json.decode(jsonFile.readAsStringSync());*/

    _camera.startImageStream((CameraImage image) {
      if (_camera != null) {
        if (_isDetecting) return;
        _isDetecting = true;
        // Uncomment this if you want facial recognition
        // String res;
        dynamic finalResult = Multimap<String, Face>();
        detect(image, _getDetectionMethod(), rotation).then(
          (dynamic result) async {
            if (result.length == 0)
              _faceFound = false;
            else
              _faceFound = true;
            Face _face;
            /*imglib.Image convertedImage =
                _convertCameraImage(image, _direction);*/
            for (_face in result) {
              if (_face.smilingProbability > 0.5){
                _isSmiling = true;
              } else{
                _isSmiling = false;
              }
              /*double x, y, w, h;
              x = (_face.boundingBox.left - 10);
              y = (_face.boundingBox.top - 10);
              w = (_face.boundingBox.width + 10);
              h = (_face.boundingBox.height + 10);
              imglib.Image croppedImage = imglib.copyCrop(
                  convertedImage, x.round(), y.round(), w.round(), h.round());
              croppedImage = imglib.copyResizeCropSquare(croppedImage, 112);
              */
              // int startTime = new DateTime.now().millisecondsSinceEpoch;

              /* Uncomment these if you want to use face recognition, what I want to
               * Achieve here is FACE DETECTION not FACE RECOGNITION.
               *  res = _recog(croppedImage);
               */

              // int endTime = new DateTime.now().millisecondsSinceEpoch;
              // print("Inference took ${endTime - startTime}ms");

              // Replace "FACE" with res to make FACE RECOGNITION WORK.
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
                                _buildResults(),
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
      /*appBar: AppBar(
        title: const Text('Face recognition'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.navigate_before),
            onPressed: (){Navigator.of(context).pop();},
          ),
          IconButton(
            icon: Icon(Icons.navigate_next),
            onPressed: (){Navigator.of(context).popAndPushNamed(EVSatisfactoryRate.routeName, arguments: emotion);}
          ),
          // Remove this if you want Face Recognition.
          /*PopupMenuButton<Choice>(
            onSelected: (Choice result) {
              if (result == Choice.delete)
                _resetFile();
              else
                _viewLabels();
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Choice>>[
              const PopupMenuItem<Choice>(
                child: Text('View Saved Faces'),
                value: Choice.view,
              ),
              const PopupMenuItem<Choice>(
                child: Text('Remove all faces'),
                value: Choice.delete,
              )
            ],
          ),
          */
        ],
      ),*/
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

  /*imglib.Image _convertCameraImage(CameraImage image, CameraLensDirection _dir) {
    int width = image.width;
    int height = image.height;
    // imglib -> Image package from https://pub.dartlang.org/packages/image
    var img = imglib.Image(width, height); // Create Image buffer
    const int hexFF = 0xFF000000;
    final int uvyButtonStride = image.planes[1].bytesPerRow;
    final int uvPixelStride = image.planes[1].bytesPerPixel;
    for (int x = 0; x < width; x++) {
      for (int y = 0; y < height; y++) {
        final int uvIndex =
            uvPixelStride * (x / 2).floor() + uvyButtonStride * (y / 2).floor();
        final int index = y * width + x;
        final yp = image.planes[0].bytes[index];
        final up = image.planes[1].bytes[uvIndex];
        final vp = image.planes[2].bytes[uvIndex];
        // Calculate pixel color
        int r = (yp + vp * 1436 / 1024 - 179).round().clamp(0, 255);
        int g = (yp - up * 46549 / 131072 + 44 - vp * 93604 / 131072 + 91)
            .round()
            .clamp(0, 255);
        int b = (yp + up * 1814 / 1024 - 227).round().clamp(0, 255);
        // color: 0x FF  FF  FF  FF
        //           A   B   G   R
        img.data[index] = hexFF | (b << 16) | (g << 8) | r;
      }
    }
    var img1 = (_dir == CameraLensDirection.front)
        ? imglib.copyRotate(img, -90)
        : imglib.copyRotate(img, 90);
    return img1;
  }*/

/*
  String _recog(imglib.Image img) {
    List input = imageToByteListFloat32(img, 112, 128, 128);
    input = input.reshape([1, 112, 112, 3]);
    // Deprecated code, will search for a workaround.
    List output = List(1 * 192).reshape([1, 192]);
    interpreter.run(input, output);
    output = output.reshape([192]);
    e1 = List.from(output);
    return compare(e1).toUpperCase();
  }

  String compare(List currEmb) {
    if (data.length == 0) return "No Face saved";
    double minDist = 999;
    double currDist = 0.0;
    String predRes = "NOT RECOGNIZED";
    for (String label in data.keys) {
      currDist = euclideanDistance(data[label], currEmb);
      if (currDist <= threshold && currDist < minDist) {
        minDist = currDist;
        predRes = label;
      }
    }
    print(minDist.toString() + " " + predRes);
    return predRes;
  }

  void _resetFile() {
    data = {};
    jsonFile.deleteSync();
  }

  void _viewLabels() {
    setState(() {
      _camera = null;
    });
    String name;
    var alert = new AlertDialog(
      title: new Text("Saved Faces"),
      content: new ListView.builder(
          padding: new EdgeInsets.all(2),
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) {
            name = data.keys.elementAt(index);
            return new Column(
              children: <Widget>[
                new ListTile(
                  title: new Text(
                    name,
                    style: new TextStyle(
                      fontSize: 14,
                      color: Colors.grey[400],
                    ),
                  ),
                ),
                new Padding(
                  padding: EdgeInsets.all(2),
                ),
                new Divider(),
              ],
            );
          }),
      actions: <Widget>[
        new FlatButton(
          child: Text("OK"),
          onPressed: () {
            _initializeCamera();
            Navigator.pop(context);
          },
        )
      ],
    );
    showDialog(
        context: context,
        builder: (context) {
          return alert;
        });
  }

  void _addLabel() {
    setState(() {
      _camera = null;
    });
    print("Adding new face");
    var alert = new AlertDialog(
      title: new Text("Add Face"),
      content: new Row(
        children: <Widget>[
          new Expanded(
            child: new TextField(
              controller: _name,
              autofocus: true,
              decoration: new InputDecoration(
                  labelText: "Name", icon: new Icon(Icons.face)),
            ),
          )
        ],
      ),
      actions: <Widget>[
        new FlatButton(
            child: Text("Save"),
            onPressed: () {
              _handle(_name.text.toUpperCase());
              _name.clear();
              Navigator.pop(context);
            }),
        new FlatButton(
          child: Text("Cancel"),
          onPressed: () {
            _initializeCamera();
            Navigator.pop(context);
          },
        )
      ],
    );
    showDialog(
        context: context,
        builder: (context) {
          return alert;
        }
    );
  }

  void _handle(String text) {
    data[text] = e1;
    jsonFile.writeAsStringSync(json.encode(data));
    _initializeCamera();
  }*/

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
        setState(() {
          imageFile = file;
        });
        if (file != null){
          GallerySaver.saveImage(file.path, albumName: 'Camera').then((bool success){
            showInSnackBar('Picture saved to ${file.path}');
          }).then((bool success){
            _camera.dispose();
            Navigator.of(context).pushNamed(
              CameraCapturePreview.routeName, 
              arguments: ScreenArguments(emotion: emotion, imgPath: file.path)
            );
          });
        }
      }
    });
  }
}