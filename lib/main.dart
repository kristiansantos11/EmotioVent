import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emotiovent/screens/EV_ChooseEmotionScreen.dart';
import 'package:emotiovent/screens/EV_Login.dart';
import 'package:emotiovent/screens/EV_MainMenu.dart';
import 'package:emotiovent/screens/EV_SatisfactoryRate.dart';
import 'package:emotiovent/screens/EV_SignUp.dart';

import 'screens/EV_Loading.dart';
import 'screens/EV_AppError.dart';
import 'screens/EV_StartScreen.dart';

import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'services/EV_AuthService.dart';
import 'services/EV_ActivityRandomizer.dart';

import 'activities/ShakePhoneScreen.dart';
import 'activities/NoiseMeterSample.dart';
import 'activities/ShakeShowAnimals.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  
  // This widget is the root of your application.
  // REMINDER: Please do not remove the debug flag yet (at the top-right of the screen.)
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<AuthenticationService>().authStateChanges,
        ),
      ],
      child: MaterialApp(
        
        title: 'emotiovent',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: EVAuthWrapper.routeName,
        
        // TODO: Move all routes into their respective generators inside the getGenerateRoute function.
        routes: {
          EVSignUp.routeName : (context) => EVSignUp(),
          EVLoading.routeName : (context) => EVLoading(),
          EVError.routeName : (context) => EVError(),
          ShakePhoneActivity.routeName : (context) => ShakePhoneActivity(),
          NoiseMeterSample.routeName : (context) => NoiseMeterSample(),
          ShakeShowAnimals.routeName : (context) => ShakeShowAnimals(),
        },
        onGenerateRoute: getGenerateRoute,
      )
    );
  }
}

class EVAuthWrapper extends StatelessWidget {
  static const routeName = '/main';

  const EVAuthWrapper({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    // Using ternary operators here makes the code less readable
    // Use it if every one of your members are familiarized with its usage.
    if (firebaseUser != null){
      return EVMainMenu();
    } else {
      return EVStartScreen();
    }
  }
}

Route<Null> getGenerateRoute(RouteSettings settings){
  // For AuthWrapper Route
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
    String text = settings.arguments;
    return PageRouteBuilder(
      settings: RouteSettings(name: ActivityRandomizer.routeName, arguments: text),
      pageBuilder: (context, animation, secondaryAnimation){
        return ListenableProvider(
          create: (context) => animation,
          child: ActivityRandomizer(emotion: text),
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
    String text = settings.arguments;
    return PageRouteBuilder(
      settings: RouteSettings(name: EVSatisfactoryRate.routeName, arguments: text),
      pageBuilder: (context, animation, secondaryAnimation){
        return ListenableProvider(
          create: (context) => animation,
          child: EVSatisfactoryRate(emotion: text),
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
}

