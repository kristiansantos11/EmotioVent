// Used for passing arguments from one screen to another
// Screens = routes (i guess??)
// Make sure the arguments passed are optional.
// Make sure the scaffold widgets accepting the arguments also have optional argument requirements.

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';

class ScreenArguments{
  final String emotion;
  final String imgPath;
  final List<ImageLabel> labels;
  final User user;

  ScreenArguments({this.emotion, this.imgPath, this.labels, this.user});
}