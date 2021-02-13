import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emotiovent/models/TheWall.dart';

class FreedomWallGetter
{
  int limit;
  FreedomWallGetter({this.limit = 5});

  final CollectionReference freedomwall = FirebaseFirestore.instance.collection("Freedom Wall");

  List<TheWall> wall(QuerySnapshot snapshot)
  {
    return snapshot.docs.map((doc){
      return TheWall(
        username: doc.data()["Username"] ?? '',
        message: doc.data()["Message"] ?? '',
        time: doc.data()["Time"] ?? ''
      );
    }).toList();
  }

  Stream<List<TheWall>> get wallData {
    return freedomwall.limit(this.limit).orderBy("Time",descending: true).snapshots().map(wall);
  }
}