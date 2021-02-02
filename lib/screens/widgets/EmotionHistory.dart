import 'package:emotiovent/models/EmotionRecord.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmotionHistory extends StatefulWidget {
  @override
  _EmotionHistoryState createState() => _EmotionHistoryState();
}

class _EmotionHistoryState extends State<EmotionHistory> {
  int monthlyCount;


  @override
  Widget build(BuildContext context) {
    List<EmotionRecord> emotionRecord = context.watch<List<EmotionRecord>>();
    if(emotionRecord == null){
      return Center(child: CircularProgressIndicator());
    }

    emotionRecord.forEach(
      (record){
        
      }
    );

    return ListView.builder(
      itemCount: emotionRecord.length,
      itemBuilder: (_, int index) {
        return Padding(
          padding: EdgeInsets.all(10.0),
          child: Card(
            elevation: 2,
            child: ClipPath(
              child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                      border: Border(right: BorderSide(color: Colors.green, width: 5))),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(12.0),
                        isThreeLine: true,
                        tileColor: Colors.grey[200],
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
                        leading: CircleAvatar(
                          backgroundColor: Colors.black
                        ),
                        title: Text(
                          emotionRecord[index].activity,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: 'Proxima Nova',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        subtitle: Text.rich(
                          TextSpan(
                            text: "Done at: " + emotionRecord[index].timestamp.day.toString() + 
                                  "/" + emotionRecord[index].timestamp.month.toString() + 
                                  "/" + emotionRecord[index].timestamp.year.toString() +
                                  " @ " + emotionRecord[index].timestamp.hour.toString() +
                                  ":" + emotionRecord[index].timestamp.minute.toString() + 
                                  "\n",
                            style: TextStyle(
                              fontFamily: 'Proxima Nova',
                              fontSize: 13,
                            ),
                            children: <InlineSpan>[
                              TextSpan(text: "Emotion: " + emotionRecord[index].emotion+"\n", style: TextStyle(fontFamily: 'Proxima Nova')),
                              TextSpan(text: "Your rating for this activity: " + emotionRecord[index].activityRate.toString()+"\n", style: TextStyle(fontFamily: 'Proxima Nova'))
                            ]
                          ),
                        ),
                      ),
                    ),
              clipper: ShapeBorderClipper(shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3))),
                      ),
          )
        );
      },
    );
  }
}
