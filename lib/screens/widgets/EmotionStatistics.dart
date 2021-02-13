/* 
The statistics should contain:
    1.) "Your most felt emotion"
    2.) Average time na nafeel yung most felt emotion
    3.) Number of times app was open for a specific period of time
    4.) Average satisfaction per activity
*/

import 'package:emotiovent/models/EmotionRecord.dart';
import 'package:emotiovent/services/EV_SizeGetter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:emotiovent/models/EmotionCounters.dart';

class EmotionStatistics extends StatefulWidget {
  @override
  _EmotionStatisticsState createState() => _EmotionStatisticsState();
}

class _EmotionStatisticsState extends State<EmotionStatistics> {
  
  @override
  Widget build(BuildContext context) {
    // DailyEmotion dailyEmotion = DailyEmotion();
    // WeeklyEmotion weeklyEmotion = WeeklyEmotion();
    // MonthlyEmotion monthlyEmotion = MonthlyEmotion();
    // YearlyEmotion yearlyEmotion = YearlyEmotion();
    int emotionCounter = 0;
    int sadCounter = 0;
    int happyCounter = 0;
    int fearCounter = 0;
    int angerCounter = 0;
    int disgustCounter = 0;
    int aloneCounter = 0;

    List<EmotionRecord> emotionRecord = context.watch<List<EmotionRecord>>();

    if(emotionRecord == null) {
      return Center(child: CircularProgressIndicator());
    }

    emotionRecord.forEach(
      (emotion){
        emotionCounter++;
        switch (emotion.emotion){
          case 'Sad':
            sadCounter++;
            break;
          case 'Happy':
            happyCounter++;
            break;
          case 'Fear':
            fearCounter++;
            break;
          case 'Anger':
            angerCounter++;
            break;
          case 'Disgust':
            disgustCounter++;
            break;
          case 'Alone':
            aloneCounter++;
            break;
          default:
            print("Emotion is not included in the list!");
        }
      }
    );

    List<Map<String, dynamic>> emotionCounters = [
      {'emotion': 'Sad', 'counter': sadCounter},
      {'emotion': 'Happy', 'counter': happyCounter},
      {'emotion': 'Disgust', 'counter': disgustCounter},
      {'emotion': 'Fear', 'counter': fearCounter},
      {'emotion': 'Anger', 'counter': angerCounter},
      {'emotion': 'Alone', 'counter': aloneCounter},
    ];

    String mostFeltEmotion;
    if(emotionCounter == 0){
      mostFeltEmotion = "Never vented before.";
    }
    else if (emotionCounter != 0 && emotionCounters.isNotEmpty){
      emotionCounters.sort((a, b) => a['counter'].compareTo(b['counter']));
      mostFeltEmotion = emotionCounters.last['emotion'];
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
                onPressed: () {},
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0))),
                  backgroundColor: MaterialStateProperty.all<Color>(Color(0xffb5ead7)),
                ),
                child: Text(
                  "Today",
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
              ),
              TextButton(
                onPressed: () {},
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0))),
                  backgroundColor: MaterialStateProperty.all<Color>(Color(0xffe7f8f2)),
                ),
                child: Text(
                  "Week",
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
              ),
              TextButton(
                onPressed: () {},
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0))),
                  backgroundColor: MaterialStateProperty.all<Color>(Color(0xffe7f8f2)),
                ),
                child: Text(
                  "Month",
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
              ),
              TextButton(
                onPressed: () {},
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0))),
                  backgroundColor: MaterialStateProperty.all<Color>(Color(0xffe7f8f2)),
                ),
                child: Text(
                  "Year",
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
              subtitle: mostFeltEmotion
            ),
            statisticBox(
              context: context,
              color: Color(0xffffb7b2), // Pabago
              title: "Average time you felt Sad:",
              subtitle: "1 Day",
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
              subtitle: "25 times.",
            ),
            statisticBox(
              context: context,
              color: Color(0xffb5ead7), // Pabago
              title: "Average satisfaction per activity:",
              subtitle: "70",
            ), 
          ]
        ),

      ],
    );
  }
}

Widget statisticBox({@required String title, @required String subtitle, @required dynamic color, Widget child, @required BuildContext context}){
  return ClipRRect(
      borderRadius: BorderRadius.circular(18.0),
      child: Center(
        child: Container(
          padding: EdgeInsets.all(18.0),
          width: getWidth(context) * 0.42,
          height: getWidth(context) * 0.31,
          decoration: BoxDecoration(
            color: color,
          ),
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
                  fontSize: ResponsiveFlutter.of(context).scale(15)
                ),
              ),
              
            ]
          ),
        ),
      ),
  );
}
