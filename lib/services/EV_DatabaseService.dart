import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:emotiovent/models/User.dart';

class DatabaseService{
  final String uid;

  //Constructor
  DatabaseService({this.uid});

  final CollectionReference basicInfo = FirebaseFirestore.instance.collection('Basic Info');

  // temporary ko muna iniba ung mga data types para makapasok ung data
  Future createData(dynamic username, dynamic name, dynamic birthdate, dynamic contactNumber, dynamic gender) async {
    {
      print("ATTEMPTING TO CREATE DATA!!!");
      try
      {
        return await basicInfo.doc("test123").set({
          "username" : username,
          "name" : name,
          "birthdate" : birthdate,
          "contactNumber" : contactNumber,
          "gender" : gender,
        });
      }
      catch(e)
      {
        print("Failed!");
      }
    }
  }

}