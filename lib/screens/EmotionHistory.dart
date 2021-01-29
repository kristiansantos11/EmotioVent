import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:emotiovent/models/UserInfo.dart';

class EmotionHistory extends StatefulWidget {
  @override
  _EmotionHistoryState createState() => _EmotionHistoryState();
}

class _EmotionHistoryState extends State<EmotionHistory> {
  @override
  Widget build(BuildContext context) {
    UserData userData = context.watch<UserData>();
    return Container(
      child: Center(child: Text("CONTACTS GO HERE!"))
    );
  }
}