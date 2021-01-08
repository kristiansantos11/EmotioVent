import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'package:emotiovent/screens/EV_ChooseEmotionScreen.dart';
import 'package:emotiovent/screens/EV_Login.dart';
import 'package:emotiovent/screens/EV_SatisfactoryRate.dart';
import 'package:emotiovent/screens/EV_SignUp.dart';
import 'package:emotiovent/screens/EV_InitialScreen.dart';

import 'package:emotiovent/services/EV_ActivityRandomizer.dart';

import 'package:provider/provider.dart';

class ActivityRandomizerArguments{
  final String emotion;
  final List<CameraDescription> cameras;

  ActivityRandomizerArguments(this.emotion, this.cameras);
}


Route<Null> authWrapperRoute(RouteSettings settings){
  return PageRouteBuilder(
    settings: RouteSettings(name: EVAuthWrapper.routeName), // To make popUntil work.
    pageBuilder: (context, animation, secondaryAnimation){
      return ListenableProvider(
        create: (context) => animation,
        child: EVAuthWrapper(),
      );
    },
    transitionDuration: const Duration(milliseconds: 400),
  );
}

Route<Null> registrationRoute(RouteSettings settings){
    String emotion = settings.arguments;
    return PageRouteBuilder(
      settings: RouteSettings(name: EVSignUp.routeName, arguments: emotion),
      pageBuilder: (context, animation, secondaryAnimation){
        return ListenableProvider(
          create: (context) => animation,
          child: EVSignUp(emotion: emotion),
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
}

Route<Null> loginRoute(RouteSettings settings){
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
}

Route<Null> chooseEmotionRoute(RouteSettings settings){
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
}

Route<Null> activityRandomizerRoute(RouteSettings settings){
  final String emotion = settings.arguments;
    return PageRouteBuilder(
      settings: RouteSettings(name: ActivityRandomizer.routeName, arguments: emotion),
      pageBuilder: (context, animation, secondaryAnimation){
        return ListenableProvider(
          create: (context) => animation,
          child: ActivityRandomizer(emotion: emotion),
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
}

Route<Null> satisfactoryRateRoute(RouteSettings settings){
  String emotion = settings.arguments;
    return PageRouteBuilder(
      settings: RouteSettings(name: EVSatisfactoryRate.routeName, arguments: emotion),
      pageBuilder: (context, animation, secondAnimation){
        return ListenableProvider(
          create: (context) => animation,
          child: EVSatisfactoryRate(emotion: emotion),
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
}

Route<Null> getGenerateRoute(RouteSettings settings){
  Map routes = {EVAuthWrapper.routeName : authWrapperRoute(settings),
                EVSignUp.routeName : registrationRoute(settings),
                EVLogin.routeName : loginRoute(settings),
                EVChooseEmotionScreen.routeName : chooseEmotionRoute(settings),
                ActivityRandomizer.routeName : activityRandomizerRoute(settings),
                EVSatisfactoryRate.routeName : satisfactoryRateRoute(settings),
                };
                
  return routes[settings.name];
}


  

  // For AuthWrapper Route
  /*
  if(settings.name == EVAuthWrapper.routeName){
    return PageRouteBuilder(
      settings: RouteSettings(name: EVAuthWrapper.routeName), // To make popUntil work.
      pageBuilder: (context, animation, secondaryAnimation){
        return ListenableProvider(
          create: (context) => animation,
          child: EVAuthWrapper(),
        );
      },
      transitionDuration: const Duration(milliseconds: 400),
    );
  }
  

  // For Registration route
  else if(settings.name == EVSignUp.routeName){
    String emotion = settings.arguments;
    return PageRouteBuilder(
      settings: RouteSettings(name: EVSignUp.routeName, arguments: emotion),
      pageBuilder: (context, animation, secondaryAnimation){
        return ListenableProvider(
          create: (context) => animation,
          child: EVSignUp(emotion: emotion),
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
  }
  
  // For Login Route
  else if(settings.name == EVLogin.routeName){
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
  }

  // For Choose Emotion Screen route
  else if(settings.name == EVChooseEmotionScreen.routeName){
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
  } 
  
  // For Activity Randomizer route
  else if(settings.name == ActivityRandomizer.routeName){
    String emotion = settings.arguments;
    return PageRouteBuilder(
      settings: RouteSettings(name: ActivityRandomizer.routeName, arguments: emotion),
      pageBuilder: (context, animation, secondaryAnimation){
        return ListenableProvider(
          create: (context) => animation,
          child: ActivityRandomizer(emotion: emotion),
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
  }

  // For Satisfactory Rate route
  else if(settings.name == EVSatisfactoryRate.routeName){
    String emotion = settings.arguments;
    return PageRouteBuilder(
      settings: RouteSettings(name: EVSatisfactoryRate.routeName, arguments: emotion),
      pageBuilder: (context, animation, secondAnimation){
        return ListenableProvider(
          create: (context) => animation,
          child: EVSatisfactoryRate(emotion: emotion),
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
  }

  else { return null; }
  */
