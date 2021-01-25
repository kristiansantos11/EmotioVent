
import 'package:emotiovent/screens/EV_ChooseEmotionScreen.dart';
import 'package:emotiovent/services/EV_SizeGetter.dart';
import 'package:emotiovent/screens/clipper/CustomShapeClipper.dart';
import 'package:emotiovent/screens/widgets/ProfileCard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/EV_AuthService.dart';
import 'package:emotiovent/models/UserInfo.dart';


class EVMainMenu extends StatefulWidget {

  @override
  _EVMainMenuState createState() => _EVMainMenuState();
}

class _EVMainMenuState extends State<EVMainMenu> {

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _signOut(){
    context.read<AuthenticationService>().signOut();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<User>();
    final userinfo = Provider.of<UserData>(context);  
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
                      _signOut();
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

                  Padding(
                    padding: EdgeInsets.fromLTRB(getWidth(context) / 35, 0, getWidth(context) / 35, 0),
                    child: Container(
                      width: 30,
                      height: 30,
                      child: Image(
                        image: AssetImage('assets/img/emotiovent_icon_final.png')
                      ),
                    ),
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

            body: Stack(
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
                          child: ProfileCard(
                            user: user,
                          ),
                        )
                      ),

                      // Calendar widget.
                      Flexible(
                        flex: 8,
                        child: Container(

                        )
                      )

                    ]
                  ),
                ),

              ],
            ),
          ),
      );
  }
}