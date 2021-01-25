// Initial Screen > Comes with an authwrapper that checks if the user is logged in
// before taking them to MainMenu (if logged in) or StartScreen (if new user / not logged in)

import 'package:emotiovent/models/UserInfo.dart';
import 'package:emotiovent/screens/BeforeMainMenu.dart';
import 'package:emotiovent/screens/EV_MainMenu.dart';
import 'package:emotiovent/screens/EV_StartScreen.dart';
import 'package:emotiovent/services/FirestoreService.dart';
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
    FirestoreService _firestoreService = FirestoreService();

    if (firebaseUser != null){
      // This is where the StreamProvider should go so that the rest of the app can use the value.
      return BeforeMainMenu()
        ;
    } else {
      return EVStartScreen();
    }
  }
}