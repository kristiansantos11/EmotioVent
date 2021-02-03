import 'package:emotiovent/models/UserInfo.dart';
import 'package:emotiovent/screens/EV_ViewProfilePicture.dart';
import 'package:emotiovent/services/EV_SizeGetter.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class ProfileCard extends StatefulWidget {

  @override
  _ProfileCardState createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {

  @override
  Widget build(BuildContext context) {
    UserData userInfo = context.watch<UserData>();

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
              padding: const EdgeInsets.all(13.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.topLeft,
                      child: RichText(
                        textAlign: TextAlign.left,
                        text: TextSpan(
                          text: "${userInfo.username}\n",
                          style: TextStyle(
                            height: 1.3,
                            fontFamily: 'Proxima Nova',
                            fontSize: getWidth(context) * 0.06,
                            fontWeight: FontWeight.w800,
                            color: Colors.grey[800],
                          ),
                          children: <InlineSpan>[
                            TextSpan(
                              text: "Name: ${userInfo.name}\n",
                              style: TextStyle(
                                fontFamily: 'Proxima Nova',
                                fontSize: getWidth(context) * 0.04,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                                color: Colors.grey[700],
                              )
                            ),
                            TextSpan(
                              text: "Gender: ${userInfo.gender}\n",
                              style: TextStyle(
                                fontFamily: 'Proxima Nova',
                                fontSize: getWidth(context) * 0.04,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                                color: Colors.grey[700],
                              )
                            ),
                            TextSpan(
                              text: "Birthday: ${userInfo.birthdate.month}/${userInfo.birthdate.day}/${userInfo.birthdate.year}\n",
                              style: TextStyle(
                                fontFamily: 'Proxima Nova',
                                fontSize: getWidth(context) * 0.04,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                                color: Colors.grey[700],
                              )
                            ),
                            TextSpan(
                              text: "Contact: ${userInfo.contactnum}\n",
                              style: TextStyle(
                                fontFamily: 'Proxima Nova',
                                fontSize: getWidth(context) * 0.04,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                                color: Colors.grey[700],
                              )
                            ),
                          ]
                        ),
                      ),
                    ),
                  ),

                  Align(
                    alignment: Alignment.topRight,
                    child: Hero(
                      tag: 'profile_picture',
                      child: GestureDetector(
                        onTap: (){
                          Navigator.of(context).pushNamed(EVViewProfilePicture.routeName);
                        },
                        child: Container(
                          width: 100,
                          height: 100,
                          // This is where the image goes.
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            // Reason: I moved the streamprovider to MultiProvider (finally i get it now)
                            // However, it is not as responsive therefore there is a split second where userData returns null and then fetches data after.
                            child: (userInfo == null) ? Image(image:AssetImage('assets/img/default_profile_picture.jpg')) : Image(image:NetworkImage(userInfo.profilePictureLink))
                          ),
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
