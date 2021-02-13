import 'package:emotiovent/models/ScreenArguments.dart';
import 'package:flutter/material.dart';

import 'package:emotiovent/services/EV_SizeGetter.dart';
import 'package:emotiovent/services/EV_FetchAnimalPictures.dart';
import 'package:emotiovent/models/AnimalPicture.dart';
import 'package:emotiovent/screens/EV_SatisfactoryRate.dart';

import 'package:shake/shake.dart';

import 'dart:async';

class ShakeShowAnimals extends StatefulWidget {
  static const routeName = "/shake4animal";

  final String emotion;

  const ShakeShowAnimals({Key key, this.emotion}) : super(key: key);

  @override
  _ShakeShowAnimalsState createState() => _ShakeShowAnimalsState(emotion);
}

class _ShakeShowAnimalsState extends State<ShakeShowAnimals> with TickerProviderStateMixin{
  final String emotion;

  _ShakeShowAnimalsState(this.emotion);

  String activityName = "Shake to show animals!";
  ShakeDetector _shakeDetector;
  bool _showContent = false;

  List<Image> pics;
  Future<List<AnimalPicture>> animalPictures;

  bool _shaken = false;

  AnimationController controller;
  Animation<double> animation;

  @override
  void initState(){
    super.initState();
    animalPictures = fetchAnimalPictures();

    Timer(
      const Duration(milliseconds: 1000),
      () {
        setState((){
          _showContent = true;
        });
      }
    );

    _shakeDetector = ShakeDetector.autoStart(
      shakeCountResetTime: 1000,
      onPhoneShake: () {
        setState((){
          _shaken = true;
        });
      },
    );
  }

  @override
  void dispose(){
    _shakeDetector.stopListening();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[

          Hero(
            tag: emotion,
            child: Container(
              width: getWidth(context),
              height: getHeight(context),
              color: Colors.white,
            ),
          ),

          AnimatedOpacity(
            opacity: _showContent ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 1000),
            child: SafeArea(
              child: AnimatedSwitcher(
                duration: Duration(seconds: 1),
                child: _shaken ? FutureBuilder( // If shaken is false, the Center widget with text: "Shake the phone..." will show up.
                  future: animalPictures,
                  builder: (context, snapshot){
                    if (snapshot.hasError) {
                      return Center(child: Text("${snapshot.error}"));
                    } else if (snapshot.hasData) {
                      return GridView.builder(
                        itemCount: snapshot.data.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 5.0,
                          mainAxisSpacing: 5.0,
                        ),
                        itemBuilder: (context, index) {
                          return Center(
                            child: AspectRatio(
                              aspectRatio: 1/1, // 1:1 -> Square
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                color: Colors.white,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: FadeInImage.assetNetwork(
                                    placeholder: 'assets/img/no_image.png',
                                    image: snapshot.data[index].link,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          );

                        },
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }
                ) : Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [

                        Text(
                          "Shake the phone to see animal pictures!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.aspectRatio * 50,
                            fontFamily: 'Roboto',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w900,
                          )
                        ),

                        Center(
                          child: Container(
                            width: getWidth(context) / 2,
                            height: getWidth(context) / 2,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/img/shake-phone.png'),
                                fit: BoxFit.cover
                              )
                            )
                          )
                        ),

                      ]
                    ),

              )
            )
          ),

        ],
      ),
      floatingActionButton: AnimatedOpacity(
        opacity: _shaken ? 1.0 : 0.0,
        duration: Duration(seconds: 1),
        child: FloatingActionButton.extended(
          heroTag: null,
          label: Text("Continue", style: TextStyle(fontFamily: 'Roboto', fontStyle: FontStyle.normal)),
          icon: Icon(Icons.play_arrow),
          backgroundColor: Colors.orange[600],
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(
              EVSatisfactoryRate.routeName,
              arguments: ScreenArguments(emotion: emotion, activity: activityName)
            );
          }
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}