import 'package:emotiovent/models/UserData.dart';
import 'package:emotiovent/services/EV_AuthService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';
import 'package:emotiovent/services/database/GetStatistics.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppSettings extends StatefulWidget {
  @override
  _AppSettingsState createState() => _AppSettingsState();
}

class _AppSettingsState extends State<AppSettings> {

  void _signOut(BuildContext context) async {
    await context
        .read<AuthenticationService>()
        .signOut()
        .then((String successMsg) {
      print(successMsg);
      Phoenix.rebirth(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              child: Text("Logout"),
              onPressed:(){_signOut(context);},
            )
          ),
          Center(
            child: ElevatedButton(
              child: Text("Get Statistics (DEBUG MODE)"),
              onPressed:(){
                GetStatistics(firebaseUser).GetData();
              },
            )
          ),
          
        ],
      ),
    );
  }
}