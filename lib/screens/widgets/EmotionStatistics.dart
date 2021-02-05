import 'package:emotiovent/models/EmotionRecord.dart';
import 'package:emotiovent/services/EV_SizeGetter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

class EmotionStatistics extends StatefulWidget {
  @override
  _EmotionStatisticsState createState() => _EmotionStatisticsState();
}

class _EmotionStatisticsState extends State<EmotionStatistics> {
  
  @override
  Widget build(BuildContext context) {
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
    if (emotionCounters != null && emotionCounters.isNotEmpty){
      emotionCounters.sort((a, b) => a['counter'].compareTo(b['counter']));
      mostFeltEmotion = emotionCounters.last['emotion'];
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[

        // # TODO: Pakibago yung color property sa loob ng bawat statisticBox depende sa color palette ng UI.

        Container(
          height: getHeight(context) / 13,
          color: Colors.red,
          child: ButtonBar(
            alignment: MainAxisAlignment.spaceEvenly,
            buttonPadding: EdgeInsets.all(8.0),
            children: <Widget>[
              TextButton(
                onPressed: () {},
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0))),
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.cyan[300]),
                ),
                child: Text(
                  "Today",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            statisticBox(
              context: context,
              color: Colors.red, // Pabago
              title: "Most felt emotion:",
              subtitle: mostFeltEmotion
            ),
            statisticBox(
              context: context,
              color: Colors.deepOrange, // Pabago
              title: "Text",
              subtitle: "Text",
            ),
          ]
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            statisticBox(
              context: context,
              color: Colors.blue, // Pabago
              title: "Text",
              subtitle: "Text",
            ),
            statisticBox(
              context: context,
              color: Colors.lightGreen, // Pabago
              title: "Text",
              subtitle: "Text",
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
          height: getWidth(context) * 0.30,
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
                  color: Colors.white,
                  letterSpacing: -0.5,
                  fontFamily: 'Proxima Nova',
                  fontWeight: FontWeight.w700,
                  fontSize: ResponsiveFlutter.of(context).scale(20),
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  letterSpacing: -0.5,
                  color: Colors.grey[200],
                  fontFamily: 'Proxima Nova',
                  fontSize: ResponsiveFlutter.of(context).scale(15)
                ),
              )
            ]
          ),
        ),
      ),
  );
}
