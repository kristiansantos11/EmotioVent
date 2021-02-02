
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emotiovent/screens/EV_ChooseEmotionScreen.dart';
import 'package:emotiovent/screens/EV_InitialScreen.dart';
import 'package:emotiovent/screens/AppSettings.dart';
import 'package:emotiovent/services/EV_SizeGetter.dart';
import 'package:emotiovent/screens/clipper/CustomShapeClipper.dart';
import 'package:emotiovent/screens/widgets/ProfileCard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';
import '../services/EV_AuthService.dart';
import 'package:emotiovent/models/UserInfo.dart';

import 'widgets/EmotionHistory.dart';


class EVMainMenu extends StatefulWidget {

  @override
  _EVMainMenuState createState() => _EVMainMenuState();
}

class _EVMainMenuState extends State<EVMainMenu> {

  PageController pageController;
  int currentPage;

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _signOut(BuildContext context) async {
    await context.read<AuthenticationService>().signOut().then((String successMsg){
      print(successMsg);
      Phoenix.rebirth(context);
    });
  }
  
  @override
  void initState(){
    super.initState();
    pageController = PageController(initialPage: 0);
    setState(() {
      currentPage = 0;
    });
  }

  @override
  Widget build(BuildContext context) {

    // FOR DEBUG PURPOSES. DO NOT DELETE.
    final userinfo = context.watch<UserData>();

    if (userinfo == null){
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    // # lahat ng data ng user is nasa userinfo
    // # access the data by:
    // # userinfo.name, userinfo.gender, userinfo.profilePictureLink

    return WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            key: _scaffoldKey,

            // Drawer will not be used.
            // PageView should be used in navigating to trusted contacts, emotion calendar, freedom board, etc.
            drawer: Drawer(
              child: ListView(
                children: <Widget>[
                  DrawerHeader(
                    child: Align(
                      alignment: Alignment.bottomLeft, 
                      child: Text(
                        "emotiovent", 
                        style: TextStyle(
                          color: Colors.white, 
                          fontFamily: 'Nexa', 
                          fontWeight: FontWeight.w700,
                          fontSize: 40,
                        )
                      )
                    ),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/img/StartScreenBG.jpg')
                      )
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text("Settings"),
                    onTap: (){

                    }
                  ),
                  ListTile(
                    leading: Icon(Icons.contacts),
                    title: Text("Trusted Contacts"),
                    onTap: (){

                    }
                  ),
                  ListTile(
                    leading: Icon(Icons.message_rounded),
                    title: Text("Messages"),
                    onTap: (){

                    }
                  ),
                  ListTile(
                    leading: Icon(Icons.logout),
                    title: Text("Logout"),
                    onTap: (){
                      _signOut(context);
                    }
                  ),
                  /// #DON'T DELETE. DEBUGGING PURPOSES ONLY 
                  ListTile(
                    leading: Icon(Icons.bug_report),
                    title: Text("Debug"),
                    onTap: (){
                      //checks the streamed data by fetchUserData.dart
                      print("Fetched data: ${userinfo.name}");
                      print("Fetched data: ${userinfo.gender}");
                    }
                  ),
                ]
              )
            ),

            // Change UI for BottomAppBar.
            // This is where the icons for the different page views should be found
            // Ask rigel where to place the button icons and how they work and how they should animate (?)
            bottomNavigationBar: BottomAppBar(
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[

                  Padding(
                    padding: EdgeInsets.fromLTRB(getWidth(context) / 35, 0, 0, 0),
                    child: IconButton(
                      iconSize: 50,
                      icon: Icon(Icons.menu),
                      onPressed: (){
                        _scaffoldKey.currentState.openDrawer();
                      }
                    ),
                  ),

                  ElevatedButton(
                    onPressed: (){pageController.animateToPage(0, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);},
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(CircleBorder()),
                      backgroundColor: MaterialStateProperty.all((currentPage == 0) ? Colors.pink : Colors.grey)
                    ),
                    child: Icon(Icons.home_filled, color: Colors.white)
                  ),

                  ElevatedButton(
                    onPressed: (){pageController.animateToPage(1, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);},
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(CircleBorder()),
                      backgroundColor: MaterialStateProperty.all((currentPage == 1) ? Colors.pink : Colors.grey)
                    ),
                    child: Icon(Icons.contacts, color: Colors.white)
                  ),

                  ElevatedButton(
                    onPressed: (){pageController.animateToPage(2, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);},
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(CircleBorder()),
                      backgroundColor: MaterialStateProperty.all((currentPage == 2) ? Colors.pink : Colors.grey)
                    ),
                    child: Icon(Icons.settings, color: Colors.white)
                  ),

                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, getWidth(context) / 35, 0),
                    child: Hero(
                      tag: 'register',
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.red[300]),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0))
                          ),
                        ),
                        child: Text("VENT", style: TextStyle(color: Colors.white, fontFamily: 'Nexa', fontWeight: FontWeight.w700)),
                        onPressed: (){
                          Navigator.of(context).pushNamed(EVChooseEmotionScreen.routeName);
                        }
                      ),
                    ),
                  ),
              
                ],
              )
            ),

            body: PageView(
              onPageChanged: (page){
                setState(() {
                  currentPage = page;
                });
              },
              controller: pageController,
              physics: NeverScrollableScrollPhysics(),
              children: [

                Stack(
                  children: <Widget>[

                    Container(
                      decoration: BoxDecoration(
                        //image: 'background_image_here'
                      ),
                    ),

                    // This ClipPath will be removed. I was only testing custom shapes :)
                    // The above Container widget will contain the background.
                    // The background should be high definition enough for maximum compatibility with small and large phone screens
                    ClipPath(
                      clipper: CustomShapeClipper(),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [Color(0xfff6afaf), Color(0xfff6afaf)]),
                        ),
                        height: getHeight(context) / 2,
                        width: getWidth(context),
                      ),
                    ),

                    SafeArea(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[

                          // Profile Card widget.
                          Flexible(
                            flex: 7,
                            child: Container(
                              constraints: BoxConstraints.expand(),
                              alignment: Alignment.center,
                              child: ProfileCard(),
                            )
                          ),

                          // Calendar widget.
                          Flexible(
                            flex: 8,
                            child: EmotionHistory()
                          )

                        ]
                      ),
                    )

                  ],
                ),

                AppSettings()

              ],
            ),
          ),
      );
  }
}