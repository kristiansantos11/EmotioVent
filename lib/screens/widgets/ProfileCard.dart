import 'package:emotiovent/services/EV_SizeGetter.dart';
import 'package:flutter/material.dart';

Widget profileCard({Widget child, BuildContext context}){
  return Stack(
    children: <Widget>[

      Positioned.fill(
        child: Container()
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
                    child: Container(
                      width: 100,
                      height: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                          ),
                        )
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