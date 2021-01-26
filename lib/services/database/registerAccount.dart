import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emotiovent/models/UserInfo.dart';
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
      userInfo = user.returnUserData();
      print("Checking for username...");

      // # ISSUE: Hindi gagana to kapag ang rules na naka set sa firestore ay mga authenticated users lang ang makakapag READ access.
      // # I had to make the firestore database public para mkapag read ito kahit wala pang user na nakalogin.
      DocumentSnapshot snapshot = await basicInfo.doc("${user.email}").get();
      print("Username checking done!");
      if(!snapshot.exists)
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
      else
      {
        return("Email exists!");
      }
    }
    catch(e)
    {
      return("Please check your email!: ${e.toString()}");
    }
  }

  Future updateData() {
    return null;
  }
}