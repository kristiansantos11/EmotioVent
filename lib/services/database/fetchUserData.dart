import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emotiovent/models/UserInfo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FetchUserData
{
  User user;
  FetchUserData({this.user});
  
  final CollectionReference db = FirebaseFirestore.instance.collection('Basic Info');

  UserData currentUserData(DocumentSnapshot snapshot)
  {
    print("Passing data info..."); //debugging purposes only
    if(snapshot.exists)
    {
      print("Snapshot exists!"); //debugging purposes only
      print("Current User's email is ${user.email}"); 
      return UserData(
      // # Note: for some reason, hindi ata nakasama sa properties ng "Basic Info" ang username. Hindi ata nainclude sa pag register.
      //username: snapshot.data[''],
      //email: snapshot.data()[''],
      name: snapshot.data()['name'],
      birthdate: snapshot.data()['birthdate'],
      contactnum: snapshot.data()['contactnum'],
      gender: snapshot.data()['gender'],
      profilePictureLink: snapshot.data()['profile_picture'],
      );
    }
    else
    {
      print("Error!"); //debugging purposes only
    }
  }

  Stream<UserData> get info
  {

    return db.doc(user.email).snapshots().map(currentUserData);
  }
}