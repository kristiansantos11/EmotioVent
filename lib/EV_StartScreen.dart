import 'package:flutter/material.dart';

class EVStartScreen extends StatefulWidget {
  @override
  _EVStartScreenState createState() => _EVStartScreenState();
}

class _EVStartScreenState extends State<EVStartScreen> {

  void clickMe(){
    print("Clicked!");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/img/StartScreenBG.jpg"), fit: BoxFit.cover
            )
          ),
          child:
          Padding(
            padding: EdgeInsets.fromLTRB(25,40,12,12),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 40,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      "How\nare\nyou\nfeeling\ntoday?",
                      style: TextStyle(
                        fontFamily: 'SegoeUIBlack',
                        fontSize: 62,
                        height: 1,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w900,
                        color: Color(0xfff308a2)
                      )
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    
                  ]
                ),
                Expanded(
                  child:
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox()
                          ]
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                              child:
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18.0),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 7,
                                      offset: Offset(0, 3), // change shadow position
                                    )
                                  ]
                                ),
                                child:
                                FlatButton(
                                  minWidth: 225.0,
                                  height: 45.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                  ),
                                  color: Color(0xff6dd9eB),
                                  onPressed: () {},
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                                    child:
                                      Text(
                                      "I WANT TO SHARE",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.5,
                                        )
                                      )
                                  )
                                )
                              )
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 15, 0, 50),
                              child:
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18.0),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 7,
                                      offset: Offset(0, 3), // changes position of shadow
                                    )
                                  ],
                                ),
                                child:
                                FlatButton(
                                  minWidth: 225.0,
                                  height: 45.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                  ),
                                  onPressed: () {},
                                  color: Colors.grey[100],
                                  child: 
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
                                      child:
                                        Text(
                                        "LATER",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.5,
                                          )
                                        )
                                    )
                                ),
                              )
                            ),
                          ]
                        ),
                      ],
                    )
                ),
                Container(
                  child: Align(
                    alignment: FractionalOffset.bottomRight,
                    child: Text(
                      "Art:\nPaweł Czerwiński",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                      )
                    )
                  ),
                ),
              ],
            )
          )
        )  
      )
    );  
  }
}