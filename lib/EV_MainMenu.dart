import 'package:flutter/material.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:provider/provider.dart';

import 'EV_AuthService.dart';

class EVMainMenu extends StatefulWidget {
  @override
  _EVMainMenuState createState() => _EVMainMenuState();
}

class _EVMainMenuState extends State<EVMainMenu> {

  void _signOut(){
    context.read<AuthenticationService>().signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/img/MainMenu.jpg"), fit: BoxFit.cover
                )
              ),
            ),

          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                tileMode: TileMode.repeated,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Colors.grey.withAlpha(25),
                  Colors.black87,
                ]
              )
            ),
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              Text(
                "Emotiovent is currently in-development.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: ResponsiveFlutter.of(context).scale(20),
                  fontFamily: 'Nexa',
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                )
              ),

              SizedBox(height: ResponsiveFlutter.of(context).scale(15),),

              RaisedButton(
                padding: EdgeInsets.fromLTRB(
                  ResponsiveFlutter.of(context).scale(0),
                  ResponsiveFlutter.of(context).scale(10),
                  ResponsiveFlutter.of(context).scale(0),
                  ResponsiveFlutter.of(context).scale(10)
                ),
                onPressed: () {_signOut();},
                child: Text(
                  "LOGOUT",
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),

              SizedBox(height: ResponsiveFlutter.of(context).scale(15),),

              Text(
                "Please check back later!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: ResponsiveFlutter.of(context).scale(12),
                  fontFamily: 'Nexa',
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                )
              ),

            ]
          ),

        ],
      ),
    );
  }
}