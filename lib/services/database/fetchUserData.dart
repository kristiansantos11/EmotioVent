import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emotiovent/models/UserInfo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FetchUserData
{
  User user;
  FetchUserData(this.user);
  
  // Don't remove yet  because im still tinkering on a few things.
  //final CollectionReference db = FirebaseFirestore.instance.collection('Basic Info');

  UserData currentUserData(DocumentSnapshot snapshot)
  {
    print("Passing data info..."); //debugging purposes only
    if(snapshot.exists)
    {
      print("Snapshot exists!"); //debugging purposes only
      print("Current User's email is ${user.email}"); 
      return UserData(
        // # ISSUE: for some reason, hindi ata nakasama sa properties ng "Basic Info" ang username. Hindi ata nainclude sa pag register.
        // # ^^ Already fixed.

        // Hindi sinasama si password at email sa firestore due to privacy concerns.
        username: snapshot.data()['username'],
        name: snapshot.data()['name'],
        birthdate: snapshot.data()['birthdate'].toDate(),
        contactnum: snapshot.data()['contactnum'],
        gender: snapshot.data()['gender'],
        profilePictureLink: snapshot.data()['profile_picture'],
      );
    }
    else
    {
      print("Error!"); //debugging purposes only
    }
    return null;
  }

  Stream<UserData> get info
  {
    return FirebaseFirestore.instance.collection('Basic Info')
            .doc(this.user.email)
            .snapshots()
            .map(currentUserData);
  }
}