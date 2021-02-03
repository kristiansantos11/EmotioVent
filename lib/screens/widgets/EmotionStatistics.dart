import 'package:emotiovent/models/EmotionRecord.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

    return Column(
      children: <Widget>[

        Row(
          children: <Widget>[
            Container(
              color: Colors.blue,
            ),
            Container(color: Colors.red)
          ]
        ),

        Row(
          children: <Widget>[
            Container(color: Colors.yellow),
            Container(color: Colors.orange)
          ]
        ),

      ],
    );
  }
}
