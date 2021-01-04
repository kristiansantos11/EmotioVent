import 'screens/EV_Loading.dart';
import 'screens/EV_AppError.dart';

import 'package:flutter/material.dart';

import 'package:emotiovent/screens/EV_InitialScreen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'services/EV_AuthService.dart';
import 'services/EV_RouteGenerator.dart';

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
          EVLoading.routeName : (context) => EVLoading(),
          EVError.routeName : (context) => EVError(),
        },
        onGenerateRoute: getGenerateRoute,
      )
    );
  }
}

/* 
 * Okay before you get triggered by the length of the elseif statements you are about to witness:
 * My plans for this part is to put all of the PageRouteBuilder along with their respecitve name settings inside a dictionary
 * However, it will require a separate file.
 */



