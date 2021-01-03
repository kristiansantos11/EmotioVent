import 'package:flutter/material.dart';

import 'package:emotiovent/activities/NoiseMeterSample.dart';
import 'package:emotiovent/activities/ShakePhoneScreen.dart';
// import 'package:emotiovent/activities/ShakeShowAnimals.dart';
// ShakeShowAnimals will be added once I'm done implementing the activity randomizer.

import 'dart:math';

class ActivityRandomizer extends StatelessWidget {
  static const routeName = "/do_activity";

  final String emotion;

  const ActivityRandomizer({Key key, this.emotion}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> activities = [NoiseMeterSample(emotion: emotion), ShakePhoneActivity(emotion: emotion)];
    Random rand = new Random();
    int index = rand.nextInt(activities.length);
    return activities[index];
  }
}