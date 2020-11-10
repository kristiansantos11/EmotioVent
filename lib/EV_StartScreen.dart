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
        child: Padding(
          padding: EdgeInsets.fromLTRB(25,12,12,12),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 40,
              ),
              Row(
                children: <Widget>[
                  Text(
                    "How\nAre\nYou\nFeeling\nToday?",
                    style: TextStyle(
                      fontSize: 60,
                      height: 1.05,
                      fontWeight: FontWeight.bold,
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
                            padding: EdgeInsets.fromLTRB(0,0,0,0),
                            child:
                            FlatButton(
                              color: Colors.blue[300],
                              onPressed: () {},
                              child: Text(
                                "I WANT TO SHARE",
                                style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5,
                                )
                              )
                            )
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 15, 0, 50),
                            child: 
                            FlatButton(
                              onPressed: () {},
                              color: Colors.grey[300],
                              child: Text(
                                "LATER",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.5,
                                )
                              )
                            ),
                          ),
                        ]
                      ),
                    ],
                  )
              )
            ],
          )
        )  
      )
    );  
  }
}