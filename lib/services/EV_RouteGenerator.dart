// RouteGenerator
// TODO: Use switch-case in route generation. Dictionaries are kinda costly.

import 'package:camera/camera.dart';
import 'package:emotiovent/models/ScreenArguments.dart';
import 'package:flutter/material.dart';

import 'package:emotiovent/screens/EV_ChooseEmotionScreen.dart';
import 'package:emotiovent/screens/EV_Login.dart';
import 'package:emotiovent/screens/EV_SatisfactoryRate.dart';
import 'package:emotiovent/screens/EV_SignUp.dart';
import 'package:emotiovent/screens/EV_InitialScreen.dart';
import 'package:emotiovent/screens/CameraCapturePreview.dart';

import 'package:emotiovent/services/EV_ActivityRandomizer.dart';

import 'package:provider/provider.dart';

Route<Null> getGenerateRoute(RouteSettings settings){
  final arguments = settings.arguments;
  switch (settings.name) {

    case EVInitialScreen.routeName:
      return PageRouteBuilder(
        settings: RouteSettings(name: EVInitialScreen.routeName),
        pageBuilder: (context, animation, secondaryAnimation){
          return ListenableProvider(
            create: (context) => animation,
            child: EVInitialScreen(),
          );
        },
        transitionDuration: const Duration(milliseconds: 400),
      );
    
    case EVSignUp.routeName:
      ScreenArguments args = arguments;
      return PageRouteBuilder(
        settings: RouteSettings(name: EVSignUp.routeName),
        pageBuilder: (context, animation, secondaryAnimation){
          return ListenableProvider(
            create: (context) => animation,
            child: EVSignUp(emotion: args.emotion),
          );
        },
        transitionDuration: const Duration(milliseconds: 1000),
        transitionsBuilder: (context, animation, secondAniamtion, child){
          animation = CurvedAnimation(
            curve: Curves.easeInOut, parent: animation
          );
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        }
      );
    
    case EVLogin.routeName:
      return PageRouteBuilder(
        settings: RouteSettings(name: EVLogin.routeName), // To make popUntil work.
        pageBuilder: (context, animation, secondaryAnimation){
          return ListenableProvider(
            create: (context) => animation,
            child: EVLogin(),
          );
        },
        transitionDuration: const Duration(milliseconds: 1000),
        transitionsBuilder:(context, animation, secondAnimation, child){ // FadeAnimation executes the same time as Hero animation
          animation = CurvedAnimation(
              curve: Curves.easeInOut, parent: animation
            );
          return FadeTransition(
            opacity:animation,
            child: child,
          );
        }
      );
    
    case EVChooseEmotionScreen.routeName:
      return PageRouteBuilder(
        settings: RouteSettings(name: EVChooseEmotionScreen.routeName),
        pageBuilder: (context, animation, secondaryAnimation) {
          return ListenableProvider(
            create: (context) => animation,
            child: EVChooseEmotionScreen(),
          );
        },
        transitionDuration: const Duration(milliseconds: 1000),
        transitionsBuilder: (context ,animation, secondAnimation, child){
          animation = CurvedAnimation(
            curve: Curves.easeInOut, parent: animation
          );
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        }
      );

    case ActivityRandomizer.routeName:
      ScreenArguments args = arguments;
      return PageRouteBuilder(
        settings: RouteSettings(name: ActivityRandomizer.routeName),
        pageBuilder: (context, animation, secondaryAnimation){
          return ListenableProvider(
            create: (context) => animation,
            child: ActivityRandomizer(emotion: args.emotion),
          );
        },
        transitionDuration: const Duration(milliseconds: 1000),
        transitionsBuilder: (context, animation, secondAnimation, child){
          animation = CurvedAnimation(
            curve: Curves.easeInOut, parent: animation
          );
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        }
      );

    case EVSatisfactoryRate.routeName:
      ScreenArguments args = arguments;
      return PageRouteBuilder(
        settings: RouteSettings(name: EVSatisfactoryRate.routeName),
        pageBuilder: (context, animation, secondAnimation){
          return ListenableProvider(
            create: (context) => animation,
            child: EVSatisfactoryRate(emotion: args.emotion),
          );
        },
        transitionDuration: const Duration(milliseconds: 1000),
        transitionsBuilder: (context, animation, secondAnimation, child){
          animation = CurvedAnimation(
            curve: Curves.easeInOut, parent: animation
          );
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        }
      );

    case CameraCapturePreview.routeName:
      ScreenArguments args = arguments;
      return PageRouteBuilder(
        settings: RouteSettings(name: EVSatisfactoryRate.routeName),
        pageBuilder: (context, animation, secondAnimation){
          return ListenableProvider(
            create: (context) => animation,
            child: CameraCapturePreview(emotion: args.emotion, imgPath: args.imgPath),
          );
        },
        transitionDuration: const Duration(milliseconds: 1000),
        transitionsBuilder: (context, animation, secondAnimation, child){
          Animation<Offset> animationSlide;
          animationSlide = Tween<Offset>(begin:Offset(1.0, 0),end: Offset.zero).animate(CurvedAnimation(curve: Curves.easeInOut, parent: animation));
          return SlideTransition(
            position: animationSlide,
            child: child,
          );
        }
      );

  }
}