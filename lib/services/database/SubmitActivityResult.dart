import 'package:emotiovent/models/EmotionRecord.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

class SubmitActivityResult{
  Future<void> submit({@required User user, @required EmotionRecord record}) async {
    await FirebaseFirestore.instance.collection('Basic Info')
          .doc(user.email)
          .collection('emotion_record')
          .doc(record.timestamp.toString())
          .set(record.getRecord(), SetOptions(merge: true));
  }
}