import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emotiovent/models/UserData.dart';
import 'package:emotiovent/services/cloud_storage/CloudStorage.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Database
{
  Map<String, dynamic> userInfo;
  UploadTask result;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final CollectionReference basicInfo = FirebaseFirestore.instance.collection('Basic Info');

  Future register(UserData user) async
  {
    try
    {
      await auth.createUserWithEmailAndPassword(email: user.email, password: user.password);
      await CloudStorage().uploadProfilePicture(
        file: user.profilePicture,
        email: user.email,
        def: true,
      );
      user.profilePictureLink = await CloudStorage().getProfilePictureLink(email: user.email);
      await basicInfo.doc("${user.email}").set(user.returnUserData());
      return null;

    }
    catch(e)
    {
      return(e.toString());
    }
  }

  Future updateData() {
    return null;
  }
}