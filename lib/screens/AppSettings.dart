import 'package:emotiovent/models/UserData.dart';
import 'package:emotiovent/services/EV_AuthService.dart';
import 'package:emotiovent/services/EV_SizeGetter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';
import 'package:emotiovent/services/database/GetStatistics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

class AppSettings extends StatefulWidget {
  @override
  _AppSettingsState createState() => _AppSettingsState();
}

class _AppSettingsState extends State<AppSettings> {

  void _signOut(BuildContext context) async {
    await context
        .read<AuthenticationService>()
        .signOut()
        .then((String successMsg) {
      print(successMsg);
      Phoenix.rebirth(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [

          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/img/StartScreenBG.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: EdgeInsets.all(getHeight(context) / 35),
                    height: getHeight(context) / 4,
                    width: getHeight(context) / 4,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/img/fading-dots.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/img/emotiovent_icon_final.png'),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: getHeight(context)/25,
                  ),
                  Center(
                    child: Text(
                      "emotiovent",
                      style: TextStyle(
                        fontFamily: 'Proxima Nova',
                        fontSize: ResponsiveFlutter.of(context).scale(40.0),
                        fontWeight: FontWeight.w700,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      "Group 7 Media Group",
                      style: TextStyle(
                        height: 0.75,
                        fontFamily: 'Proxima Nova',
                        fontSize: ResponsiveFlutter.of(context).scale(18.0),
                        fontWeight: FontWeight.w700,
                        color: Colors.grey[500],
                      ),
                    ),
                  ),

                  SizedBox(
                    height: getHeight(context)/35,
                  ),

                  Center(
                    child: Text(
                      "Bartolome, Marielle V.",
                      style: TextStyle(
                        fontFamily: 'Proxima Nova',
                        fontSize: ResponsiveFlutter.of(context).scale(13.0),
                        fontWeight: FontWeight.w700,
                        color: Colors.grey[500],
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      "Calayag, Jedidiah David H.",
                      style: TextStyle(
                        fontFamily: 'Proxima Nova',
                        fontSize: ResponsiveFlutter.of(context).scale(13.0),
                        fontWeight: FontWeight.w700,
                        color: Colors.grey[500],
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      "Mendoza, Melissa DL.",
                      style: TextStyle(
                        fontFamily: 'Proxima Nova',
                        fontSize: ResponsiveFlutter.of(context).scale(13.0),
                        fontWeight: FontWeight.w700,
                        color: Colors.grey[500],
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      "Santos, Kristian A.",
                      style: TextStyle(
                        fontFamily: 'Proxima Nova',
                        fontSize: ResponsiveFlutter.of(context).scale(13.0),
                        fontWeight: FontWeight.w700,
                        color: Colors.grey[500],
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      "Veneracion, John Elbert A.",
                      style: TextStyle(
                        fontFamily: 'Proxima Nova',
                        fontSize: ResponsiveFlutter.of(context).scale(13.0),
                        fontWeight: FontWeight.w700,
                        color: Colors.grey[500],
                      ),
                    ),
                  ),
                ],
              ),

              Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Color(0xff73d1af)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
                    ),
                  ),
                  child: Text("Logout"),
                  onPressed:(){_signOut(context);},
                ),
              ),
            ],
          ),
        ]
      ),
    );
  }
}