import 'package:emotiovent/models/UserData.dart';
import 'package:emotiovent/models/TheWall.dart';
import 'package:emotiovent/services/EV_SizeGetter.dart';
import 'package:emotiovent/services/database/FreedomWallInsert.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:emotiovent/services/database/FreedomWallGetter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

class FreedomWall extends StatefulWidget {
  const FreedomWall({Key key}) : super(key: key);

  static int limit = 5;

  @override
  _FreedomWallState createState() => _FreedomWallState();
}

class _FreedomWallState extends State<FreedomWall> {
  bool scroll = true;
  String username;
  String textMessage;
  DateTime currentTime;

  UniqueKey uniqueKey = new UniqueKey();
  ScrollController _scrollController = new ScrollController();

  @override
   void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => scrollToBottom());
  }

  void scrollToBottom()
  {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print("scrolling to bottom.");
      if( _scrollController.hasClients){
        print("Scrolled to bottom!!!!!!!!");
                _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    UserData userData = context.watch<UserData>();

    if (userData == null){
      return Center(child: CircularProgressIndicator());
    }
    
    print("Current user is ${userData.username}");
    username = userData.username;
    print("Current Number of Messages is ${FreedomWall.limit}");
    var _controller = TextEditingController();
    try{
      return Container(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              Container(
                decoration: BoxDecoration(
                  color: Color(0xffff8383),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(18.0),
                    bottomRight: Radius.circular(18.0),
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                        child: TextFormField(
                          controller: _controller,
                          onChanged: (text) {
                            print("Current text is: $text");
                            textMessage = text;
                          },
                          cursorColor: Color(0xfff77272),
                                            style: TextStyle(
                                                fontFamily: 'Proxima Nova',
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.bold,
                                                fontSize:
                                                    ResponsiveFlutter.of(
                                                            context)
                                                        .scale(18),
                                                color: Color(0xffff8383),
                                            ),
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.fromLTRB(
                                                      20, 10, 20, 10),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.all(
                                                  Radius.circular(100.0),
                                                ),
                                                borderSide: BorderSide.none,
                                              ),
                                              filled: true,
                                              hintStyle: TextStyle(
                                                  color: Colors.red[300]),
                                              hintText: "Write anything here!",
                                              fillColor: Colors.white,
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
                                _controller.clear();
                                print("The text is $textMessage");
                                DateTime now = DateTime.now();
                                currentTime = now;
                                //put to database ung text
                                FreedomWallInsert().createData(username,textMessage,currentTime);
                              },
                              icon: Icon(Icons.textsms_rounded, color: Colors.white),
                              label: Text("Write", style: TextStyle(color: Colors.white, fontFamily: 'Proxima Nova'))
                            )
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 20, 0),
                            child: TextButton.icon(
                              onPressed: () {
                                _controller.clear();
                              },
                              icon: Icon(Icons.clear_rounded, color: Colors.white),
                              label: Text("Clear", style: TextStyle(color: Colors.white, fontFamily: 'Proxima Nova'))
                            )
                          ),
                        ]
                      ),

                    ],
                  ),
                ),
              ),

              


                Expanded(
                  child: ListView(
                    controller: _scrollController,
                    children: [

                      Posts(
                        key: uniqueKey,
                      ),

                      TextButton.icon(
                        onPressed: () {
                          setState(() {
                            //_scrollController.jumpTo(_scrollController.position.maxScrollExtent);
                            FreedomWall.limit = FreedomWall.limit + 3;
                            uniqueKey = UniqueKey();
                            scrollToBottom();
                          });
                        },
                        icon: Icon(Icons.add, color: Color(0xffff8383)),
                        label: Text("View More", style: TextStyle(
                          color: Color(0xffff8383),
                          fontFamily: 'Proxima Nova'
                        )),
                      ),

                    ],
                  ),
                ),




            ],
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
  Posts({Key key}) : super(key: key);

  @override
  _PostsState createState() => _PostsState();
}

class _PostsState extends State<Posts> {

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<TheWall>>.value(
      value: FreedomWallGetter(limit: FreedomWall.limit).wallData,
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
  ScrollController scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    List<TheWall> wallData = context.watch<List<TheWall>>();
    print("(Builder) Current Limit of _WallDataState = ${FreedomWall.limit}");
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
      return wallData != null ? 
        Container(
          child: ListView.builder(
            controller: scrollController,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: ctr,
            itemBuilder: (context,index){
              return Padding(
                padding: const EdgeInsets.fromLTRB(4, 2, 4, 2),
                child: Card(
                  color: Color(0xffff8383),
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                  child: Container(
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.white,
                      ),
                      title: Text(
                        messageData[index].username,
                        style: TextStyle(
                          fontFamily: 'Proxima Nova',
                          fontWeight: FontWeight.w700,
                          fontSize: ResponsiveFlutter.of(context).scale(20.0),
                          color: Colors.white,
                        ),
                      ),
                      subtitle: Text(
                        "${messageData[index].message}",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Proxima Nova',
                        ),
                        ),
                    ),
                  ),
                ),
              );
            },
          )
        ) : 
      Container();
    }
    catch(e)
    {
      return Container();
    }
  }
}