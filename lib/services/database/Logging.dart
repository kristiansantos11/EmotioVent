import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class Logging
{
  User firebaseUser;
  Logging(this.firebaseUser);

  CollectionReference cr = FirebaseFirestore.instance.collection('Basic Info');

  Future Log() async
  {
    print("Attempting to log!");
    DateTime currentDate = new DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(currentDate);

    cr.doc(firebaseUser.email).collection("Log").doc(formattedDate).set(({
      "Timestamp" : currentDate
    }));
  }
}