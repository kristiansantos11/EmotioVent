import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:emotiovent/models/UserInfo.dart';

class FirestoreService {

  User user;
  FirestoreService({this.user});

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  UserData userData;

  Stream<UserData> get getUser {
    return _firebaseFirestore.collection('Basic Info')
      .doc(user.email)
      .snapshots()
      .map(UserData().fetchData);
  }
}