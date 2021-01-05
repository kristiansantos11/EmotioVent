import 'package:flutter/material.dart';

import 'package:emotiovent/services/EV_SizeGetter.dart';
import 'package:emotiovent/services/EV_FetchAnimalPictures.dart';
import 'package:emotiovent/models/cute_animal_img.dart';
import 'package:emotiovent/screens/EV_SatisfactoryRate.dart';

import 'package:shake/shake.dart';

import 'dart:math';
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

  ShakeDetector _shakeDetector;
  bool _showContent = false;

  // START
  // ::For experimentation purposes::
  List<Color> colors = [Colors.red[300], Colors.blue[300], Colors.yellow[300], Colors.orange[300]];
  Random rand = new Random();
  List<Image> pics;
  Future<List<AnimalPicture>> animalPictures;
  // END

  bool _showFAB = false;

  AnimationController controller;
  Animation<double> animation;

  @override
  void initState(){
    super.initState();
    animalPictures = fetchAnimalPictures();

    controller = AnimationController(vsync: this, duration: Duration(seconds: 1));
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(curve: Curves.easeInOut, parent: controller));

    Timer(
      const Duration(milliseconds: 1000),
      () {
        setState((){
          _showContent = true;
        });
      }
    );

    _shakeDetector = ShakeDetector.autoStart(

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
              child: 
                FutureBuilder(
                  future: animalPictures,
                  builder: (context, snapshot){
                    if (snapshot.hasError){
                      return Center(child: Text("${snapshot.error}"));
                    } else if (snapshot.hasData) {
                      _showFAB = true;
                      return GridView.builder(
                        itemCount: snapshot.data.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 5.0,
                          mainAxisSpacing: 5.0,
                        ),
                        itemBuilder: (context, index){
                          controller.forward();

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
                )
              )
            ),

        ],
      ),
      floatingActionButton: AnimatedOpacity(
        opacity: _showFAB ? 1.0 : 0.0,
        duration: Duration(seconds: 1),
        child: FloatingActionButton(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.play_arrow),
            ],
          ),
          backgroundColor: Colors.green[600],
          onPressed: () {Navigator.of(context).pushNamed(EVSatisfactoryRate.routeName, arguments: emotion);}
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}