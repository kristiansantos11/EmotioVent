import 'package:cloud_firestore/cloud_firestore.dart';

class FreedomWallInsert
{
    final CollectionReference brews = FirebaseFirestore.instance.collection("Freedom Wall");

    Future createData(String username,String message, DateTime time) async 
    {
        brews.add({
        "Username" : username,
        "Message" : message,
        "Time" : time,
        });
    }
}