import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emotiovent/services/FirestoreService.dart';
import 'package:meta/meta.dart';

class UserData
{
  // TODO: Check if it's possible to bind all the user data requirements into this class.
  String email;
  String password;
  String username;
  String name;
  DateTime birthdate;
  String contactnum;
  String gender;
  File profilePicture;
  String profilePictureLink;

  UserData({
    this.email, 
    this.password, 
    this.username, 
    this.name, 
    this.birthdate,
    this.contactnum, 
    this.gender,
    this.profilePicture,
    this.profilePictureLink,
  });

  UserData fetchData(DocumentSnapshot snapshot){
    return UserData(
      username : snapshot.data()['username'],
      name : snapshot.data()['name'],
      birthdate : snapshot.data()['birthdate'],
      contactnum : snapshot.data()['contactnum'],
      gender : snapshot.data()['gender'],
      profilePictureLink : snapshot.data()['profile_picture'],
    );
  }

  Map<String, dynamic> returnUserData(){
    return {
      'username' : username,
      'name' : name,
      'birthdate' : birthdate,
      'contactnum' : contactnum,
      'gender' : gender,
      'profile_picture' : profilePictureLink,
    };
  }

  
}