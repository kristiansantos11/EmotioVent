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
  /*Map routes = {EVInitialScreen.routeName : authWrapperRoute(settings),
                EVSignUp.routeName : registrationRoute(settings),
                EVLogin.routeName : loginRoute(settings),
                EVChooseEmotionScreen.routeName : chooseEmotionRoute(settings),
                ActivityRandomizer.routeName : activityRandomizerRoute(settings),
                EVSatisfactoryRate.routeName : satisfactoryRateRoute(settings),
                CameraCapturePreview.routeName : cameraPreviewRoute(settings)};
                
  return routes[settings.name];*/

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

/*
Route<Null> authWrapperRoute(RouteSettings settings){
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
      settings: RouteSettings(name: ActivityRandomizer.routeName),
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
      settings: RouteSettings(name: EVSatisfactoryRate.routeName),
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

Route<Null> cameraPreviewRoute(RouteSettings settings){
  ScreenArguments args = settings.arguments;
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
*/

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
