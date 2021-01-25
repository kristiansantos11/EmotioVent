import 'package:emotiovent/models/UserInfo.dart';
import 'package:emotiovent/services/FirestoreService.dart';
import 'package:flutter/material.dart';

import 'package:emotiovent/screens/EV_InitialScreen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'services/EV_AuthService.dart';
import 'services/EV_RouteGenerator.dart';

import 'services/database/fetchUserData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  // This widget is the root of your application.
  // REMINDER: Please do not remove the debug flag yet (at the top-right of the screen.)
  // Don't mind the noticeable lag, this is normal in debug mode of flutter apps

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
          primarySwatch: Colors.pink,
        ),
        initialRoute: EVInitialScreen.routeName,
        
        // TODO: Move all routes into their respective generators inside the getGenerateRoute function.
        onGenerateRoute: getGenerateRoute,
      )
    );
  }
}
