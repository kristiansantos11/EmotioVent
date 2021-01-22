// RouteGenerator
/* This exists for:
 *
 * -> Widget screens that require unique arguments
 * -> Custom transition animations
 * -> Efficient route navigation
 * 
 */

import 'package:emotiovent/models/ScreenArguments.dart';
import 'package:emotiovent/screens/EV_ViewProfilePicture.dart';
import 'package:emotiovent/screens/ExplainBeforeRegister.dart';
import 'package:emotiovent/screens/widgets/CaptureSurroundingsPreview.dart';
import 'package:flutter/material.dart';

import 'package:emotiovent/screens/EV_ChooseEmotionScreen.dart';
import 'package:emotiovent/screens/EV_Login.dart';
import 'package:emotiovent/screens/EV_SatisfactoryRate.dart';
import 'package:emotiovent/screens/EV_SignUp.dart';
import 'package:emotiovent/screens/EV_InitialScreen.dart';
import 'package:emotiovent/screens/widgets/SelfieCameraCapturePreview.dart';

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
      break;
    
    case EVSignUp.routeName:
      ScreenArguments args = arguments;
      return PageRouteBuilder(
        settings: RouteSettings(name: EVSignUp.routeName),
        pageBuilder: (context, animation, secondaryAnimation){
          return ListenableProvider(
            create: (context) => animation,
            child: EVSignUp(emotion: args != null ? args.emotion : null),
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
      break;
    
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
      break;
    
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
      break;

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
      break;

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
      break;

    case SelfieCameraCapturePreview.routeName:
      ScreenArguments args = arguments;
      return PageRouteBuilder(
        settings: RouteSettings(name: SelfieCameraCapturePreview.routeName),
        pageBuilder: (context, animation, secondAnimation){
          return ListenableProvider(
            create: (context) => animation,
            child: SelfieCameraCapturePreview(emotion: args.emotion, imgPath: args.imgPath),
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
    
    case CaptureSurroundingsPreview.routeName:
      ScreenArguments args = arguments;
      return PageRouteBuilder(
        settings: RouteSettings(name: CaptureSurroundingsPreview.routeName),
        pageBuilder: (context, animation, secondAnimation){
          return ListenableProvider(
            create: (context) => animation,
            child: CaptureSurroundingsPreview(emotion: args.emotion, imgPath: args.imgPath),
          );
        },
        transitionDuration: const Duration(milliseconds: 1000),
        transitionsBuilder: (context, animation, secondAnimation, child){
          Animation<Offset> animationSlide;
          animationSlide = Tween<Offset>(
            begin: Offset(1.0, 0), end: Offset.zero
          ).animate(CurvedAnimation(parent: animation, curve: Curves.easeInOut));
          return SlideTransition(
            position: animationSlide,
            child: child,
          );
        }
      );
    
    case EVViewProfilePicture.routeName:
      return PageRouteBuilder(
        settings: RouteSettings(name: EVViewProfilePicture.routeName),
        pageBuilder: (context, animation, secondAnimation){
          return ListenableProvider(
            create: (context) => animation,
            child: EVViewProfilePicture(),
          );
        },
        transitionDuration: const Duration(milliseconds: 1000),
        transitionsBuilder: (context, animation, secondAnimation, child){
          animation = CurvedAnimation(curve: Curves.easeInOut, parent: animation);
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        }
      );
    
    case ExplainBeforeRegister.routeName:
      return PageRouteBuilder(
        settings: RouteSettings(name: ExplainBeforeRegister.routeName),
        pageBuilder: (context, animation, secondAnimation){
          return ListenableProvider(
            create: (context) => animation,
            child: ExplainBeforeRegister(),
          );
        },
        transitionDuration: const Duration(milliseconds: 1000),
        transitionsBuilder: (context, animation, secondAnimation, child){
          animation = CurvedAnimation(curve: Curves.easeInOut, parent: animation);
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        }
      );

  }
  return null;
}