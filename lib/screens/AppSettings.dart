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
          ElevatedButton(
            child: Text("Logout"),
            onPressed:(){_signOut(context);},
          ),

          ElevatedButton(
            child: Text("Get Statistics DAILY (DEBUG MODE)"),
            onPressed:() async{
              // # SAMPLE ON USING THE CLASS. SET FREQUENCY BY 0 to 4. (Daily to Yearly)
              await GetStatistics(firebaseUser:firebaseUser,frequency: 0).getData();
              print("Most Felt Emotion: ${GetStatistics.mostFeltEmotion}");
              print("Average Time You Feel This Emotion: ${GetStatistics.averageTime}");
              print("You open this app ${GetStatistics.numberOfTimes} times already.");
              print("The average satisfaction per activity is ${GetStatistics.averageSatisfaction}");
            },
          ),

          ElevatedButton(
            child: Text("Get Statistics WEEKLY (DEBUG MODE)"),
            onPressed:() async{
              // # SAMPLE ON USING THE CLASS. SET FREQUENCY BY 0 to 4. (Daily to Yearly)
              await GetStatistics(firebaseUser:firebaseUser,frequency: 1).getData();
              print("Most Felt Emotion: ${GetStatistics.mostFeltEmotion}");
              print("Average Time You Feel This Emotion: ${GetStatistics.averageTime}");
              print("You open this app ${GetStatistics.numberOfTimes} times already.");
              print("The average satisfaction per activity is ${GetStatistics.averageSatisfaction}");
            },
          ),

          ElevatedButton(
            child: Text("Get Statistics MONTHLY (DEBUG MODE)"),
            onPressed:() async{
              // # SAMPLE ON USING THE CLASS. SET FREQUENCY BY 0 to 4. (Daily to Yearly)
              await GetStatistics(firebaseUser:firebaseUser,frequency: 2).getData();
              print("Most Felt Emotion: ${GetStatistics.mostFeltEmotion}");
              print("Average Time You Feel This Emotion: ${GetStatistics.averageTime}");
              print("You open this app ${GetStatistics.numberOfTimes} times already.");
              print("The average satisfaction per activity is ${GetStatistics.averageSatisfaction}");
            },
          ),

          ElevatedButton(
            child: Text("Get Statistics YEARLY (DEBUG MODE)"),
            onPressed:() async{
              // # SAMPLE ON USING THE CLASS. SET FREQUENCY BY 0 to 4. (Daily to Yearly)
              await GetStatistics(firebaseUser:firebaseUser,frequency: 3).getData();
              print("Most Felt Emotion: ${GetStatistics.mostFeltEmotion}");
              print("Average Time You Feel This Emotion: ${GetStatistics.averageTime}");
              print("You open this app ${GetStatistics.numberOfTimes} times already.");
              print("The average satisfaction per activity is ${GetStatistics.averageSatisfaction}");
            },
          ),

        ],
      ),
    );
  }
}