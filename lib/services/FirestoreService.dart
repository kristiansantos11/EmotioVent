import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:emotiovent/models/UserInfo.dart';

class FirestoreService {

  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Stream<UserData> getUser(User user) {
    try{
      return _firebaseFirestore.collection('Basic Info')
            .doc(user.email)
            .snapshots()
            .map((snapshot) => UserData.fetchData(snapshot.data()));
    } catch (e) {
      print(e);
    }
  }
}