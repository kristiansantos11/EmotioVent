import 'package:camera/camera.dart';
import 'package:emotiovent/activities/NoiseMeterSample.dart';
import 'package:emotiovent/activities/ShakePhoneScreen.dart';
import 'package:emotiovent/activities/ShakeShowAnimals.dart';
import 'package:emotiovent/activities/SelfieCameraActivity.dart';

import 'package:flutter/material.dart';

import 'dart:math';

class ActivityRandomizer extends StatelessWidget {
  static const routeName = "/do_activity";

  final String emotion;
  final List<CameraDescription> cameras;

  const ActivityRandomizer({Key key, this.emotion, this.cameras}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> activities = [
                              NoiseMeterSample(emotion: emotion), 
                              ShakePhoneActivity(emotion: emotion), 
                              ShakeShowAnimals(emotion: emotion),
                              FaceDetectionFromLiveCamera(emotion: emotion),
                              ];
                              
    Random rand = new Random();
    int index = rand.nextInt(activities.length);
    return activities[index];
  }
}