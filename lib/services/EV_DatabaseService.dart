import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:emotiovent/models/user.dart';

class DatabaseService{
  final String uid;

  //Constructor
  DatabaseService({this.uid});

  final CollectionReference basicInfo = FirebaseFirestore.instance.collection('Basic Info');

  Future createData(String username, String name, DateTime birthdate, int contactNumber, String gender) async {
    {
      try
      {
        DocumentReference ref = await basicInfo.add({
          "username" : username,
          "name" : name,
          "birthdate" : birthdate,
          "contactNumber" : contactNumber,
          "gender" : gender,
        });
        print(ref.id);
      }
      catch(e)
      {
        print("Failed!");
      }
    }
  }

}