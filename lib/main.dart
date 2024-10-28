import 'package:best_people/firebase_options.dart';
import 'package:best_people/screens/LoginScreen.dart';
import 'package:best_people/screens/MainAppScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<FirebaseApp>? firebaseApp;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  firebaseApp=Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const BestPeopleApp());
}

class BestPeopleApp extends StatelessWidget{
  const BestPeopleApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Oameni buni',
      home: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(),builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting)
        {
          // return const SplashScreen();
        }
        if(snapshot.hasData)
        {
          return const MainAppScreen();
        }
        else
        {
          return LoginScreen();
        }
      },),
    );
  }
}



