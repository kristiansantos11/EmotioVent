import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emotiovent/models/ScreenArguments.dart';
import 'package:emotiovent/models/UserInfo.dart';
import 'package:emotiovent/screens/EV_ViewProfilePicture.dart';
import 'package:emotiovent/services/EV_SizeGetter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class ProfileCard extends StatefulWidget {
  final User user;

  const ProfileCard({Key key, @required this.user}) : super(key: key);

  @override
  _ProfileCardState createState() => _ProfileCardState(user: user);
}

class _ProfileCardState extends State<ProfileCard> {
  final User user;

  _ProfileCardState({@required this.user});

  @override
  Widget build(BuildContext context) {
    UserData userData = context.watch<UserData>();
    print(userData.name);

    return Stack(
      children: <Widget>[

        Positioned.fill(
          child: Container(
          )
        ),

        Positioned(
          top: getHeight(context) * 0.115,
          left: getWidth(context) * 0.06,
          child: Container(
            width: getWidth(context) / 1.3,
            height: getHeight(context) / 3.5,
            decoration: BoxDecoration(
              color: Color(0xffffe9da),
              borderRadius: BorderRadius.circular(30)
            ),
          )
        ),

        Positioned(
          top: getHeight(context) * 0.085,
          left: getWidth(context) * 0.11,
          child: Container(
            width: getWidth(context) / 1.3,
            height: getHeight(context) / 3.5,
            decoration: BoxDecoration(
              color: Color(0xffffe0cb),
              borderRadius: BorderRadius.circular(30)
            ),
          )
        ),

        Positioned(
          top: getHeight(context) * 0.055,
          left: getWidth(context) * 0.16,
          child: Container(
            width: getWidth(context) / 1.3,
            height: getHeight(context) / 3.5,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Color(0xfff6afaf), width: 0.5)
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                        text: "Name\n",
                        style: TextStyle(
                          fontFamily: 'Proxima Nova',
                          fontSize: 25,
                          fontWeight: FontWeight.w800,
                          color: Colors.grey[800],
                        ),
                        children: <InlineSpan>[
                          TextSpan(
                            text: "Gender: M",
                            style: TextStyle(
                              fontFamily: 'Proxima Nova',
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal,
                              color: Colors.grey[700],
                            )
                          ),
                        ]
                      ),
                    ),
                  ),

                  Align(
                    alignment: Alignment.topRight,
                    child: Hero(
                      tag: 'profile_picture',
                      child: GestureDetector(
                        onTap: (){
                          Navigator.of(context).pushNamed(EVViewProfilePicture.routeName, arguments: ScreenArguments(user: user));
                        },
                        child: Container(
                          width: 100,
                          height: 100,
                          child: Image(image: NetworkImage(userData.profilePictureLink)),
                          ),
                        ),
                      ),
                    ),

                ],
              ),
            ),
          )
        ),

      ],
    );
  }
}

Widget profileCard({@required BuildContext context, @required User user}){
  
}

/*
child: StreamBuilder(
                            stream: FirebaseFirestore.instance.collection('Basic Info').doc(user.email).snapshots(),
                            builder: (context, snapshot){
                              print(user.email);
                              print(snapshot.data.toString());
                              print(snapshot.connectionState);
                              if(!snapshot.hasData){
                                return Container(
                                  alignment: Alignment.center,
                                  child: CircularProgressIndicator()
                                );
                              } else {
                                return Image(
                                  image: NetworkImage(snapshot.data['profile_picture'])
                                );
                              }
                            }
                          ),

*/