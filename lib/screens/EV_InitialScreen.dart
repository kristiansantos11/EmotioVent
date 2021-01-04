import 'package:emotiovent/screens/EV_MainMenu.dart';
import 'package:emotiovent/screens/EV_StartScreen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class EVAuthWrapper extends StatelessWidget {
  static const routeName = '/main';

  const EVAuthWrapper({
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