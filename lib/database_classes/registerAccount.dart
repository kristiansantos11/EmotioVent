import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterAccount
{
  final FirebaseAuth auth = FirebaseAuth.instance;
  final CollectionReference basicInfo = FirebaseFirestore.instance.collection('Basic Info');

  Future register(String email,String password,String username,String name,DateTime birthday,String contactnum,String gender) async
  {
    try
    {
      // checks if the username exists
      DocumentSnapshot snapshot = await basicInfo.doc("$username").get();
      if(!snapshot.exists)
      {
        await auth.createUserWithEmailAndPassword(email: email, password: password);
        await basicInfo.doc("$username").set({
        "name" : name,
        "birthdate" : birthday,
        "contactNumber" : contactnum,
        "gender" : gender,
      });
        return null;
      }
      else
      {
        return("Username exists!");
      }
    }
    catch(e)
    {
      return("Please check your email!");
    }
  }
}