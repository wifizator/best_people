import 'dart:developer';

import 'package:best_people/firebase_options.dart';
import 'package:best_people/screens/LoginScreen.dart';
import 'package:best_people/screens/MainAppScreen.dart';
import 'package:best_people/screens/SplashScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    runApp(const BestPeopleApp());
  } on FirebaseException catch (error) {
    //todo: Add error screen
    log(error.toString(), stackTrace: error.stackTrace);
  }
}

class BestPeopleApp extends StatelessWidget {
  const BestPeopleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Om bun',
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.userChanges(),
        initialData: FirebaseAuth.instance.currentUser,
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          // Check if user is logged in
          final String? uid = snapshot.data?.uid;
          print('uid is ${uid}');

          if (uid != null) {
            print('Main app screen starting');
            return MainAppScreen();
          } else {
            print('Login screen starting');
            return LoginScreen();
          }
        },
      ),
    );
  }
}
