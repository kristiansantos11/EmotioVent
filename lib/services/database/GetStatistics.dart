import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:emotiovent/models/UserData.dart';
import 'package:provider/provider.dart';

class GetStatistics
{
  UserData userData;
  GetStatistics(this.userData);
  
  CollectionReference cr = FirebaseFirestore.instance.collection('Basic Info');
  
  String activity;
  int activityRate;
  String emotion;
  Timestamp ts;

  Future GetData() async
  {
    QuerySnapshot snapshot = await cr.doc(userData.email).collection("emotion_record").get();

    snapshot.docs.map((e){
      activity = e.data()["activity"];
      activityRate = e.data()["activityRate"];
      emotion = e.data()["emotion"];
      ts = e.data()["timestamp"];

      print(activity);
      print(activityRate);
      print(emotion);
      print(ts);
    }).toList();
  }
}