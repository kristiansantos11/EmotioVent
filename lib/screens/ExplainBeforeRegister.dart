import 'package:emotiovent/screens/EV_ChooseEmotionScreen.dart';
import 'package:emotiovent/screens/EV_SignUp.dart';
import 'package:emotiovent/services/EV_SizeGetter.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
//import 'package:provider/provider.dart';
import 'widget_transition/SlideFadeInText.dart';

class ExplainBeforeRegister extends StatelessWidget {
  static const routeName = '/explainBeforeRegister';

  final msDuration = 500;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea (
            child: Stack (
                   children: <Widget> [ 

                        Padding(
                          padding: const EdgeInsets.fromLTRB(90,0,0,0),
                          child: Column(
                            children: [
                              ShowUp(
                                  delay: msDuration,
                                  child: Container(
                                  width: 200,
                                  height: 250,
                                  decoration: BoxDecoration(
                                  image: DecorationImage (
                                  image: AssetImage("assets/img/fading-dots.png"),
                                  )
                                  ), 
                                  ),
                                ),
                            ],
                          ),
                        ),
                   
                   Container(
                    decoration: BoxDecoration(
                    image: DecorationImage(
                    image: AssetImage("assets/img/ss-bg-redyellow.png"),
                    fit: BoxFit.cover
                    )
                    )
                    ),

                    Container(
                    decoration: BoxDecoration(
                    image: DecorationImage(
                    image: AssetImage("assets/img/ebr-bg-green.png"),
                    fit: BoxFit.cover
                    )
                    )
                    ),

                    Container(
                      decoration: BoxDecoration(
                      image: DecorationImage(
                      image: AssetImage("assets/img/ss-deco.png"),
                      ), 
                      )  
                      ),
                    
                    Opacity(
                      opacity: 0.5,
                                  child: Container(
                        decoration: BoxDecoration(
                        image: DecorationImage(
                        image: AssetImage("assets/img/ss-deco2.png"),
                        ), 
                        )  
                        ),
                    ),
                    
                    
                      
                  
                
                      
                  
                  SafeArea(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                        getWidth(context)/8, 
                        getWidth(context)/17, 
                        getWidth(context)/8, 
                        getWidth(context)/9),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[

                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[

                              ShowUp(
                                delay: msDuration,
                                child: Container(
                                  width: getWidth(context)/3,
                                  height: getWidth(context)/3,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('assets/img/emotiovent_icon_final.png'),
                                    )
                                  ),
                                ),
                              ),

                              SizedBox(
                                height: getHeight(context) / 25,
                              ),

                              ShowUp(
                                delay: msDuration + 100,
                                child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    text: "Welcome to\n",
                                    style: TextStyle(
                                      fontFamily: 'Proxima Nova',
                                      fontSize: 32,
                                      color: Color.fromARGB(225, 56, 70, 127),
                                    ),
                                    children: <InlineSpan>[
                                      TextSpan(
                                        text: "emotiovent",
                                        style: TextStyle(
                                          fontFamily: 'Nexa',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 50,
                                          color: Color.fromARGB(225, 56, 70, 127),
                                          height: 0.90,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              SizedBox(
                                height: getHeight(context) / 30,
                              ),

                              ShowUp(
                                delay: msDuration + 300,
                                child: Text(
                                  "An app where you can vent your emotions and track them for your mental and emotional health awareness.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'Proxima Nova',
                                    fontSize: 16,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ),

                            ],
                          ),

                          ShowUp(
                                delay: msDuration + 500,
                                child: Column(
                                  children: <Widget>[

                                    Text(
                                      "Would you like to register immediately or see the activities for venting out first?",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'Proxima Nova',
                                        fontSize: 14,
                                        color: Colors.grey[600],
                                      ),
                                    ),

                                    ButtonBar(
                                      alignment: MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[

                                        TextButton(
                                          style: ButtonStyle(
                                            minimumSize: MaterialStateProperty.all<Size>(
                                              Size(getWidth(context)/3.5,getWidth(context)/10)
                                            ),
                                            shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(18.0),
                                                side: BorderSide(
                                                  color: Color(0xfff77272),
                                                  width: 2.0
                                                )
                                              )
                                            ),
                                          ),
                                          child: Text(
                                            "REGISTER",
                                            style: TextStyle(
                                              fontFamily: 'Nexa',
                                              fontWeight: FontWeight.w700,
                                              color: Color(0xfff77272)
                                            )
                                          ),
                                          onPressed: (){
                                            Navigator.of(context).pushNamed(EVSignUp.routeName);
                                          },
                                        ),

                                        ElevatedButton(
                                          style: ButtonStyle(
                                            minimumSize: MaterialStateProperty.all<Size>(
                                              Size(getWidth(context)/3.5,getWidth(context)/10)
                                            ),
                                            backgroundColor: MaterialStateProperty.all<Color>(Color(0xfff77272)),
                                            shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(18.0),
                                              )
                                            ),
                                          ),
                                          child: Text(
                                            "SHOW ME",
                                            style: TextStyle(
                                              fontFamily: 'Nexa', 
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white,
                                            )
                                          ),
                                          onPressed: (){
                                            Navigator.of(context).pushNamed(EVChooseEmotionScreen.routeName);
                                          },
                                        ),
                                        
                                      ]
                                    )
                                  ]
                                ),
                              ),


                          
                          
                          
                        ],
                      ),
                    ),
                  ),

                      
                      ],
        ),
          ),
            
      
       
    );
  }
}

/*
class AnimatedText extends StatelessWidget {
  final double initialOffsetX;
  final double intervalStart;
  final double intervalEnd;
  final String text;
  final TextStyle style;

  const AnimatedText({
    Key key,
    this.initialOffsetX,
    this.intervalStart,
    this.intervalEnd, 
    this.text, 
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final animation = Provider.of<Animation<double>>(context, listen: false);

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child){
        return SlideTransition(
          position: Tween<Offset>(
            begin: Offset(initialOffsetX, 0),
            end: Offset(0, 0),
          ).animate(
            CurvedAnimation(
              curve: Interval(intervalStart, intervalEnd,
                curve: Curves.easeInOutQuad),
              parent: animation,
            ),
          )..addStatusListener((status) => {
            // TODO: Optional if you want something to happen after the animation is done.
          }),
          child: child,
        );
      },
      child: Text(
        text,
        textAlign: TextAlign.left,
        style: style
      ),
    );
  }
}
*/