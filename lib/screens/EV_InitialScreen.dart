// Initial Screen > Comes with an authwrapper that checks if the user is logged in
// before taking them to MainMenu (if logged in) or StartScreen (if new user / not logged in)

import 'package:emotiovent/screens/EV_MainMenu.dart';
import 'package:emotiovent/screens/EV_StartScreen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EVInitialScreen extends StatefulWidget {
  static const routeName = '/main';
  @override
  _EVInitialScreenState createState() => _EVInitialScreenState();
}

class _EVInitialScreenState extends State<EVInitialScreen> {
  User firebaseUser;

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    if (firebaseUser != null){
      print("Current User: ${firebaseUser.email}");
      return EVMainMenu();
    } else {
      return EVStartScreen();
    }
  }
}
