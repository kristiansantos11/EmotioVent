import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emotiovent/models/EmotionRecord.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FetchEmotionRecord {
  User user;
  FetchEmotionRecord(this.user);
  
  // Don't remove yet  because im still tinkering on a few things.
  //final CollectionReference db = FirebaseFirestore.instance.collection('Basic Info');

  EmotionRecord currentEmotionRecord(QueryDocumentSnapshot snapshot)
  {
    print("Passing data info..."); //debugging purposes only
    if(snapshot.exists)
    {
      print("Snapshot exists!"); //debugging purposes only
      print("Current User's email is ${user.email}"); 
      return EmotionRecord(
        // # TODO: Kelangan pala ifetch lahat ng documents sa loob ng collection na 'emotion_record'
        // # Tapos sa bawat document sa loob ng emotion_record masasave sa isang list (dapat kasama na info sa bawat document)
        // # So di ako sure pano ko iimplement yon ahahahah
        activity: snapshot.data()['activity'],
        activityRate: snapshot.data()['activityRate'],
        emotion: snapshot.data()['emotion'],
        timestamp: DateTime.parse(snapshot.id)
      );
    }
    else
    {
      print("Error!"); //debugging purposes only
    }
    return null;
  }

// # PACHECK.
  Stream<List<EmotionRecord>> get getUserList {
    return FirebaseFirestore.instance.collection('Basic Info')
        .doc(this.user.email)
        .collection('emotion_record')
        .snapshots()
        .map((snapShot) => snapShot.docs
        .map(currentEmotionRecord)
        .toList());
  }
}