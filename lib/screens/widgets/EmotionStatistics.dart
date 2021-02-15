/* 
The statistics should contain:
    1.) "Your most felt emotion"
    2.) Average time na nafeel yung most felt emotion
    3.) Number of times app was open for a specific period of time
    4.) Average satisfaction per activity
*/

import 'dart:async';

import 'package:emotiovent/models/EmotionRecord.dart';
import 'package:emotiovent/services/EV_SizeGetter.dart';
import 'package:emotiovent/services/database/GetStatistics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:emotiovent/models/EmotionCounters.dart';

class EmotionStatistics extends StatefulWidget {
  @override
  _EmotionStatisticsState createState() => _EmotionStatisticsState();
}

class _EmotionStatisticsState extends State<EmotionStatistics> {
  int counter = 0;
  Timer timer;
  UniqueKey statisticsUniqueKey = UniqueKey();
  // 0 - Today
  // 1 - Week
  // 2 - Month
  // 3 - Year

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(
      Duration(seconds: 5),
      (Timer _timer){
        setState(() {
          statisticsUniqueKey = UniqueKey();
        });
      }
    );
  }

  @override
  void dispose() {
    if (timer.isActive){
      timer.cancel();
    }
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    User firebaseUser = context.watch<User>();

    if (firebaseUser == null){
      return Center(child: CircularProgressIndicator());
    }

    return FutureBuilder(
      key: statisticsUniqueKey,
      future: GetStatistics(firebaseUser: firebaseUser, frequency: counter).getData(),
      builder: (context, snapshot){
        if (snapshot.hasError){
          return Center(child: CircularProgressIndicator());
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[

            // # TODO: Pakibago yung color property sa loob ng bawat statisticBox depende sa color palette ng UI.

            Container(
              height: getHeight(context) / 15,
              width: getWidth(context) * 0.75,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Color(0xffe7f8f2),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      setState(() {
                        counter = 0;
                      });
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0))),
                      backgroundColor: MaterialStateProperty.all<Color>((counter == 0) ? Color(0xffb5ead7) : Color(0xffe7f8f2)),
                    ),
                    child: Text(
                      "Today",
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        counter = 1;
                      });
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0))),
                      backgroundColor: MaterialStateProperty.all<Color>((counter == 1) ? Color(0xffb5ead7) : Color(0xffe7f8f2)),
                    ),
                    child: Text(
                      "Weekly",
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        counter = 2;
                      });
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0))),
                      backgroundColor: MaterialStateProperty.all<Color>((counter == 2) ? Color(0xffb5ead7) : Color(0xffe7f8f2)),
                    ),
                    child: Text(
                      "Monthly",
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        counter = 3;
                      });
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0))),
                      backgroundColor: MaterialStateProperty.all<Color>((counter == 3) ? Color(0xffb5ead7) : Color(0xffe7f8f2)),
                    ),
                    child: Text(
                      "Yearly",
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ],
              )
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                statisticBox(
                  context: context,
                  color: Color(0xffff8383), // Pabago
                  title: "Most felt emotion:",
                  subtitle: GetStatistics.mostFeltEmotion,
                ),
                statisticBox(
                  context: context,
                  color: Color(0xffffb7b2), // Pabago
                  title: "Average time you felt ${GetStatistics.mostFeltEmotion}:",
                  subtitle: GetStatistics.averageTime,
                ),
              ]
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                statisticBox(
                  context: context,
                  color: Color(0xffe2f0cb), // Pabago
                  title: "You already opened this app for",
                  subtitle: "${GetStatistics.numberOfTimes}",
                ),
                statisticBox(
                  context: context,
                  color: Color(0xffb5ead7), // Pabago
                  title: "Average satisfaction per activity.",
                  subtitle: "${GetStatistics.averageSatisfaction}",
                ), 
              ]
            ),

          ],
        );
      }
    );
  }
}

Widget statisticBox({@required String title, @required String subtitle, @required dynamic color, Widget child, @required BuildContext context}){
  return ClipRRect(
      borderRadius: BorderRadius.circular(18.0),
      child: Center(
        child: Container(
          width: getWidth(context) * 0.42,
          height: getWidth(context) * 0.31,
          decoration: BoxDecoration(
            color: color,
          ),
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    Text(
                      title,
                      style: TextStyle(
                        height: 1,
                        color: Color(0xff3c3b3b),
                        letterSpacing: -0.5,
                        fontFamily: 'Proxima Nova',
                        fontWeight: FontWeight.w700,
                        fontSize: ResponsiveFlutter.of(context).scale(17),
                      ),
                    ),

                    Text(
                      subtitle,
                      style: TextStyle(
                        letterSpacing: -0.5,
                        color: Color(0xff3c3b3b),
                        fontFamily: 'Proxima Nova',
                        fontSize: ResponsiveFlutter.of(context).scale(13)
                      ),
                    ),
                    
                  ]
                ),
              ),
            ]
          ),
        ),
      ),
  );
}
