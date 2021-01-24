import 'package:emotiovent/screens/EV_InitialScreen.dart';
import 'package:emotiovent/screens/widgets/NewProfilePictureDialog.dart';
import 'package:emotiovent/services/EV_SizeGetter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class AskProfilePicture extends StatefulWidget {
  static const routeName = '/askProfilePicture';
  @override
  _AskProfilePictureState createState() => _AskProfilePictureState();
}

class _AskProfilePictureState extends State<AskProfilePicture> {

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    return Scaffold(
      body: Stack(
        children: <Widget>[

          Container(
            color: Colors.white,
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Add a profile picture!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Proxima Nova',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w700,
                          fontSize: getWidth(context) * 0.09,
                        ),
                      ),

                      SizedBox(
                        height: getHeight(context) * 0.03,
                      ),

                      Text(
                        "It can be your real face or a representation of you, so people can uniquely identify you visually!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Proxima Nova',
                          fontStyle: FontStyle.normal,
                          fontSize: getWidth(context) * 0.05,
                        ),
                      ),
                    ],
                  ),

                  GestureDetector(
                    child: Container(
                      width: getWidth(context) * 0.35,
                      height: getWidth(context) * 0.35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(color: Colors.black, width: 2.0),
                      ),
                      child: Center(
                        child: Icon(Icons.add, size: getWidth(context)*0.25)
                      ),
                    ),
                    onTap: (){
                      newProfilePictureDialog(context: context, user: firebaseUser);
                    }
                  ),

                  ElevatedButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.all(10.0)),
                      backgroundColor: MaterialStateProperty.all(Colors.green[600]),
                    ),
                    child: Text(
                      "LATER",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Proxima Nova',
                        fontStyle: FontStyle.normal,
                        fontSize: 15,
                      ),
                    ),
                    onPressed: (){
                      Navigator.of(context).popUntil(ModalRoute.withName(EVInitialScreen.routeName));
                    },
                  ),

                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}