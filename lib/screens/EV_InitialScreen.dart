// Initial Screen > Comes with an authwrapper that checks if the user is logged in
// before taking them to MainMenu (if logged in) or StartScreen (if new user / not logged in)

import 'package:emotiovent/screens/EV_MainMenu.dart';
import 'package:emotiovent/screens/EV_StartScreen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EVInitialScreen extends StatelessWidget {
  static const routeName = '/main';

  const EVInitialScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    // Using ternary operators here makes the code less readable
    // Use it if every one of your members are familiarized with its usage.
    if (firebaseUser != null){
      return EVMainMenu();
    } else {
      return EVStartScreen();
    }
  }
}