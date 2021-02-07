import 'package:emotiovent/models/UserData.dart';
import 'package:emotiovent/models/TheWall.dart';
import 'package:emotiovent/services/database/FreedomWallInsert.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:emotiovent/services/database/FreedomWallGetter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class WallData extends StatefulWidget {
  const WallData({Key key}) : super(key: key);

  static int limit = 7;

  @override
  _WallDataState createState() => _WallDataState();
}

class _WallDataState extends State<WallData> {
  bool scroll = true;
  ScrollController _scrollController = new ScrollController();
  @override
   void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => scrollToBottom());
  }

  void scrollToBottom()
  {
      print("Scroll is: $scroll");
      WidgetsBinding.instance.addPostFrameCallback((_) {
          if( _scrollController.hasClients){
            _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
          }
    });
  }

  String username;
  String textMessage;
  DateTime currentTime;

  UniqueKey uniqueKey = new UniqueKey();

  @override
  Widget build(BuildContext context) {
    UserData userData = context.watch<UserData>();

    if (userData == null){
      return Center(child: CircularProgressIndicator());
    }
    
    print("Current user is ${userData.username}");
    username = userData.username;
    print("Current Number of Messages is ${WallData.limit}");
    var _controller = TextEditingController();
    try{
      return Center(
        child: Container(
          child: ListView(
              controller: _scrollController,
              children: [

                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: TextFormField(
                    controller: _controller,
                    onChanged: (text) {
                      print("Current text is: $text");
                      textMessage = text;
                    },
                    decoration: InputDecoration(
                      labelText: "Write Anything Here!"
                    ),
                    style: TextStyle(
                      fontSize: 20
                    ),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: TextButton.icon(
                        onPressed: () {
                          print("The text is $textMessage");
                          DateTime now = DateTime.now();
                          currentTime = now;
                          //put to database ung text
                          FreedomWallInsert().createData(username,textMessage,currentTime);
                        },
                        icon: Icon(Icons.textsms_rounded),
                        label: Text("Write")
                      )
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: TextButton.icon(
                        onPressed: () {
                          _controller.clear();
                        },
                        icon: Icon(Icons.clear_rounded),
                        label: Text("Clear")
                      )
                    ),
                  ]),
                Posts(
                  key: uniqueKey,
                ),
                TextButton.icon(
                  onPressed: () {
                    setState(() {
                      //_scrollController.jumpTo(_scrollController.position.maxScrollExtent);
                      WallData.limit = WallData.limit + 3;
                      uniqueKey = UniqueKey();
                    });
                  },
                  icon: Icon(Icons.add),
                  label: Text("View More"),
                ),

              ],
            ),
        ),
      );
    }
    catch(e)
    {
      return Container(child: Text("Loading..."),);
    }
  }
}

class Posts extends StatefulWidget {
  const Posts({Key key}) : super(key: key);

  @override
  _PostsState createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<TheWall>>.value(
      value: FreedomWallGetter(limit: WallData.limit).wallData,
      child: MessageBanner(),
    );
  }
}

class MessageBanner extends StatefulWidget {
  const MessageBanner({Key key}) : super(key: key);

  @override
  _MessageBannerState createState() => _MessageBannerState();
}

class _MessageBannerState extends State<MessageBanner> {
  ScrollController _scrollController = new ScrollController();
  
  @override
  Widget build(BuildContext context) {
    List<TheWall> wallData = context.watch<List<TheWall>>();
    print("(Builder) Current Limit of _WallDataState = ${WallData.limit}");
    print("Users' Message Fetched: ");
    if (wallData == null){
      return Center(child: CircularProgressIndicator());
    }
    try{
      int ctr = 0;
      dynamic messageData = wallData;
      for(var x in messageData)
      {
        print("$ctr. ${x.username}");
        ctr++;
      }
      return wallData != null ? Container(
        child: ListView.builder(
          controller: _scrollController,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: ctr,
          itemBuilder: (context,index){
            return Padding(
              padding: const EdgeInsets.all(8),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.black87,
                ),
                title: Text(
                  messageData[index].username
                ),
                subtitle: Text(
                  "${messageData[index].message}"
                  ),
              ),
            );
          },
        )
      ):Container();
    }
    catch(e)
    {
      return Container();
    }
  }
}