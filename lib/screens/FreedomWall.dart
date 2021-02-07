import 'package:emotiovent/models/UserData.dart';
import 'package:emotiovent/models/thewall.dart';
import 'package:emotiovent/services/database/FreedomWallInsert.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:emotiovent/services/database/FreedomWallGetter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class FreedomWall extends StatefulWidget {
  @override
  _FreedomWallState createState() => _FreedomWallState();
}

class _FreedomWallState extends State<FreedomWall> {
  static Map limitData;
  static int limit;
  @override
  
  Widget build(BuildContext context) {
    limitData = ModalRoute.of(context).settings.arguments;
    try{
      print("Current Limit Data: ${limitData["Limit"]}");
      limit = limitData["Limit"];
    }
    catch(e)
    {}
    return WillPopScope( 
      onWillPop: () async => false, 
      child:StreamProvider<List<TheWall>>.value(
        value: FreedomWallGetter(limit: limit).wallData,
        child: WallData()
      )
    );
  }
}

class WallData extends StatefulWidget {
  @override
  _WallDataState createState() => _WallDataState();
}

class _WallDataState extends State<WallData> {
  ScrollController _scrollController = new ScrollController();
  @override
   void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => scrollToBottom());
  }

    void scrollToBottom()
    {
       print("Scroll is: ${_FreedomWallState.limitData["Scroll"]}");
       if(_FreedomWallState.limitData["Scroll"]==true)
       WidgetsBinding.instance.addPostFrameCallback((_) {
            if( _scrollController.hasClients){
                     _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
            }
      });
    }

  static int currentLimit = _FreedomWallState.limit;
  static dynamic wallData;
  String username;
  String textMessage;
  DateTime currentTime;

  Widget build(BuildContext context) {
    UserData userData = context.watch<UserData>();
    print("Current user is ${userData.username}");
    username = userData.username;
    wallData = Provider.of<List<TheWall>>(context); 
    print("Current Number of Messages is $currentLimit");
    var _controller = TextEditingController();
    try{
      return Scaffold(
        appBar: AppBar(
          title: Text("Freedom Wall"),
          automaticallyImplyLeading: false,
        ),
        body: ListView(
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
                      Navigator.pushReplacementNamed(context, "/FreedomWall",arguments: {
                        "Limit" : currentLimit,
                      });
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
            MessageBanner(),
            TextButton.icon(
              onPressed: () {
                setState(() {
                  //_scrollController.jumpTo(_scrollController.position.maxScrollExtent);
                  currentLimit = currentLimit+3;
                  Navigator.pushReplacementNamed(context, "/FreedomWall",arguments: {
                    "Limit" : currentLimit,
                    "Scroll" : true
                  }); 
                });
              },
              icon: Icon(Icons.add),
              label: Text("View More"),),
            TextButton.icon(
              onPressed: () {
                currentLimit = 7; //CHANGE THIS VALUE TO CHANGE THE AMOUNT OF INITIAL MESSAGES TO APPEAR.
                Navigator.pop(context, {});
              },
              icon: Icon(Icons.backspace_outlined),
              label: Text("Return")
              )
          ],
        )
      );
    }
    catch(e)
    {
      return Container(child: Text("Loading..."),);
    }
  }
}

class MessageBanner extends StatefulWidget {
  @override
  _MessageBannerState createState() => _MessageBannerState();
}

class _MessageBannerState extends State<MessageBanner> {
  
  @override
  ScrollController _scrollController = new ScrollController();
  Widget build(BuildContext context) {
    print("(Builder) Current Limit of _WallDataState = ${_WallDataState.currentLimit}");
    print("Users' Message Fetched: ");
    try{
      int ctr = 0;
      dynamic messageData = _WallDataState.wallData;
      for(var x in messageData)
      {
        print("$ctr. ${x.username}");
        ctr++;
      }
      return _WallDataState.wallData != null ? Container(
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