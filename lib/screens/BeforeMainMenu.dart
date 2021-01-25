import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/database/fetchUserData.dart';
import 'package:emotiovent/models/UserInfo.dart';
import 'package:emotiovent/screens/EV_MainMenu.dart' ;

// # Read me! So eto ung parent widget ng EVMainMenu.dart. Dito ko nilagay ung StreamProvider. Pero
// # Actually, i think hindi ito necessary at pwede ito icombine sa EV_MainMenu.dart or doon sa Multiprovider ng 
// # main.dart mo. So ikaw na bahala if you want to keep or adjust the code.

class BeforeMainMenu extends StatefulWidget {
  @override
  _BeforeMainMenuState createState() => _BeforeMainMenuState();
}

class _BeforeMainMenuState extends State<BeforeMainMenu> {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User user = auth.currentUser;
    return StreamProvider<UserData>.value(
      value: FetchUserData(user: user).info,
      child: EVMainMenu()
    );
  }
}